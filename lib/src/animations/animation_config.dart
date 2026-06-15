import 'package:flutter/widgets.dart';

import '../enums/enums.dart';

/// Configuration for animations used throughout the lineup view.
///
/// Pass this to [SoccerLineupThemeData.animationConfig] to customise how
/// players animate when their positions change, or when the formation changes.
class AnimationConfig {
  /// Creates an [AnimationConfig].
  const AnimationConfig({
    this.type = AnimationType.position,
    this.duration = const Duration(milliseconds: 400),
    this.curve = Curves.easeInOut,
    this.customBuilder,
  });

  /// No animation — instant transitions.
  static const AnimationConfig none = AnimationConfig(
    type: AnimationType.none,
    duration: Duration.zero,
  );

  /// Fade animation.
  static const AnimationConfig fade = AnimationConfig(
    type: AnimationType.fade,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  /// Scale animation.
  static const AnimationConfig scale = AnimationConfig(
    type: AnimationType.scale,
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOutBack,
  );

  /// Slide animation.
  static const AnimationConfig slide = AnimationConfig(
    type: AnimationType.slide,
    duration: Duration(milliseconds: 350),
    curve: Curves.easeInOut,
  );

  /// Animated position transition (default).
  static const AnimationConfig position = AnimationConfig(
    type: AnimationType.position,
    duration: Duration(milliseconds: 400),
    curve: Curves.easeInOut,
  );

  /// The type of animation to apply.
  final AnimationType type;

  /// The duration of the animation.
  final Duration duration;

  /// The animation curve.
  final Curve curve;

  /// An optional custom [AnimatedWidget] builder.
  ///
  /// Only used when [type] is [AnimationType.custom].
  final Widget Function(Animation<double> animation, Widget child)?
      customBuilder;

  /// Returns a copy with the given fields replaced.
  AnimationConfig copyWith({
    AnimationType? type,
    Duration? duration,
    Curve? curve,
    Widget Function(Animation<double> animation, Widget child)? customBuilder,
  }) =>
      AnimationConfig(
        type: type ?? this.type,
        duration: duration ?? this.duration,
        curve: curve ?? this.curve,
        customBuilder: customBuilder ?? this.customBuilder,
      );
}
