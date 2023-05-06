import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      color: Colors.black54,
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.0, vertical: 8.0),
        child: Text(
          "Visit",
          style: TextStyle(
              color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "You pushed the button ",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.black54,
          ),
        );
      },
    );
  }
}
