# Fermentum Domain Model

## Model principles

- shared primitives across beverage types
- beverage-specific extensions where domain behavior truly differs
- immutable version history for recipes
- provenance on imported and curated content

## Core entities

### Recipe

Represents a reusable formulation template.

Key fields:

- `id`
- `beverage_type`
- `style_id`
- `name`
- `author`
- `source_url`
- `license`
- `experience_mode`
- `equipment_profile_id`
- `target_batch_volume`
- `brewhouse_efficiency`
- `notes`
- `created_at`
- `updated_at`

### RecipeVersion

Represents a frozen snapshot of a recipe at a point in time.

Key fields:

- `id`
- `recipe_id`
- `version_number`
- `parent_version_id`
- `change_summary`
- `metrics_snapshot`
- `created_at`

### Ingredient

Shared base record for all ingredient types.

Key fields:

- `id`
- `ingredient_type`
- `name`
- `manufacturer`
- `origin`
- `attributes_json`

Subtypes:

- fermentable
- hop
- yeast
- adjunct
- fining
- nutrient

### EquipmentProfile

Represents a brewing or fermentation setup.

Key fields:

- `id`
- `name`
- `process_type`
- `batch_volume_max`
- `boil_volume_max`
- `mash_tun_volume`
- `efficiency_default`
- `boil_off_rate`
- `trub_loss`
- `fermenter_loss`
- `notes`

### WaterProfile

Represents source or target water chemistry.

Key fields:

- `id`
- `name`
- `calcium_ppm`
- `magnesium_ppm`
- `sodium_ppm`
- `chloride_ppm`
- `sulfate_ppm`
- `bicarbonate_ppm`
- `ph`

### Batch

Represents an actual execution of a recipe version.

Key fields:

- `id`
- `recipe_version_id`
- `batch_name`
- `status`
- `brew_date`
- `packaging_date`
- `actual_batch_volume`
- `actual_og`
- `actual_fg`
- `actual_abv`
- `notes`

### ProcessStep

Represents an operational step attached to recipe or batch context.

Key fields:

- `id`
- `owner_type`
- `owner_id`
- `step_type`
- `sequence`
- `title`
- `planned_start_offset_minutes`
- `duration_minutes`
- `target_temperature_c`
- `instructions`

### FermentationLog

Key fields:

- `id`
- `batch_id`
- `logged_at`
- `gravity`
- `temperature_c`
- `pressure_psi`
- `ph`
- `note`

### PackagingLog

Key fields:

- `id`
- `batch_id`
- `packaging_type`
- `target_volumes_co2`
- `priming_sugar_g`
- `keg_pressure_psi`
- `note`

### TastingNote

Key fields:

- `id`
- `batch_id`
- `tasted_at`
- `appearance`
- `aroma`
- `flavor`
- `mouthfeel`
- `overall`
- `defects`
- `adjustments_for_next_time`

## Beverage-type extensions

### Beer

- mash schedule
- hop schedule
- IBU model
- color model
- carbonation and packaging norms

### Cider

- juice source
- sugar adjustment
- acid adjustment
- nutrient schedule
- fining and stabilization

### Wine

- must chemistry
- sulfite additions
- acid and tannin management
- racking and aging events

### Distilling

- mash bill
- wash fermentation
- stripping and spirit runs
- cuts logging
- compliance and legal metadata

## Provenance requirements

Every curated or imported recipe should store:

- source type
- source URL
- author or importer
- license
- import timestamp
- transformation notes where lossy conversion occurred

## Versioning rules

- recipes are editable working records
- every brewable state must be snapshotted as a `RecipeVersion`
- batches always point to a recipe version, not the mutable recipe head


