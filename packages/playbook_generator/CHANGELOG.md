## 1.2.0

### Dependencies

- **analyzer**: Updated from `^7.4.5` to `^8.0.0`
- **build**: Updated from `^2.4.1` to `^4.0.0`
- **source_gen**: Updated from `^2.0.0` to `^4.0.0`

### Improvements

- Migrated to analyzer 8.x API:
  - Changed import from `element2.dart` to `element.dart`
  - Updated element access patterns (`ClassFragment` → `ClassElement`, `TopLevelFunctionFragment` → `ExecutableElement`)
  - Replaced deprecated APIs (`librarySource.uri` → `uri`, `topLevelElements` → specific getters like `topLevelFunctions` and `topLevelVariables`)
- Updated SDK constraint to `^3.8.0`

## 1.1.0

- upgrade analyzer to greater than 7.4.5.

## 1.0.0

- **BREAKING CHANGE**: remove `needsScrollableResizing` from `ScenarioLayoutCompressed`. Use `ScenarioLayoutFill` instead.
- **FEAT**: can be set to find assets glob and output file name.

## 0.1.0

- **FEAT**: generate `Scenario` with the function that has `BuildContext`.
- **BREAKING CHANGE**: upgrade sdk with some dependencies.

## 0.0.6+1

- **CHORE**: fix analyzer version.

## 0.0.6

- **FEAT**: bump analyzer ([#57](https://github.com/playbook-ui/playbook-flutter/issues/57)). ([e1fe1430](https://github.com/playbook-ui/playbook-flutter/commit/e1fe1430f3d91b8ab129626c3858345c8955b573))

## 0.0.5

- **BREAKING CHANGE**: remove scenario thumbnail scale parameter.

## 0.0.4+1

- upgrade dependencies

## 0.0.4

- **FIX**: fix searching for generate files.

## 0.0.3+1

- **REFACTOR**: generator not depended on playbook anymore. ([9a46a233](https://github.com/playbook-ui/playbook-flutter/commit/9a46a2335d4934158c840da39fc3743b9959fe67))

## 0.0.3

- **FEAT**: remove dartx and use dart api.

## 0.0.2

- upgrade dependencies

## 0.0.1

- initial release.
