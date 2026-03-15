class FermentableAddition {
  const FermentableAddition({
    required this.name,
    required this.weightKg,
    required this.potentialPpg,
    required this.colorLovibond,
  });

  final String name;
  final double weightKg;
  final double potentialPpg;
  final double colorLovibond;

  Map<String, dynamic> toJson() => {
    'name': name,
    'weightKg': weightKg,
    'potentialPpg': potentialPpg,
    'colorLovibond': colorLovibond,
  };

  factory FermentableAddition.fromJson(Map<String, dynamic> json) =>
      FermentableAddition(
        name: json['name'] as String? ?? '',
        weightKg: (json['weightKg'] as num?)?.toDouble() ?? 0,
        potentialPpg: (json['potentialPpg'] as num?)?.toDouble() ?? 37,
        colorLovibond: (json['colorLovibond'] as num?)?.toDouble() ?? 2,
      );
}

class HopAddition {
  const HopAddition({
    required this.name,
    required this.weightG,
    required this.alphaAcidPct,
    required this.boilMinutes,
  });

  final String name;
  final double weightG;
  final double alphaAcidPct;
  final double boilMinutes;

  Map<String, dynamic> toJson() => {
    'name': name,
    'weightG': weightG,
    'alphaAcidPct': alphaAcidPct,
    'boilMinutes': boilMinutes,
  };

  factory HopAddition.fromJson(Map<String, dynamic> json) => HopAddition(
    name: json['name'] as String? ?? '',
    weightG: (json['weightG'] as num?)?.toDouble() ?? 0,
    alphaAcidPct: (json['alphaAcidPct'] as num?)?.toDouble() ?? 5,
    boilMinutes: (json['boilMinutes'] as num?)?.toDouble() ?? 60,
  );
}

class RecipeModel {
  const RecipeModel({
    required this.id,
    required this.name,
    required this.style,
    required this.beverageType,
    required this.batchSizeLiters,
    required this.efficiencyPct,
    required this.attenuationPct,
    required this.notes,
    required this.fermentables,
    required this.hops,
  });

  final String id;
  final String name;
  final String style;
  final String beverageType;
  final double batchSizeLiters;
  final double efficiencyPct;
  final double attenuationPct;
  final String notes;
  final List<FermentableAddition> fermentables;
  final List<HopAddition> hops;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'style': style,
    'beverageType': beverageType,
    'batchSizeLiters': batchSizeLiters,
    'efficiencyPct': efficiencyPct,
    'attenuationPct': attenuationPct,
    'notes': notes,
    'fermentables': fermentables.map((item) => item.toJson()).toList(),
    'hops': hops.map((item) => item.toJson()).toList(),
  };

  factory RecipeModel.fromJson(Map<String, dynamic> json) => RecipeModel(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    style: json['style'] as String? ?? '',
    beverageType: json['beverageType'] as String? ?? 'Beer',
    batchSizeLiters: (json['batchSizeLiters'] as num?)?.toDouble() ?? 20,
    efficiencyPct: (json['efficiencyPct'] as num?)?.toDouble() ?? 72,
    attenuationPct: (json['attenuationPct'] as num?)?.toDouble() ?? 76,
    notes: json['notes'] as String? ?? '',
    fermentables: ((json['fermentables'] as List<dynamic>?) ?? [])
        .map(
          (item) => FermentableAddition.fromJson(item as Map<String, dynamic>),
        )
        .toList(),
    hops: ((json['hops'] as List<dynamic>?) ?? [])
        .map((item) => HopAddition.fromJson(item as Map<String, dynamic>))
        .toList(),
  );
}

class EquipmentProfile {
  const EquipmentProfile({
    required this.id,
    required this.name,
    required this.batchSizeLiters,
    required this.boilOffRateLitersPerHour,
    required this.efficiencyPct,
  });

  final String id;
  final String name;
  final double batchSizeLiters;
  final double boilOffRateLitersPerHour;
  final double efficiencyPct;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'batchSizeLiters': batchSizeLiters,
    'boilOffRateLitersPerHour': boilOffRateLitersPerHour,
    'efficiencyPct': efficiencyPct,
  };

  factory EquipmentProfile.fromJson(Map<String, dynamic> json) =>
      EquipmentProfile(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        batchSizeLiters: (json['batchSizeLiters'] as num?)?.toDouble() ?? 20,
        boilOffRateLitersPerHour:
            (json['boilOffRateLitersPerHour'] as num?)?.toDouble() ?? 3.5,
        efficiencyPct: (json['efficiencyPct'] as num?)?.toDouble() ?? 72,
      );
}

class WaterProfile {
  const WaterProfile({
    required this.id,
    required this.name,
    required this.calciumPpm,
    required this.magnesiumPpm,
    required this.sodiumPpm,
    required this.chloridePpm,
    required this.sulfatePpm,
    required this.bicarbonatePpm,
  });

  final String id;
  final String name;
  final double calciumPpm;
  final double magnesiumPpm;
  final double sodiumPpm;
  final double chloridePpm;
  final double sulfatePpm;
  final double bicarbonatePpm;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'calciumPpm': calciumPpm,
    'magnesiumPpm': magnesiumPpm,
    'sodiumPpm': sodiumPpm,
    'chloridePpm': chloridePpm,
    'sulfatePpm': sulfatePpm,
    'bicarbonatePpm': bicarbonatePpm,
  };

  factory WaterProfile.fromJson(Map<String, dynamic> json) => WaterProfile(
    id: json['id'] as String? ?? '',
    name: json['name'] as String? ?? '',
    calciumPpm: (json['calciumPpm'] as num?)?.toDouble() ?? 0,
    magnesiumPpm: (json['magnesiumPpm'] as num?)?.toDouble() ?? 0,
    sodiumPpm: (json['sodiumPpm'] as num?)?.toDouble() ?? 0,
    chloridePpm: (json['chloridePpm'] as num?)?.toDouble() ?? 0,
    sulfatePpm: (json['sulfatePpm'] as num?)?.toDouble() ?? 0,
    bicarbonatePpm: (json['bicarbonatePpm'] as num?)?.toDouble() ?? 0,
  );
}

class BatchRecord {
  const BatchRecord({
    required this.id,
    required this.recipeId,
    required this.name,
    required this.status,
    required this.brewedAtIso,
    required this.originalGravity,
    required this.finalGravity,
    required this.temperatureC,
    required this.notes,
  });

  final String id;
  final String recipeId;
  final String name;
  final String status;
  final String brewedAtIso;
  final double originalGravity;
  final double finalGravity;
  final double temperatureC;
  final String notes;

  Map<String, dynamic> toJson() => {
    'id': id,
    'recipeId': recipeId,
    'name': name,
    'status': status,
    'brewedAtIso': brewedAtIso,
    'originalGravity': originalGravity,
    'finalGravity': finalGravity,
    'temperatureC': temperatureC,
    'notes': notes,
  };

  factory BatchRecord.fromJson(Map<String, dynamic> json) => BatchRecord(
    id: json['id'] as String? ?? '',
    recipeId: json['recipeId'] as String? ?? '',
    name: json['name'] as String? ?? '',
    status: json['status'] as String? ?? 'Planned',
    brewedAtIso: json['brewedAtIso'] as String? ?? '',
    originalGravity: (json['originalGravity'] as num?)?.toDouble() ?? 1.0,
    finalGravity: (json['finalGravity'] as num?)?.toDouble() ?? 1.0,
    temperatureC: (json['temperatureC'] as num?)?.toDouble() ?? 20,
    notes: json['notes'] as String? ?? '',
  );
}

class FermentumSnapshot {
  const FermentumSnapshot({
    required this.recipes,
    required this.equipmentProfiles,
    required this.waterProfiles,
    required this.batchRecords,
  });

  final List<RecipeModel> recipes;
  final List<EquipmentProfile> equipmentProfiles;
  final List<WaterProfile> waterProfiles;
  final List<BatchRecord> batchRecords;

  Map<String, dynamic> toJson() => {
    'recipes': recipes.map((item) => item.toJson()).toList(),
    'equipmentProfiles': equipmentProfiles
        .map((item) => item.toJson())
        .toList(),
    'waterProfiles': waterProfiles.map((item) => item.toJson()).toList(),
    'batchRecords': batchRecords.map((item) => item.toJson()).toList(),
  };

  factory FermentumSnapshot.fromJson(Map<String, dynamic> json) =>
      FermentumSnapshot(
        recipes: ((json['recipes'] as List<dynamic>?) ?? [])
            .map((item) => RecipeModel.fromJson(item as Map<String, dynamic>))
            .toList(),
        equipmentProfiles: ((json['equipmentProfiles'] as List<dynamic>?) ?? [])
            .map(
              (item) => EquipmentProfile.fromJson(item as Map<String, dynamic>),
            )
            .toList(),
        waterProfiles: ((json['waterProfiles'] as List<dynamic>?) ?? [])
            .map((item) => WaterProfile.fromJson(item as Map<String, dynamic>))
            .toList(),
        batchRecords: ((json['batchRecords'] as List<dynamic>?) ?? [])
            .map((item) => BatchRecord.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
}
