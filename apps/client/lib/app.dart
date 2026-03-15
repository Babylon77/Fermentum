import 'package:flutter/material.dart';
import 'package:shared_models/shared_models.dart';

import 'data/app_repository.dart';
import 'domain/brewing_math.dart';
import 'theme/app_theme.dart';

class FermentumApp extends StatelessWidget {
  const FermentumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fermentum',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: buildFermentumTheme(),
      home: const FermentumWorkspace(),
    );
  }
}

class FermentumWorkspace extends StatefulWidget {
  const FermentumWorkspace({super.key});

  @override
  State<FermentumWorkspace> createState() => _FermentumWorkspaceState();
}

class _FermentumWorkspaceState extends State<FermentumWorkspace> {
  final _repository = AppRepository();

  final _recipeName = TextEditingController();
  final _recipeStyle = TextEditingController(text: 'American Pale Ale');
  final _recipeBatchL = TextEditingController(text: '20');
  final _recipeEfficiency = TextEditingController(text: '72');
  final _recipeAttenuation = TextEditingController(text: '76');
  final _recipeNotes = TextEditingController();
  final _maltName = TextEditingController(text: 'Pale Malt');
  final _maltWeight = TextEditingController(text: '4.5');
  final _maltPpg = TextEditingController(text: '37');
  final _maltColor = TextEditingController(text: '2');
  final _hopName = TextEditingController(text: 'Cascade');
  final _hopWeight = TextEditingController(text: '28');
  final _hopAa = TextEditingController(text: '6.0');
  final _hopTime = TextEditingController(text: '60');

  final _equipmentName = TextEditingController();
  final _equipmentBatch = TextEditingController(text: '20');
  final _equipmentBoilOff = TextEditingController(text: '3.5');
  final _equipmentEfficiency = TextEditingController(text: '72');

  final _waterName = TextEditingController();
  final _waterCa = TextEditingController(text: '80');
  final _waterMg = TextEditingController(text: '10');
  final _waterNa = TextEditingController(text: '15');
  final _waterCl = TextEditingController(text: '60');
  final _waterSo4 = TextEditingController(text: '110');
  final _waterHco3 = TextEditingController(text: '40');

  bool _loading = true;
  int _sectionIndex = 0;
  String _beverageType = 'Beer';
  String? _selectedRecipeId;
  FermentumSnapshot? _snapshot;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    for (final controller in [
      _recipeName,
      _recipeStyle,
      _recipeBatchL,
      _recipeEfficiency,
      _recipeAttenuation,
      _recipeNotes,
      _maltName,
      _maltWeight,
      _maltPpg,
      _maltColor,
      _hopName,
      _hopWeight,
      _hopAa,
      _hopTime,
      _equipmentName,
      _equipmentBatch,
      _equipmentBoilOff,
      _equipmentEfficiency,
      _waterName,
      _waterCa,
      _waterMg,
      _waterNa,
      _waterCl,
      _waterSo4,
      _waterHco3,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _load() async {
    final snapshot = await _repository.load();
    setState(() {
      _snapshot = snapshot;
      _selectedRecipeId =
          snapshot.recipes.isEmpty ? null : snapshot.recipes.first.id;
      _loading = false;
    });
  }

  Future<void> _save(FermentumSnapshot snapshot) async {
    setState(() {
      _snapshot = snapshot;
      _selectedRecipeId ??=
          snapshot.recipes.isEmpty ? null : snapshot.recipes.first.id;
    });
    await _repository.save(snapshot);
  }

  String _id(String prefix) =>
      '$prefix-${DateTime.now().microsecondsSinceEpoch}';

  RecipeModel? _selectedRecipe(FermentumSnapshot snapshot) {
    if (_selectedRecipeId == null) {
      return snapshot.recipes.isEmpty ? null : snapshot.recipes.first;
    }
    for (final recipe in snapshot.recipes) {
      if (recipe.id == _selectedRecipeId) {
        return recipe;
      }
    }
    return snapshot.recipes.isEmpty ? null : snapshot.recipes.first;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || _snapshot == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final snapshot = _snapshot!;
    final selectedRecipe = _selectedRecipe(snapshot);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 1080;

        return Scaffold(
          body: SafeArea(
            child: Row(
              children: [
                if (isWide)
                  NavigationRail(
                    selectedIndex: _sectionIndex,
                    onDestinationSelected: (value) =>
                        setState(() => _sectionIndex = value),
                    backgroundColor: const Color(0xFF0B1220),
                    indicatorColor: const Color(0xFF112A3E),
                    labelType: NavigationRailLabelType.all,
                    destinations: const [
                      NavigationRailDestination(
                          icon: Icon(Icons.dashboard_outlined),
                          label: Text('Overview')),
                      NavigationRailDestination(
                          icon: Icon(Icons.science_outlined),
                          label: Text('Recipes')),
                      NavigationRailDestination(
                          icon: Icon(Icons.precision_manufacturing_outlined),
                          label: Text('Equipment')),
                      NavigationRailDestination(
                          icon: Icon(Icons.water_drop_outlined),
                          label: Text('Water')),
                      NavigationRailDestination(
                          icon: Icon(Icons.local_drink_outlined),
                          label: Text('Batches')),
                    ],
                  ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _HeaderBar(
                          title: 'Fermentum Mission Control',
                          subtitle:
                              'Offline-first fermentation planning with live brewing metrics and mission-command UI.',
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: switch (_sectionIndex) {
                            0 => _buildOverview(snapshot, selectedRecipe),
                            1 =>
                              _buildRecipes(snapshot, selectedRecipe, isWide),
                            2 => _buildEquipment(snapshot),
                            3 => _buildWater(snapshot),
                            _ => _buildBatches(snapshot),
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: isWide
              ? null
              : NavigationBar(
                  selectedIndex: _sectionIndex,
                  onDestinationSelected: (value) =>
                      setState(() => _sectionIndex = value),
                  destinations: const [
                    NavigationDestination(
                        icon: Icon(Icons.dashboard_outlined),
                        label: 'Overview'),
                    NavigationDestination(
                        icon: Icon(Icons.science_outlined), label: 'Recipes'),
                    NavigationDestination(
                        icon: Icon(Icons.precision_manufacturing_outlined),
                        label: 'Equipment'),
                    NavigationDestination(
                        icon: Icon(Icons.water_drop_outlined), label: 'Water'),
                    NavigationDestination(
                        icon: Icon(Icons.local_drink_outlined),
                        label: 'Batches'),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildOverview(
      FermentumSnapshot snapshot, RecipeModel? selectedRecipe) {
    final metrics =
        selectedRecipe == null ? null : BrewingMath.calculate(selectedRecipe);

    return ListView(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            _MetricTile(label: 'Recipes', value: '${snapshot.recipes.length}'),
            _MetricTile(
                label: 'Equipment',
                value: '${snapshot.equipmentProfiles.length}'),
            _MetricTile(
                label: 'Water', value: '${snapshot.waterProfiles.length}'),
            _MetricTile(
                label: 'Batches', value: '${snapshot.batchRecords.length}'),
          ],
        ),
        const SizedBox(height: 16),
        if (selectedRecipe != null && metrics != null)
          _PanelCard(
            title: 'Selected Recipe Telemetry',
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _MetricTile(label: 'Recipe', value: selectedRecipe.name),
                _MetricTile(
                    label: 'OG',
                    value: metrics.originalGravity.toStringAsFixed(3)),
                _MetricTile(
                    label: 'FG',
                    value: metrics.finalGravity.toStringAsFixed(3)),
                _MetricTile(
                    label: 'ABV', value: '${metrics.abv.toStringAsFixed(1)}%'),
                _MetricTile(
                    label: 'IBU', value: metrics.ibu.toStringAsFixed(0)),
                _MetricTile(
                    label: 'SRM', value: metrics.srm.toStringAsFixed(1)),
              ],
            ),
          ),
        const SizedBox(height: 16),
        _PanelCard(
          title: 'Latest Batch Activity',
          child: Column(
            children: snapshot.batchRecords.map((batch) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(batch.name),
                subtitle: Text('${batch.status} Ã¢â‚¬Â¢ ${batch.notes}'),
                trailing: Text('${batch.temperatureC.toStringAsFixed(1)} C'),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRecipes(
      FermentumSnapshot snapshot, RecipeModel? selectedRecipe, bool isWide) {
    final metrics =
        selectedRecipe == null ? null : BrewingMath.calculate(selectedRecipe);

    final form = _PanelCard(
      title: 'Recipe Builder',
      child: Column(
        children: [
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _Field(
                  width: 240,
                  child: TextField(
                      controller: _recipeName,
                      decoration:
                          const InputDecoration(labelText: 'Recipe Name'))),
              _Field(
                  width: 220,
                  child: TextField(
                      controller: _recipeStyle,
                      decoration: const InputDecoration(labelText: 'Style'))),
              _Field(
                width: 180,
                child: DropdownButtonFormField<String>(
                  initialValue: _beverageType,
                  items: const [
                    DropdownMenuItem(value: 'Beer', child: Text('Beer')),
                    DropdownMenuItem(value: 'Cider', child: Text('Cider')),
                  ],
                  onChanged: (value) =>
                      setState(() => _beverageType = value ?? 'Beer'),
                  decoration: const InputDecoration(labelText: 'Beverage'),
                ),
              ),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _recipeBatchL,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Batch L'))),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _recipeEfficiency,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(labelText: 'Efficiency %'))),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _recipeAttenuation,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(labelText: 'Attenuation %'))),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
              controller: _recipeNotes,
              minLines: 2,
              maxLines: 4,
              decoration: const InputDecoration(labelText: 'Brew Notes')),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _Field(
                  width: 220,
                  child: TextField(
                      controller: _maltName,
                      decoration:
                          const InputDecoration(labelText: 'Primary Malt'))),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _maltWeight,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Malt kg'))),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _maltPpg,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(labelText: 'Malt PPG'))),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _maltColor,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Color L'))),
              _Field(
                  width: 220,
                  child: TextField(
                      controller: _hopName,
                      decoration:
                          const InputDecoration(labelText: 'Primary Hop'))),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _hopWeight,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Hop g'))),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _hopAa,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(labelText: 'Hop AA %'))),
              _Field(
                  width: 160,
                  child: TextField(
                      controller: _hopTime,
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(labelText: 'Boil min'))),
            ],
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.icon(
              onPressed: () async {
                final recipe = RecipeModel(
                  id: _id('recipe'),
                  name: _recipeName.text.trim().isEmpty
                      ? 'Untitled Recipe'
                      : _recipeName.text.trim(),
                  style: _recipeStyle.text.trim(),
                  beverageType: _beverageType,
                  batchSizeLiters: _toDouble(_recipeBatchL.text, fallback: 20),
                  efficiencyPct:
                      _toDouble(_recipeEfficiency.text, fallback: 72),
                  attenuationPct:
                      _toDouble(_recipeAttenuation.text, fallback: 76),
                  notes: _recipeNotes.text.trim(),
                  fermentables: [
                    FermentableAddition(
                      name: _maltName.text.trim(),
                      weightKg: _toDouble(_maltWeight.text, fallback: 4.5),
                      potentialPpg: _toDouble(_maltPpg.text, fallback: 37),
                      colorLovibond: _toDouble(_maltColor.text, fallback: 2),
                    ),
                  ],
                  hops: [
                    HopAddition(
                      name: _hopName.text.trim(),
                      weightG: _toDouble(_hopWeight.text, fallback: 28),
                      alphaAcidPct: _toDouble(_hopAa.text, fallback: 6),
                      boilMinutes: _toDouble(_hopTime.text, fallback: 60),
                    ),
                  ],
                );

                final updated = FermentumSnapshot(
                  recipes: [...snapshot.recipes, recipe],
                  equipmentProfiles: snapshot.equipmentProfiles,
                  waterProfiles: snapshot.waterProfiles,
                  batchRecords: snapshot.batchRecords,
                );
                await _save(updated);
                setState(() => _selectedRecipeId = recipe.id);
                _recipeName.clear();
                _recipeNotes.clear();
              },
              icon: const Icon(Icons.add),
              label: const Text('Save Recipe'),
            ),
          ),
        ],
      ),
    );

    final list = _PanelCard(
      title: 'Recipe Library',
      child: Column(
        children: snapshot.recipes.map((recipe) {
          final data = BrewingMath.calculate(recipe);
          final selected = recipe.id == _selectedRecipeId;
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () => setState(() => _selectedRecipeId = recipe.id),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1624),
                  border: Border.all(
                      color: selected
                          ? const Color(0xFF37D7FF)
                          : const Color(0xFF22324A)),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(recipe.name,
                                style: Theme.of(context).textTheme.titleLarge)),
                        IconButton(
                          onPressed: () async {
                            final updated = FermentumSnapshot(
                              recipes: snapshot.recipes
                                  .where((item) => item.id != recipe.id)
                                  .toList(),
                              equipmentProfiles: snapshot.equipmentProfiles,
                              waterProfiles: snapshot.waterProfiles,
                              batchRecords: snapshot.batchRecords
                                  .where((item) => item.recipeId != recipe.id)
                                  .toList(),
                            );
                            await _save(updated);
                            if (_selectedRecipeId == recipe.id) {
                              setState(() => _selectedRecipeId =
                                  updated.recipes.isEmpty
                                      ? null
                                      : updated.recipes.first.id);
                            }
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: [
                        _MetricBadge(
                            label: 'OG',
                            value: data.originalGravity.toStringAsFixed(3)),
                        _MetricBadge(
                            label: 'ABV',
                            value: '${data.abv.toStringAsFixed(1)}%'),
                        _MetricBadge(
                            label: 'IBU', value: data.ibu.toStringAsFixed(0)),
                        _MetricBadge(
                            label: 'Volume',
                            value:
                                '${recipe.batchSizeLiters.toStringAsFixed(1)}L'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(recipe.notes.isEmpty ? 'No notes.' : recipe.notes),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );

    final detail = _PanelCard(
      title: 'Selected Recipe Detail',
      child: selectedRecipe == null
          ? const Text(
              'Create or select a recipe to review metrics and create a batch.')
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    _MetricBadge(label: 'Style', value: selectedRecipe.style),
                    _MetricBadge(
                        label: 'OG',
                        value: metrics!.originalGravity.toStringAsFixed(3)),
                    _MetricBadge(
                        label: 'FG',
                        value: metrics.finalGravity.toStringAsFixed(3)),
                    _MetricBadge(
                        label: 'ABV',
                        value: '${metrics.abv.toStringAsFixed(1)}%'),
                    _MetricBadge(
                        label: 'IBU', value: metrics.ibu.toStringAsFixed(0)),
                    _MetricBadge(
                        label: 'SRM', value: metrics.srm.toStringAsFixed(1)),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                    'Fermentables: ${selectedRecipe.fermentables.map((item) => '${item.name} ${item.weightKg.toStringAsFixed(2)}kg').join(', ')}'),
                const SizedBox(height: 8),
                Text(
                    'Hops: ${selectedRecipe.hops.map((item) => '${item.name} ${item.weightG.toStringAsFixed(0)}g @ ${item.boilMinutes.toStringAsFixed(0)}m').join(', ')}'),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () async {
                    final batch = BatchRecord(
                      id: _id('batch'),
                      recipeId: selectedRecipe.id,
                      name:
                          '${selectedRecipe.name} Batch ${snapshot.batchRecords.length + 1}',
                      status: 'Planned',
                      brewedAtIso: DateTime.now().toIso8601String(),
                      originalGravity: metrics.originalGravity,
                      finalGravity: metrics.finalGravity,
                      temperatureC: 20,
                      notes: 'Created from selected recipe.',
                    );
                    await _save(
                      FermentumSnapshot(
                        recipes: snapshot.recipes,
                        equipmentProfiles: snapshot.equipmentProfiles,
                        waterProfiles: snapshot.waterProfiles,
                        batchRecords: [...snapshot.batchRecords, batch],
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow_outlined),
                  label: const Text('Create Batch'),
                ),
              ],
            ),
    );

    return ListView(
      children: [
        form,
        const SizedBox(height: 16),
        if (isWide)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: list),
              const SizedBox(width: 16),
              Expanded(child: detail),
            ],
          )
        else ...[
          list,
          const SizedBox(height: 16),
          detail,
        ],
      ],
    );
  }

  Widget _buildEquipment(FermentumSnapshot snapshot) {
    return ListView(
      children: [
        _PanelCard(
          title: 'Equipment Profiles',
          child: Column(
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _Field(
                      width: 240,
                      child: TextField(
                          controller: _equipmentName,
                          decoration:
                              const InputDecoration(labelText: 'Name'))),
                  _Field(
                      width: 160,
                      child: TextField(
                          controller: _equipmentBatch,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'Batch L'))),
                  _Field(
                      width: 160,
                      child: TextField(
                          controller: _equipmentBoilOff,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Boil Off L/hr'))),
                  _Field(
                      width: 160,
                      child: TextField(
                          controller: _equipmentEfficiency,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              labelText: 'Efficiency %'))),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  onPressed: () async {
                    final profile = EquipmentProfile(
                      id: _id('equipment'),
                      name: _equipmentName.text.trim().isEmpty
                          ? 'Untitled Equipment'
                          : _equipmentName.text.trim(),
                      batchSizeLiters:
                          _toDouble(_equipmentBatch.text, fallback: 20),
                      boilOffRateLitersPerHour:
                          _toDouble(_equipmentBoilOff.text, fallback: 3.5),
                      efficiencyPct:
                          _toDouble(_equipmentEfficiency.text, fallback: 72),
                    );
                    await _save(
                      FermentumSnapshot(
                        recipes: snapshot.recipes,
                        equipmentProfiles: [
                          ...snapshot.equipmentProfiles,
                          profile
                        ],
                        waterProfiles: snapshot.waterProfiles,
                        batchRecords: snapshot.batchRecords,
                      ),
                    );
                    _equipmentName.clear();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Save Equipment'),
                ),
              ),
              const SizedBox(height: 16),
              ...snapshot.equipmentProfiles.map(
                (profile) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(profile.name),
                  subtitle: Text(
                      '${profile.batchSizeLiters.toStringAsFixed(1)}L Ã¢â‚¬Â¢ ${profile.boilOffRateLitersPerHour.toStringAsFixed(1)} L/hr Ã¢â‚¬Â¢ ${profile.efficiencyPct.toStringAsFixed(0)}%'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWater(FermentumSnapshot snapshot) {
    return ListView(
      children: [
        _PanelCard(
          title: 'Water Profiles',
          child: Column(
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _Field(
                      width: 220,
                      child: TextField(
                          controller: _waterName,
                          decoration:
                              const InputDecoration(labelText: 'Name'))),
                  _Field(
                      width: 120,
                      child: TextField(
                          controller: _waterCa,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Ca'))),
                  _Field(
                      width: 120,
                      child: TextField(
                          controller: _waterMg,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Mg'))),
                  _Field(
                      width: 120,
                      child: TextField(
                          controller: _waterNa,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Na'))),
                  _Field(
                      width: 120,
                      child: TextField(
                          controller: _waterCl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Cl'))),
                  _Field(
                      width: 120,
                      child: TextField(
                          controller: _waterSo4,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'SO4'))),
                  _Field(
                      width: 120,
                      child: TextField(
                          controller: _waterHco3,
                          keyboardType: TextInputType.number,
                          decoration:
                              const InputDecoration(labelText: 'HCO3'))),
                ],
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.icon(
                  onPressed: () async {
                    final profile = WaterProfile(
                      id: _id('water'),
                      name: _waterName.text.trim().isEmpty
                          ? 'Untitled Water'
                          : _waterName.text.trim(),
                      calciumPpm: _toDouble(_waterCa.text, fallback: 80),
                      magnesiumPpm: _toDouble(_waterMg.text, fallback: 10),
                      sodiumPpm: _toDouble(_waterNa.text, fallback: 15),
                      chloridePpm: _toDouble(_waterCl.text, fallback: 60),
                      sulfatePpm: _toDouble(_waterSo4.text, fallback: 110),
                      bicarbonatePpm: _toDouble(_waterHco3.text, fallback: 40),
                    );
                    await _save(
                      FermentumSnapshot(
                        recipes: snapshot.recipes,
                        equipmentProfiles: snapshot.equipmentProfiles,
                        waterProfiles: [...snapshot.waterProfiles, profile],
                        batchRecords: snapshot.batchRecords,
                      ),
                    );
                    _waterName.clear();
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Save Water Profile'),
                ),
              ),
              const SizedBox(height: 16),
              ...snapshot.waterProfiles.map(
                (profile) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(profile.name),
                  subtitle: Text(
                      'Ca ${profile.calciumPpm.toStringAsFixed(0)} Ã¢â‚¬Â¢ Mg ${profile.magnesiumPpm.toStringAsFixed(0)} Ã¢â‚¬Â¢ Cl ${profile.chloridePpm.toStringAsFixed(0)} Ã¢â‚¬Â¢ SO4 ${profile.sulfatePpm.toStringAsFixed(0)}'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBatches(FermentumSnapshot snapshot) {
    return ListView(
      children: [
        _PanelCard(
          title: 'Batch Command',
          child: Column(
            children: snapshot.batchRecords.map((batch) {
              final recipe = snapshot.recipes
                  .where((item) => item.id == batch.recipeId)
                  .firstOrNull;
              final nextStatus = switch (batch.status) {
                'Planned' => 'Brewed',
                'Brewed' => 'Fermenting',
                'Fermenting' => 'Conditioning',
                'Conditioning' => 'Packaged',
                _ => 'Packaged',
              };
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D1624),
                    border: Border.all(color: const Color(0xFF22324A)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Text(batch.name,
                                  style:
                                      Theme.of(context).textTheme.titleLarge)),
                          _MetricBadge(label: 'Status', value: batch.status),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(recipe == null ? 'Unknown recipe' : recipe.name),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children: [
                          _MetricBadge(
                              label: 'OG',
                              value: batch.originalGravity.toStringAsFixed(3)),
                          _MetricBadge(
                              label: 'FG',
                              value: batch.finalGravity.toStringAsFixed(3)),
                          _MetricBadge(
                              label: 'Temp',
                              value:
                                  '${batch.temperatureC.toStringAsFixed(1)} C'),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(batch.notes),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final updatedBatch = BatchRecord(
                            id: batch.id,
                            recipeId: batch.recipeId,
                            name: batch.name,
                            status: nextStatus,
                            brewedAtIso: batch.brewedAtIso,
                            originalGravity: batch.originalGravity,
                            finalGravity: batch.finalGravity,
                            temperatureC: batch.temperatureC,
                            notes: batch.notes,
                          );
                          await _save(
                            FermentumSnapshot(
                              recipes: snapshot.recipes,
                              equipmentProfiles: snapshot.equipmentProfiles,
                              waterProfiles: snapshot.waterProfiles,
                              batchRecords: snapshot.batchRecords
                                  .map((item) =>
                                      item.id == batch.id ? updatedBatch : item)
                                  .toList(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.arrow_forward),
                        label: Text('Advance to $nextStatus'),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  double _toDouble(String input, {required double fallback}) {
    return double.tryParse(input.trim()) ?? fallback;
  }
}

class _HeaderBar extends StatelessWidget {
  const _HeaderBar({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: theme.textTheme.displaySmall),
        const SizedBox(height: 8),
        Text(subtitle, style: theme.textTheme.bodyLarge),
      ],
    );
  }
}

class _PanelCard extends StatelessWidget {
  const _PanelCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131D2E),
        border: Border.all(color: const Color(0xFF22324A)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 3, width: 96, color: const Color(0xFF37D7FF)),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131D2E),
        border: Border.all(color: const Color(0xFF2B4263)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium),
          const SizedBox(height: 8),
          Text(value, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF0D1624),
        border: Border.all(color: const Color(0xFF22324A)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text('$label: $value'),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.width, required this.child});

  final double width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width, child: child);
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
