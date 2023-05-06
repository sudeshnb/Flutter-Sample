import 'package:flutter/material.dart';

class ScaleUpButton extends StatefulWidget {
  final Widget child;
  final Function onPressed;
  final double scaleUp;

  const ScaleUpButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.scaleUp = 1.2,
  });

  @override
  State<ScaleUpButton> createState() => _ScaleUpButtonState();
}

class _ScaleUpButtonState extends State<ScaleUpButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 200), () {
          _controller.reverse();
        });
        widget.onPressed();
      },
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: widget.scaleUp,
        ).animate(_controller),
        child: ElevatedButton(
          onPressed: null,
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Colors.blue,
            disabledForegroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
          ),
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
