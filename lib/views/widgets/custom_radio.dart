import 'package:flutter/material.dart';

class CustomRadio extends StatefulWidget {
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.color,
    required this.selectedColor,
    required this.onPressed,
  });
  final int value;
  final int groupValue;
  final Color color;
  final Color selectedColor;
  final void Function(int) onPressed;

  @override
  State<CustomRadio> createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bool selected = widget.value != widget.groupValue;
        if (selected) {
          widget.onPressed(widget.value);
        }
      },
      child: Container(
        height: 18.0,
        width: 18.0,
        decoration: BoxDecoration(
          color: widget.value == widget.groupValue
              ? widget.selectedColor
              : widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
