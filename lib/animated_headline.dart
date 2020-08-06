library animated_headline;

import 'package:flutter/material.dart';

/// This is the [AnimatedHeadline] widget to display the headlines of many tabs.
/// While the switch between two tabs the headline will animate and switch between 2 [colors] and of course change the [texts].
class AnimatedHeadline extends ImplicitlyAnimatedWidget {
  /// The [texts] of the headline.
  /// Its length must be higher than one.
  final List<String> texts;

  /// The [colors] to use for the [texts].
  /// Specify the color for each text.
  /// Its length must be higher than one and equal to the [texts] list length.
  final List<Color> colors;

  /// The [index] to show the correct text.
  /// It must be higher than one (or equal to one) and lower than the [texts] list length.
  final int index;

  /// A getter to display the correct text.
  String get targetTitle => texts[index];

  /// A getter to display the text in the correct color.
  Color get targetColor => colors[index];

  /// Creates an animated headline while the switch between two tabs.
  const AnimatedHeadline(
      {Key key,
      @required this.texts,
      @required this.colors,
      @required this.index})
      : assert(texts.length != null && texts.length > 1),
        assert(colors.length != null && colors.length > 1),
        assert(texts.length == colors.length),
        assert(index >= 0 && index < texts.length),
        super(key: key, duration: const Duration(milliseconds: 400));

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() {
    return _AnimatedHeadlineState();
  }
}

class _AnimatedHeadlineState extends AnimatedWidgetBaseState<AnimatedHeadline> {
  CustomColorTween _colorTween;
  StringTween _stringTween;

  @override
  Widget build(BuildContext context) {
    return Text(
      _stringTween.evaluate(animation),
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
      (color) => CustomColorTween(begin: color),
    );

    _stringTween = visitor(
      _stringTween,
      widget.targetTitle,
      (title) => StringTween(begin: title),
    );
  }
}

class CustomColorTween extends Tween<Color> {
  Color middle = Colors.transparent;
  CustomColorTween({Color begin, Color end}) : super(begin: begin, end: end);

  Color lerp(double t) {
    if (t < 0.5) return Color.lerp(begin, middle, t * 2);
    return Color.lerp(middle, end, (t - 0.5) * 2);
  }
}

class StringTween extends Tween<String> {
  StringTween({String begin, String end}) : super(begin: begin, end: end);

  String lerp(double t) {
    if (t < 0.5) return begin;
    return end;
  }
}
