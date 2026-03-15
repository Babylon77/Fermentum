import 'dart:convert';

import 'package:shared_models/shared_models.dart';

import 'storage/key_value_store.dart';
import 'storage/storage.dart';

class AppRepository {
  AppRepository() : _store = createStore();

  final KeyValueStore _store;

  static const _storageKey = 'fermentum_state_v1';

  Future<FermentumSnapshot> load() async {
    final raw = await _store.read(_storageKey);
    if (raw == null || raw.isEmpty) {
      final seed = seedData();
      await save(seed);
      return seed;
    }

    return FermentumSnapshot.fromJson(
      jsonDecode(raw) as Map<String, dynamic>,
    );
  }

  Future<void> save(FermentumSnapshot snapshot) async {
    await _store.write(_storageKey, jsonEncode(snapshot.toJson()));
  }

  FermentumSnapshot seedData() {
    const recipe = RecipeModel(
      id: 'recipe-1',
      name: 'Neon Pale Ale',
      style: 'American Pale Ale',
      beverageType: 'Beer',
      batchSizeLiters: 20,
      efficiencyPct: 72,
      attenuationPct: 76,
      notes:
          'Starter recipe for validating recipe math, batch logging, and the mission-command UI.',
      fermentables: [
        FermentableAddition(
          name: 'Pale Malt',
          weightKg: 4.6,
          potentialPpg: 37,
          colorLovibond: 2,
        ),
        FermentableAddition(
          name: 'Crystal 40',
          weightKg: 0.35,
          potentialPpg: 34,
          colorLovibond: 40,
        ),
      ],
      hops: [
        HopAddition(
          name: 'Cascade',
          weightG: 28,
          alphaAcidPct: 6.0,
          boilMinutes: 60,
        ),
        HopAddition(
          name: 'Cascade',
          weightG: 28,
          alphaAcidPct: 6.0,
          boilMinutes: 10,
        ),
      ],
    );

    const equipment = EquipmentProfile(
      id: 'equipment-1',
      name: '20L Electric All-in-One',
      batchSizeLiters: 20,
      boilOffRateLitersPerHour: 3.5,
      efficiencyPct: 72,
    );

    const water = WaterProfile(
      id: 'water-1',
      name: 'Balanced Pale Ale',
      calciumPpm: 85,
      magnesiumPpm: 10,
      sodiumPpm: 18,
      chloridePpm: 65,
      sulfatePpm: 110,
      bicarbonatePpm: 40,
    );

    const batch = BatchRecord(
      id: 'batch-1',
      recipeId: 'recipe-1',
      name: 'Neon Pale Ale Batch 001',
      status: 'Fermenting',
      brewedAtIso: '2026-03-15T12:00:00.000Z',
      originalGravity: 1.053,
      finalGravity: 1.012,
      temperatureC: 19.5,
      notes: 'Healthy start. Stable krausen and clean activity curve.',
    );

    return const FermentumSnapshot(
      recipes: [recipe],
      equipmentProfiles: [equipment],
      waterProfiles: [water],
      batchRecords: [batch],
    );
  }
}
