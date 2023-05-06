import 'package:flutter/material.dart';

class ShrinkButton extends StatefulWidget {
  final Widget child;
  final Function onPressed;
  final double shrinkScale;

  const ShrinkButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.shrinkScale = 0.9,
  });

  @override
  State<ShrinkButton> createState() => _ShrinkButtonState();
}

class _ShrinkButtonState extends State<ShrinkButton>
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
          end: widget.shrinkScale,
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
