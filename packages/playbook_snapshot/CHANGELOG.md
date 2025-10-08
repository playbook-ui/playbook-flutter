## 1.3.0

### Improvements

- Updated SDK constraint to `^3.9.0`
- Updated Flutter constraint to `>=3.35.0`
- Updated analysis options to use `very_good_analysis/analysis_options.10.0.0.yaml`
- Refactored snapshot support code to use pattern matching instead of runtimeType switch

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

## 1.0.2

- **FIX**: can use scenarioWidgetBuilder when snapshot #93

## 1.0.1

- **FIX**: Device size for vertical layout fill.

## 1.0.0

- **BREAKING CHANGE**: an instance of `SnapshotDevice` is passed when `playbook` is run.
- **FEAT**: `SnapshotDevice` now supports `textScaler`, `pixelRatio` and `safeAreaInsets`. If you don't want the `SafeArea`, set `SafeAreaInsets()` to `safeAreaInsets`.
- **FEAT**: `ScenarioWidget` shows `Checkered` background. If you don't want to show the background, set `null` to `checkeredColor`.
- **FEAT**: can change whether to use `Material` widgets as a base when taking snapshots.
- **FIX**: deprecate `directoryPath` and `snapshotDir`, use `snapshotDir` and `subDir` instead.

## 0.3.0+1

- **CHORE**: fix playbook version.

## 0.3.0

- **FEAT**: can load assets that are included in dependencies.
- **BREAKING CHANGE**: upgrade sdk and flutter.

## 0.2.1

- **FIX**: Support `Scrollables` have no `ScrollController`.

## 0.2.0

- **FEAT**: Added support for defining fonts for `playbook_snapshot` in `pubspec.yaml`.

## 0.1.4

- **FIX**: load multiple fonts ([#58](https://github.com/playbook-ui/playbook-flutter/issues/58)).

## 0.1.3

- **BREAKING CHANGE**: SnapshotDevice change from enum to normal class.

## 0.1.2

- **FIX**: find by the scenario widget to take snapshots.

## 0.1.1

- **FIX**: reset app for each test.

## 0.1.0

- **BREAKING CHANGE**: `TestTool` needs `WidgetTester` instance which is created on `testWidget`. And `testWidgets` only needs to be called once.

```dart
Future<void> main() async {
  testWidgets('Take snapshots', (tester) async {
    await Playbook(
      stories: [],
    ).run(
      Snapshot(
        directoryPath: 'screenshots',
        devices: [],
      ),
      tester, // Pass in the `WidgetTester` created by the `testWidget`.
      (widget) {
        return MaterialApp(
          home: Material(child: widget),
        );
      },
    );

    // If you want to run `TestTool` multiple times, run it inside the` testWidgets` closure.
  });
}

```

## 0.0.3

- **FEAT**: can be stop resizing `Scrollable`.

## 0.0.2

- **BUILD**: bump deps.

## 0.0.1

- initial release.
