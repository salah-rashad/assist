import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'link_text.dart';

/// A widget that provides a [LinkTextThemeData] to its descendants.
///
/// This widget is used to establish a theme for [LinkText] widgets in a part of the app's widget tree.
///
/// To obtain the nearest [LinkTextThemeData] from any [BuildContext], use [DefaultLinkTextTheme.of].
class DefaultLinkTextTheme extends InheritedWidget {
  const DefaultLinkTextTheme({
    super.key,
    required this.theme,
    required super.child,
  });

  /// The theme data provided by this widget.
  final LinkTextThemeData theme;

  @override
  bool updateShouldNotify(DefaultLinkTextTheme oldWidget) {
    return theme != oldWidget.theme;
  }

  /// Obtains the nearest [LinkTextThemeData] from the given [BuildContext].
  ///
  /// If no [DefaultLinkTextTheme] is found, returns a default [LinkTextThemeData] instance.
  static LinkTextThemeData of(BuildContext context) {
    final defaultLinkTextTheme =
        context.dependOnInheritedWidgetOfExactType<DefaultLinkTextTheme>();
    return defaultLinkTextTheme?.theme ?? const LinkTextThemeData();
  }
}

/// Holds the theme data for [LinkText] widgets.
///
/// This class is immutable and provides a [copyWith] method to create a new instance with modified properties.
class LinkTextThemeData with Diagnosticable {
  const LinkTextThemeData({
    this.style,
    this.hoverColor,
    this.showIcon,
    this.icon,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  /// The text style for the link text.
  final TextStyle? style;

  /// The color of the link text and icon when hovered.
  final Color? hoverColor;

  /// Determines whether to show icon at the end of the link text or not.
  final bool? showIcon;

  /// The icon to be shown at the end of the link text.
  final Widget? icon;

  // The properties of the text.
  final StrutStyle? strutStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final TextScaler? textScaler;
  final int? maxLines;
  final String? semanticsLabel;
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;

  /// Creates a new [LinkTextThemeData] instance with the given properties.
  ///
  /// If a property is not provided, the corresponding property from this instance is used.
  LinkTextThemeData copyWith({
    TextStyle? style,
    Color? hoverColor,
    bool? showIcon,
    Widget? icon,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    TextScaler? textScaler,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
    Color? selectionColor,
  }) {
    return LinkTextThemeData(
      style: style ?? this.style,
      hoverColor: hoverColor ?? this.hoverColor,
      showIcon: showIcon ?? this.showIcon,
      icon: icon ?? this.icon,
      strutStyle: strutStyle ?? this.strutStyle,
      textAlign: textAlign ?? this.textAlign,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      overflow: overflow ?? overflow,
      textScaler: textScaler ?? this.textScaler,
      maxLines: maxLines ?? this.maxLines,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      textWidthBasis: textWidthBasis ?? this.textWidthBasis,
      textHeightBehavior: textHeightBehavior ?? textHeightBehavior,
      selectionColor: selectionColor ?? this.selectionColor,
    );
  }
}
