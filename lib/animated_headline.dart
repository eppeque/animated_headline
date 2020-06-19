library animated_headline;

import 'package:flutter/material.dart';

/// This is the [AnimatedHeadline] widget to display the headlines of two tabs.
/// While the switch between the two tabs the headline will animate and switch between 2 [colors] and of course change the [texts].

class AnimatedHeadline extends ImplicitlyAnimatedWidget {
  /// The [texts] of the headline.
  /// Its length must be equal to two.
  final List<String> texts;

  /// The [index] to show the correct title.
  /// It must be one or two.
  final int index;

  /// The [colors] to use for the headline.
  /// Its length must be equal to two.
  final List<Color> colors;

  String get targetText => texts[index];

  Color get targetColor => colors[index];

  /// Creates a headline animated while the switch between two tabs.
  const AnimatedHeadline(
      {Key key,
      @required this.texts,
      @required this.index,
      @required this.colors})
      : assert(texts.length == 2 && texts != null),
        assert(index < 2 && index != null),
        assert(colors.length == 2 && colors != null),
        super(
          key: key,
          duration: const Duration(milliseconds: 400),
        );

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return AnimatedHeadlineState();
  }
}

class AnimatedHeadlineState extends AnimatedWidgetBaseState<AnimatedHeadline> {
  ColorTween _colorTween;
  GhostStringAnimation _stringAnimation;

  @override
  Widget build(BuildContext context) {
    return Text(
      _stringAnimation.evaluate(animation),
      style: TextStyle(
        fontSize: 24.0,
        color: _colorTween.evaluate(animation),
      ),
    );
  }

  @override
  void forEachTween(visitor) {
    _colorTween = visitor(
      _colorTween,
      widget.targetColor,
      (color) => ColorTween(begin: color),
    );

    _stringAnimation = visitor(
      _stringAnimation,
      widget.targetText,
      (value) => GhostStringAnimation(begin: value),
    );
  }
}

class GhostStringAnimation extends Tween<String> {
  GhostStringAnimation({String begin, String end}) : super(begin: begin, end: end);

  String lerp(double t) {
    if (t < 0.5) return begin;
    return end;
  }
}