import 'dart:math';

import 'package:shared_models/shared_models.dart';

class RecipeMetrics {
  const RecipeMetrics({
    required this.originalGravity,
    required this.finalGravity,
    required this.abv,
    required this.ibu,
    required this.srm,
  });

  final double originalGravity;
  final double finalGravity;
  final double abv;
  final double ibu;
  final double srm;
}

class BrewingMath {
  const BrewingMath._();

  static RecipeMetrics calculate(RecipeModel recipe) {
    final originalGravity = _calculateOriginalGravity(recipe);
    final finalGravity = _calculateFinalGravity(
      originalGravity,
      recipe.attenuationPct,
    );
    final ibu = _calculateIbu(recipe, originalGravity);
    final srm = _calculateSrm(recipe);

    return RecipeMetrics(
      originalGravity: originalGravity,
      finalGravity: finalGravity,
      abv: (originalGravity - finalGravity) * 131.25,
      ibu: ibu,
      srm: srm,
    );
  }

  static double _calculateOriginalGravity(RecipeModel recipe) {
    final volumeGallons = recipe.batchSizeLiters / 3.78541;
    final totalPoints = recipe.fermentables.fold<double>(0, (sum, fermentable) {
      final weightPounds = fermentable.weightKg * 2.20462;
      return sum + fermentable.potentialPpg * weightPounds;
    });

    final efficiency = recipe.efficiencyPct / 100;
    return 1 + ((totalPoints * efficiency) / volumeGallons) / 1000;
  }

  static double _calculateFinalGravity(
      double originalGravity, double attenuationPct) {
    return 1 + ((originalGravity - 1) * (1 - (attenuationPct / 100)));
  }

  static double _calculateIbu(RecipeModel recipe, double originalGravity) {
    if (recipe.hops.isEmpty) {
      return 0;
    }

    return recipe.hops.fold<double>(0, (sum, hop) {
      final utilization = 1.65 *
          pow(0.000125, originalGravity - 1) *
          ((1 - exp(-0.04 * hop.boilMinutes)) / 4.15);
      final alphaAcids = hop.weightG * (hop.alphaAcidPct / 100);
      final ibu = (alphaAcids * utilization * 1000) / recipe.batchSizeLiters;
      return sum + ibu;
    });
  }

  static double _calculateSrm(RecipeModel recipe) {
    if (recipe.fermentables.isEmpty) {
      return 0;
    }

    final volumeGallons = recipe.batchSizeLiters / 3.78541;
    final mcu = recipe.fermentables.fold<double>(0, (sum, fermentable) {
      final weightPounds = fermentable.weightKg * 2.20462;
      return sum + ((fermentable.colorLovibond * weightPounds) / volumeGallons);
    });

    return 1.4922 * pow(mcu, 0.6859);
  }
}
