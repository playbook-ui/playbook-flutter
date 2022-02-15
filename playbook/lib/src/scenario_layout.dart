abstract class ScenarioLayoutSizing {
  const ScenarioLayoutSizing();
}

class ScenarioLayoutCompressed extends ScenarioLayoutSizing {
  const ScenarioLayoutCompressed({this.needsScrollableResizing = true});

  final bool needsScrollableResizing;
}

class ScenarioLayoutFill extends ScenarioLayoutSizing {
  const ScenarioLayoutFill();
}

class ScenarioLayoutFixed extends ScenarioLayoutSizing {
  const ScenarioLayoutFixed(this.value);

  final double value;
}

class ScenarioLayout {
  const ScenarioLayout.fill()
      : _dh = null,
        _dv = null,
        _h = const ScenarioLayoutFill(),
        _v = const ScenarioLayoutFill();

  const ScenarioLayout.compressed({
    ScenarioLayoutSizing horizontalLayout = const ScenarioLayoutCompressed(),
    ScenarioLayoutSizing verticalLayout = const ScenarioLayoutCompressed(),
  })  : _dh = null,
        _dv = null,
        _h = horizontalLayout,
        _v = verticalLayout;

  const ScenarioLayout.fixed(double width, double height)
      : _dh = width,
        _dv = height,
        _h = null,
        _v = null;

  const ScenarioLayout.fixedH(
    double width, {
    ScenarioLayoutSizing crossAxisLayout = const ScenarioLayoutCompressed(),
  })  : _dh = width,
        _dv = null,
        _h = null,
        _v = crossAxisLayout;

  const ScenarioLayout.fixedV(
    double height, {
    ScenarioLayoutSizing crossAxisLayout = const ScenarioLayoutCompressed(),
  })  : _dh = null,
        _dv = height,
        _h = crossAxisLayout,
        _v = null;

  const ScenarioLayout.sizing(this._h, this._v)
      : _dh = null,
        _dv = null;

  final double? _dh;
  final double? _dv;

  final ScenarioLayoutSizing? _h;
  final ScenarioLayoutSizing? _v;

  ScenarioLayoutSizing get h => _h ?? ScenarioLayoutFixed(_dh!);

  ScenarioLayoutSizing get v => _v ?? ScenarioLayoutFixed(_dv!);
}
