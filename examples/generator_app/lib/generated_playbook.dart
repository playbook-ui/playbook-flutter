// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:generator_app/bar/bar.story.dart' as _i2;
import 'package:generator_app/foo/foo_widget.story.dart' as _i4;
import 'package:generator_app/image/asset_image.story.dart' as _i5;
import 'package:generator_app/page/page.story.dart' as _i6;
import 'package:generator_app/scrollable/scrollable.story.dart' as _i7;
import 'package:playbook/playbook.dart' as _i1;
import 'package:playbook/src/scenario_layout.dart' as _i3;

_i1.Playbook get playbook => _i1.Playbook(stories: stories);
List<_i1.Story> get stories => [
  _$bar$bar$Story(),
  _$foo$foo_widget$Story(),
  _$image$asset_image$Story(),
  _$page$page$Story(),
  _$scrollable$scrollable$Story(),
];
_i1.Story _$bar$bar$Story() => _i1.Story(
  'BarWidget',
  scenarios: [_i2.twoLineText(), _i2.emptyText(), ..._i2.variousText()],
);
_i1.Story _$foo$foo_widget$Story() => _i1.Story(
  'FooWidget',
  scenarios: [
    _i1.Scenario(
      'foo3foo3',
      layout: _i3.ScenarioLayout.sizing(
        _i3.ScenarioLayoutFixed(100.0),
        _i3.ScenarioLayoutFixed(200.0),
      ),
      child: _i4.Foo3(),
    ),
    _i1.Scenario(
      'Foo4 Bar',
      layout: _i3.ScenarioLayout.fixedH(
        300.0,
        crossAxisLayout: _i3.ScenarioLayoutFill(),
      ),
      child: _i4.$Foo4_Bar(),
    ),
    _i1.Scenario(
      'foo5',
      layout: _i3.ScenarioLayout.fixedV(
        500.0,
        crossAxisLayout: _i3.ScenarioLayoutFixed(200.0),
      ),
      child: _i4.$foo5(),
    ),
    _i4.foo1(),
    _i4.foo2(),
  ],
);
_i1.Story _$image$asset_image$Story() => _i1.Story(
  'AssetImage',
  scenarios: [
    _i1.Scenario(
      'AssetImage',
      layout: _i3.ScenarioLayout.compressed(),
      child: _i5.$AssetImage(),
    ),
    _i1.Scenario(
      'MaterialIcon',
      layout: _i3.ScenarioLayout.compressed(),
      child: _i5.$MaterialIcon(),
    ),
    _i1.Scenario(
      'CupertinoIcon',
      layout: _i3.ScenarioLayout.compressed(),
      child: _i5.$CupertinoIcon(),
    ),
  ],
);
_i1.Story _$page$page$Story() => _i1.Story(
  'HomePage',
  scenarios: [
    _i1.Scenario(
      'myPage',
      layout: _i3.ScenarioLayout.compressed(),
      child: _i6.myPage(),
    ),
  ],
);
_i1.Story _$scrollable$scrollable$Story() => _i1.Story(
  'scrollableStory',
  scenarios: [
    _i1.Scenario(
      'Primary Scrollable',
      layout: _i3.ScenarioLayout.compressed(),
      child: _i7.primary(),
    ),
    _i1.Scenario(
      'Not Primary Scrollable',
      layout: _i3.ScenarioLayout.compressed(),
      child: _i7.notPrimary(),
    ),
  ],
);
