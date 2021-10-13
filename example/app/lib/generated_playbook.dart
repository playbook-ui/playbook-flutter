// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:app/bar/bar.story.dart' as _i5;
import 'package:app/foo/foo_widget.story.dart' as _i4;
import 'package:app/image/asset_image.story.dart' as _i3;
import 'package:playbook/playbook.dart' as _i1;
import 'package:playbook/src/scenario_layout.dart' as _i2;

_i1.Playbook get playbook => _i1.Playbook(stories: stories);
List<_i1.Story> get stories =>
    [_$image$asset_image$Story(), _$foo$foo_widget$Story(), _$bar$bar$Story()];
_i1.Story _$image$asset_image$Story() => _i1.Story('AssetImage', scenarios: [
      _i1.Scenario(
        'AssetImage',
        layout: _i2.ScenarioLayout.compressed(),
        scale: 0.3,
        child: _i3.$AssetImage(),
      )
    ]);
_i1.Story _$foo$foo_widget$Story() => _i1.Story('FooWidget', scenarios: [
      _i1.Scenario(
        'foo3foo3',
        layout: _i2.ScenarioLayout.sizing(
            _i2.ScenarioLayoutFixed(100.0), _i2.ScenarioLayoutFixed(200.0)),
        scale: 0.3,
        child: _i4.Foo3(),
      ),
      _i1.Scenario(
        'Foo4 Bar',
        layout: _i2.ScenarioLayout.compressed(),
        scale: 0.3,
        child: _i4.$Foo4_Bar(),
      ),
      _i1.Scenario(
        'foo5',
        layout: _i2.ScenarioLayout.compressed(),
        scale: 0.3,
        child: _i4.$foo5(),
      ),
      _i4.foo1(),
      _i4.foo2()
    ]);
_i1.Story _$bar$bar$Story() => _i1.Story('BarWidget',
    scenarios: [_i5.twoLineText(), _i5.emptyText(), ..._i5.variousText()]);
