import 'dart:math';

import 'package:flutter/material.dart';

class CircleRotateWidget extends StatefulWidget {
  final int speed;
  final List<String> words;
  final double size;
  final Color textColor;

  const CircleRotateWidget({
    super.key,
    required this.speed,
    required this.words,
    required this.size, required this.textColor,
  });

  @override
  State<CircleRotateWidget> createState() => _CircleRotateWidgetState();
}

class _CircleRotateWidgetState extends State<CircleRotateWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.speed),
      reverseDuration: Duration(seconds: (widget.speed / 2).round()),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.rotate(
          angle: _controller.value * 2 * pi, // Rotate the whole circle
          child: Stack(
            alignment: Alignment.center,
            children: widget.words.asMap().entries.map((entry) {
              int index = entry.key;
              String number = entry.value;

              // Calculate the angle for each number with additional space
              double angle = (index / widget.words.length) * 2 * pi;

              // Add spacing by scaling the x and y positions
              double x = (widget.size / 2) + (widget.size / 2.2) * cos(angle);
              double y = (widget.size / 2) + (widget.size / 2.2) * sin(angle);

              return Transform(
                transform: Matrix4.identity()
                  ..translate(x - widget.size / 2, y - widget.size / 2),
                child: Text(
                  number,
                  style: TextStyle(color: widget.textColor, fontWeight: FontWeight.w600),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}