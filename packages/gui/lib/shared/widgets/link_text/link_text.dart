import 'package:assist_gui/shared/widgets/link_text/default_link_text_theme.dart';
import 'package:flutter/material.dart';

/// A clickable text widget with effects on hover.
///
/// This widget displays a text that can be tapped to perform an action.
/// It also provides a visual effect when the text is hovered over.
///
/// - [data] is the text to be displayed.
///
/// - [onTap] is the callback function to be executed when the text is tapped.
///
/// - [showIcon] determines whether to show icon at the end of the text or not.
///
/// - [icon] is the icon to be shown at the end of the text. The default is arrow icon.
///
/// - [hoverColor] is the color to be used for the text and icon when it is hovered.
///
/// - other properties are the same as [Text] widget.
class LinkText extends StatefulWidget {
  const LinkText(
    this.data, {
    super.key,
    this.onTap,
    this.showIcon,
    this.icon,
    this.hoverColor,
    this.style,
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

  final String data;
  final VoidCallback? onTap;
  final bool? showIcon;
  final Widget? icon;
  final Color? hoverColor;
  final TextStyle? style;
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

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool _isHovered = false;

  LinkTextThemeData get theme => DefaultLinkTextTheme.of(context);

  Color get hoverColor =>
      theme.hoverColor ??
      widget.hoverColor ??
      Theme.of(context).colorScheme.primary;

  TextStyle? get style {
    final style = theme.style ?? widget.style;
    return const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400)
        .copyWith(
          decorationStyle: TextDecorationStyle.solid,
          decoration: _isHovered ? TextDecoration.underline : null,
          decorationThickness: 3,
        )
        .merge(style)
        .apply(
          color: _isHovered ? hoverColor : null,
          decorationColor:
              _isHovered ? hoverColor.withValues(alpha: 0.3) : null,
        );
  }

  bool get showIcon => widget.showIcon ?? theme.showIcon ?? true;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        behavior: HitTestBehavior.opaque,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                widget.data,
                style: style,
                strutStyle: widget.strutStyle ?? theme.strutStyle,
                textAlign: widget.textAlign ?? theme.textAlign,
                textDirection: widget.textDirection ?? theme.textDirection,
                locale: widget.locale ?? theme.locale,
                softWrap: widget.softWrap ?? theme.softWrap,
                overflow: widget.overflow ?? theme.overflow,
                textScaler: widget.textScaler ?? theme.textScaler,
                maxLines: widget.maxLines ?? theme.maxLines,
                semanticsLabel: widget.semanticsLabel ?? theme.semanticsLabel,
                textWidthBasis: widget.textWidthBasis ?? theme.textWidthBasis,
                textHeightBehavior:
                    widget.textHeightBehavior ?? theme.textHeightBehavior,
                selectionColor: widget.selectionColor ?? theme.selectionColor,
              ),
            ),
            if (_isHovered && showIcon)
              Align(
                alignment: AlignmentDirectional.centerStart,
                widthFactor: 0,
                child: TweenAnimationBuilder(
                  curve: Curves.fastEaseInToSlowEaseOut,
                  tween: Tween(begin: 0.0, end: 4.0),
                  duration: const Duration(milliseconds: 200),
                  builder: (context, value, child) {
                    value = Directionality.of(context) == TextDirection.rtl
                        ? -value
                        : value;
                    return Transform.translate(
                      offset: Offset(value, 0.0),
                      child: child,
                    );
                  },
                  child: IconTheme(
                    data: IconThemeData(
                      size: 16.0,
                      color: _isHovered ? hoverColor : style?.color,
                    ),
                    child: widget.icon ??
                        theme.icon ??
                        const Icon(Icons.arrow_forward_rounded),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
