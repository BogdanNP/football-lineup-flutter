import 'package:flutter/foundation.dart';

/// A normalized coordinate on the football field.
///
/// Both [x] and [y] are in the range `0.0` to `100.0`, where `(0, 0)` is
/// the top-left corner and `(100, 100)` is the bottom-right corner.
///
/// This coordinate system is independent of screen size; widgets that render
/// players translate these coordinates to pixel positions at paint time.
@immutable
class FieldCoordinate {
  /// Creates a [FieldCoordinate].
  ///
  /// Both [x] and [y] must be between `0.0` and `100.0` inclusive.
  const FieldCoordinate({
    required this.x,
    required this.y,
  })  : assert(x >= 0.0 && x <= 100.0, 'x must be between 0 and 100'),
        assert(y >= 0.0 && y <= 100.0, 'y must be between 0 and 100');

  /// The horizontal position on the field (0 = left, 100 = right).
  final double x;

  /// The vertical position on the field (0 = top, 100 = bottom).
  final double y;

  /// Center of the field.
  static const center = FieldCoordinate(x: 50.0, y: 50.0);

  /// Returns a new [FieldCoordinate] with the given fields replaced.
  FieldCoordinate copyWith({double? x, double? y}) =>
      FieldCoordinate(x: x ?? this.x, y: y ?? this.y);

  /// Returns a vertically mirrored coordinate (`y` becomes `100 - y`).
  FieldCoordinate get mirrored => FieldCoordinate(x: x, y: 100.0 - y);

  /// Returns a horizontally mirrored coordinate (`x` becomes `100 - x`).
  FieldCoordinate get horizontallyMirrored =>
      FieldCoordinate(x: 100.0 - x, y: y);

  /// Returns a coordinate mirrored both vertically and horizontally.
  FieldCoordinate get fullyMirrored =>
      FieldCoordinate(x: 100.0 - x, y: 100.0 - y);

  /// Linearly interpolates between two [FieldCoordinate] values.
  static FieldCoordinate lerp(FieldCoordinate a, FieldCoordinate b, double t) =>
      FieldCoordinate(
        x: a.x + (b.x - a.x) * t,
        y: a.y + (b.y - a.y) * t,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldCoordinate &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => x.hashCode ^ y.hashCode;

  @override
  String toString() => 'FieldCoordinate(x: $x, y: $y)';
}
