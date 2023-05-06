import 'package:flutter/material.dart';

class ColorChangeButton extends StatefulWidget {
  final Widget child;
  final Function onPressed;
  final Color startColor;
  final Color endColor;

  const ColorChangeButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.startColor,
    required this.endColor,
  });

  @override
  State<ColorChangeButton> createState() => _ColorChangeButtonState();
}

class _ColorChangeButtonState extends State<ColorChangeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _colorTween = ColorTween(begin: widget.startColor, end: widget.endColor)
        .animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 500), () {
          _controller.reverse();
        });
        widget.onPressed();
      },
      child: AnimatedBuilder(
        animation: _colorTween,
        builder: (context, child) {
          return ElevatedButton(
            onPressed: null,
            style: ElevatedButton.styleFrom(
              disabledForegroundColor: Colors.white,
              disabledBackgroundColor: _colorTween.value,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(16),
            ),
            child: widget.child,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
