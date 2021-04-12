abstract class ScenarioLayoutSizing {}

class ScenarioLayoutCompressed extends ScenarioLayoutSizing {}

class ScenarioLayoutFill extends ScenarioLayoutSizing {}

class ScenarioLayoutFixed extends ScenarioLayoutSizing {
  ScenarioLayoutFixed(this.value);

  final double value;
}

class ScenarioLayout {
  ScenarioLayout.fill()
      : h = ScenarioLayoutFill(),
        v = ScenarioLayoutFill();

  ScenarioLayout.compressed()
      : h = ScenarioLayoutCompressed(),
        v = ScenarioLayoutCompressed();

  ScenarioLayout.fixed(double width, double height)
      : h = ScenarioLayoutFixed(width),
        v = ScenarioLayoutFixed(height);

  ScenarioLayout.fixedH(double width, {ScenarioLayoutSizing? crossAxisLayout})
      : h = ScenarioLayoutFixed(width),
        v = crossAxisLayout ?? ScenarioLayoutCompressed();

  ScenarioLayout.fixedV(double height, {ScenarioLayoutSizing? crossAxisLayout})
      : h = crossAxisLayout ?? ScenarioLayoutCompressed(),
        v = ScenarioLayoutFixed(height);

  ScenarioLayout.sizing(this.h, this.v);

  ScenarioLayoutSizing h;
  ScenarioLayoutSizing v;
}
