import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key, required this.mybuttonLabel, required this.myOnpressedFct,required this.myColor});
  final String mybuttonLabel;
  final Function() myOnpressedFct;
  final Color myColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ElevatedButton(
      onPressed: myOnpressedFct,
      style: ElevatedButton.styleFrom(
        backgroundColor: myColor,
      ),
      child: Text(
        mybuttonLabel,
        style:  const TextStyle(color: Colors.white),
      ),
    ));
  }
}

