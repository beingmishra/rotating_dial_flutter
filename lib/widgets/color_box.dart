import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final bool isSelected;
  final Color color;
  final VoidCallback onSelect;
  const ColorBox({super.key, required this.isSelected, required this.color, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black,
                width: 2
            ),
            borderRadius: BorderRadius.circular(16),
            color: color
        ),
        child: isSelected ? const Icon(Icons.check, color: Colors.white,) : const SizedBox(),
      ),
    );
  }
}
