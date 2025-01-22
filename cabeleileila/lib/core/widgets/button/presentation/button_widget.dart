import 'package:cabeleileila/core/colors/colors_system.dart';
import 'package:cabeleileila/core/enums/button_enums.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final String text;
  final ButtonStyleType styleType;
  final ButtonColor color;
  final IconData? startIcon;
  final IconData? endIcon;
  final VoidCallback? action;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.styleType,
    required this.color,
    this.startIcon,
    this.endIcon,
    this.action,
  });

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: _boxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.startIcon != null
                ? Icon(
                    widget.startIcon!,
                    color: _getFontColor(),
                  )
                : SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _getFontColor(),
                ),
              ),
            ),
            widget.endIcon != null
                ? Icon(
                    widget.endIcon!,
                    color: _getFontColor(),
                  )
                : SizedBox(),
          ],
        ),
      ),
      onTap: () => widget.action!(),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      border: widget.styleType == ButtonStyleType.outline
          ? Border.all(
              width: 1.5,
              color: _getColor(),
            )
          : null,
      borderRadius: BorderRadius.circular(10),
      color: widget.styleType == ButtonStyleType.fill ? _getColor() : null,
    );
  }

  Color _getColor() {
    switch (widget.color) {
      case ButtonColor.primary:
        return SystemColors.primary;
      case ButtonColor.secondary:
        return SystemColors.secondary;
      case ButtonColor.danger:
        return SystemColors.danger;
      case ButtonColor.safe:
        return SystemColors.safe;
    }
  }

  Color _getFontColor() {
    if (widget.styleType == ButtonStyleType.fill) {
      return Colors.white;
    }

    return _getColor();
  }
}
