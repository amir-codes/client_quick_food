import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({super.key, required this.mybuttonLabel, required this.myOnpressedFct});
  final String mybuttonLabel;
  final Function() myOnpressedFct;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: myOnpressedFct,
        child: Text(mybuttonLabel,
            style: const TextStyle(
                color: Colors.redAccent,
                decoration: TextDecoration.underline,
                decorationColor: Colors.redAccent)));
  }
}
