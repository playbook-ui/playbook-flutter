/// A point within a rectangle.
/// This class is used to represent flutter's `Alignment`.
class ScenarioAlignment {
  /// Creates an alignment.
  const ScenarioAlignment(this.x, this.y);

  /// The distance fraction in the horizontal direction.
  final double x;

  /// The distance fraction in the vertical direction.
  final double y;

  /// The top left corner.
  static const ScenarioAlignment topLeft = ScenarioAlignment(-1.0, -1.0);

  /// The center point along the top edge.
  static const ScenarioAlignment topCenter = ScenarioAlignment(0.0, -1.0);

  /// The top right corner.
  static const ScenarioAlignment topRight = ScenarioAlignment(1.0, -1.0);

  /// The center point along the left edge.
  static const ScenarioAlignment centerLeft = ScenarioAlignment(-1.0, 0.0);

  /// The center point, both horizontally and vertically.
  static const ScenarioAlignment center = ScenarioAlignment(0.0, 0.0);

  /// The center point along the right edge.
  static const ScenarioAlignment centerRight = ScenarioAlignment(1.0, 0.0);

  /// The bottom left corner.
  static const ScenarioAlignment bottomLeft = ScenarioAlignment(-1.0, 1.0);

  /// The center point along the bottom edge.
  static const ScenarioAlignment bottomCenter = ScenarioAlignment(0.0, 1.0);

  /// The bottom right corner.
  static const ScenarioAlignment bottomRight = ScenarioAlignment(1.0, 1.0);
}
