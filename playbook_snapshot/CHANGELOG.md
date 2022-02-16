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

## [0.0.1]

- initial release.
