import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final double height;
  final VoidCallback? onPressed;
  final Widget? leadingIcon;
  final OutlinedBorder? shapeBorder;
  final bool isSecondary;
  final bool isOutline;

  const CustomButton({
    Key? key,
    required this.text,
    this.height = 40,
    this.onPressed,
    this.leadingIcon,
    this.shapeBorder,
    this.isSecondary = false,
  })  : isOutline = false,
        super(key: key);

  const CustomButton.outline({
    Key? key,
    required this.text,
    this.height = 40,
    this.onPressed,
    this.leadingIcon,
    this.shapeBorder,
    this.isSecondary = false,
  })  : isOutline = true,
        super(key: key);

  OutlinedBorder _shapeBorder(BuildContext context) =>
      shapeBorder ??
      RoundedRectangleBorder(
        side: isSecondary
            ? BorderSide(
                color: Theme.of(context).primaryColor,
                width: 1,
                style: BorderStyle.solid)
            : BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      );

  Color _color(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final color = isSecondary ? Colors.transparent : primaryColor;
    return isSecondary
        ? primaryColor
        : color.computeLuminance() > 0.5
            ? Colors.black
            : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final color = isSecondary ? Colors.transparent : primaryColor;
    return ButtonTheme(
      height: height,
      buttonColor: color,
      minWidth: double.infinity,
      child: isOutline
          ? OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                backgroundColor: color,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: _shapeBorder(context),
              ).copyWith(
                  side: MaterialStateProperty.all(BorderSide(
                color: _color(context),
                width: 2,
              ))),
              icon: leadingIcon ?? const SizedBox(),
              label: _LabelWidget(text: text, color: _color(context)),
              onPressed: onPressed,
            )
          : TextButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: color,
                shape: _shapeBorder(context),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                onSurface: Colors.grey,
              ),
              icon: leadingIcon ?? const SizedBox(),
              label: _LabelWidget(text: text, color: _color(context)),
              onPressed: onPressed,
            ),
    );
  }
}

class _LabelWidget extends StatelessWidget {
  const _LabelWidget({Key? key, required this.text, this.color}) : super(key: key);

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(color: color),
    );
  }
}

