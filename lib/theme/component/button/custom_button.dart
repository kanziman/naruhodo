import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.buttonName,
    required this.onPressed,
    this.buttonTextStyle,
    this.buttonInsideColor,
    this.buttonBorderColor,
    this.buttonHeight = 47.0,
    this.differentButtonChild,
    this.borderRadius,
    this.padding,
    this.elevation,
    this.shape,
  });

  final String buttonName;
  final TextStyle? buttonTextStyle;
  final VoidCallback? onPressed;
  final Color? buttonInsideColor;
  final Color? buttonBorderColor;
  final Widget? differentButtonChild;
  final double? borderRadius;
  final dynamic buttonHeight;
  final EdgeInsetsGeometry? padding;
  final double? elevation;
  final OutlinedBorder? shape;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
            widget.buttonInsideColor ?? Theme.of(context).primaryColor,
        foregroundColor: widget.buttonTextStyle == null
            ? Colors.white
            : widget.buttonTextStyle!.color,
        shape: widget.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 0.0),
              side: BorderSide(
                color: widget.onPressed == null
                    ? Colors.grey
                    : widget.buttonBorderColor ??
                        Theme.of(context).primaryColor,
              ),
            ),
        elevation: widget.elevation ?? 2,
        padding: widget.padding,
        disabledBackgroundColor: Colors.grey,
      ),
      onPressed: widget.onPressed,
      child: SizedBox(
        height: widget.buttonHeight,
        child: Center(
          child: widget.differentButtonChild ??
              Text(
                widget.buttonName,
                textAlign: TextAlign.center,
                style: widget.onPressed == null
                    ? Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.grey,
                        )
                    : widget.buttonTextStyle ??
                        Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.white,
                            ),
              ),
        ),
      ),
    );
  }
}
