## 1.3.0

### Improvements

- Updated SDK constraint to `^3.9.0`
- Updated Flutter constraint to `>=3.35.0`
- Updated analysis options to use `very_good_analysis/analysis_options.10.0.0.yaml`

### Dependencies

- Updated `very_good_analysis` from `^9.0.0` to `^10.0.0`

### Infrastructure

- Migrated from Melos workspace to Dart workspace configuration
- Migrated from `subosito/flutter-action` to `jdx/mise-action` in review workflow
- Added `.mise.toml` for Flutter 3.35.5 version management
- Removed `melos.yaml` and `pubspec_overrides.yaml` files
- Added `resolution: workspace` to package pubspec

## 1.2.0

### Improvements

- Updated SDK constraint to `^3.8.0`

## 1.1.0

- **FEAT**: can set `ScenarioWidgetBuilder` to `ScenarioWidget`.

## 1.0.1

- **FIX**: can set `ScenarioLayoutSizing` to `ScenarioLayout`.

## 1.0.0

- **BREAKING CHANGE**: remove `needsScrollableResizing` from `ScenarioLayoutCompressed`. Use `ScenarioLayoutFill` instead.

## 0.1.0

- **FEAT**: `Scenario` is supported to build with `WidgetBuilder`.
- **BREAKING CHANGE**: upgrade sdk and flutter.

## 0.0.4

- **BREAKING CHANGE**: remove scenario thumbnail scale parameter.

## 0.0.3

- **FEAT**: can be stop resizing `Scrollable`.

## 0.0.2

- **BUILD**: bump deps.

## [0.0.1+1]

- Delete unnecessary dependencies.

## [0.0.1]

- initial release.
