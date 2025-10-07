## 1.3.0

### Improvements

- Updated SDK constraint to `^3.9.0`
- Updated Flutter constraint to `>=3.35.0`
- Updated analysis options to use `very_good_analysis/analysis_options.10.0.0.yaml`
- Refactored scenario container code to use pattern matching instead of runtimeType switch

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

## 1.0.0

- **FEAT**: `ScenarioWidget` shows `Checkered` background. If you don't want to show the background, set `checkeredColor` to `null`.

## 0.1.0+1

- **CHORE**: fix playbook version.

## 0.1.0

- **BREAKING CHANGE**: upgrade sdk and flutter.

## 0.0.6

- **FIX**: Rename SearchBar to SearchBox ([#62](https://github.com/playbook-ui/playbook-flutter/issues/62)).

## 0.0.5

- **FEAT**: PlaybookGallery now respects AppBarTheme#titleTextStyle ([#56](https://github.com/playbook-ui/playbook-flutter/issues/56)). ([f248d407](https://github.com/playbook-ui/playbook-flutter/commit/f248d407f37c3c95eedc546c29f3d88d8ef308fc))

## 0.0.4+1

- **FIX**: add listener to text controller ([#55](https://github.com/playbook-ui/playbook-flutter/issues/55)). ([7c0d4ece](https://github.com/playbook-ui/playbook-flutter/commit/7c0d4ece095752300ef2eaed3bca0c8d2df8144c))

## 0.0.4

- **FEAT**: set scenario thumbnail scale parameter from PlaybookGallery.
- **FEAT**: expose searchTextController.

## 0.0.3+2

- **FIX**: search bar initial state.

## 0.0.3+1

- **FIX**: abandon scroll_to_index, set story to search text directly.

## 0.0.3

- **FEAT**: update gallery ui.
- **FEAT**: touch app bar to scroll to top.
- **FEAT**: allow auto scroll to story from menu bar.
- **FEAT**: allow set custom actions.
- **FEAT**: disable hero mode instead of nested navigator hack.
- **CHORE**: melos bootstrap.

## 0.0.2

- **BUILD**: bump deps.

## [0.0.1]

- initial release.
