# Fermentum Database Schema

## Database approach

Use SQLite locally in the client as the primary operational store.

Design rules:

- integer primary keys or UUIDs, but choose one consistently during implementation
- foreign keys enabled
- schema migrations committed to source control
- soft delete only where needed for sync or audit value

## Initial tables

### `recipes`

- `id`
- `beverage_type`
- `style_id`
- `name`
- `author`
- `source_url`
- `license`
- `experience_mode`
- `equipment_profile_id`
- `target_batch_volume_l`
- `brewhouse_efficiency_pct`
- `notes`
- `created_at`
- `updated_at`

### `recipe_versions`

- `id`
- `recipe_id`
- `version_number`
- `parent_version_id`
- `change_summary`
- `metrics_snapshot_json`
- `created_at`

### `ingredients`

- `id`
- `ingredient_type`
- `name`
- `manufacturer`
- `origin`
- `attributes_json`
- `created_at`
- `updated_at`

### `recipe_ingredients`

- `id`
- `recipe_version_id`
- `ingredient_id`
- `use_type`
- `amount`
- `unit`
- `time_offset_min`
- `stage`
- `attributes_json`

### `equipment_profiles`

- `id`
- `name`
- `process_type`
- `batch_volume_max_l`
- `boil_volume_max_l`
- `mash_tun_volume_l`
- `efficiency_default_pct`
- `boil_off_rate_l_per_hr`
- `trub_loss_l`
- `fermenter_loss_l`
- `notes`

### `water_profiles`

- `id`
- `name`
- `calcium_ppm`
- `magnesium_ppm`
- `sodium_ppm`
- `chloride_ppm`
- `sulfate_ppm`
- `bicarbonate_ppm`
- `ph`

### `batches`

- `id`
- `recipe_version_id`
- `batch_name`
- `status`
- `brew_date`
- `packaging_date`
- `actual_batch_volume_l`
- `actual_og`
- `actual_fg`
- `actual_abv`
- `notes`
- `created_at`
- `updated_at`

### `process_steps`

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

### `fermentation_logs`

- `id`
- `batch_id`
- `logged_at`
- `gravity`
- `temperature_c`
- `pressure_psi`
- `ph`
- `note`

### `packaging_logs`

- `id`
- `batch_id`
- `packaging_type`
- `target_volumes_co2`
- `priming_sugar_g`
- `keg_pressure_psi`
- `note`
- `logged_at`

### `tasting_notes`

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

## JSON usage

JSON columns are acceptable for:

- metrics snapshots
- ingredient subtype attributes
- import diagnostics

JSON columns are not the default answer for first-class relational data.

## Migration policy

- every schema change gets a named migration
- every migration includes rollback guidance in comments or docs
- destructive changes require an ADR or explicit justification in the pull request


