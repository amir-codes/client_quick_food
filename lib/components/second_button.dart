import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key,
      required this.text,
      required this.icon,
      required this.myFunction});
  final String text;
  final Icon icon;
  final Function() myFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: ElevatedButton(
        style: ButtonStyle(
          iconColor: MaterialStateProperty.all(Colors.black),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: myFunction,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            children: [
              icon,
              const SizedBox(
                width: 18,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyTextButton {
  final String myButtonLabel;
  final Function() myOnPressedFct;

  MyTextButton({required this.myButtonLabel, required this.myOnPressedFct});

  TextButton buildButton() {
    return TextButton(
      onPressed: myOnPressedFct,
      style: TextButton.styleFrom(
        fixedSize: const Size.fromWidth(200),
        backgroundColor: Colors.white,
        side: const BorderSide(
            color: Colors.redAccent,
            width: 3.5), // Couleur et épaisseur de la bordure
        shadowColor: Colors.black.withOpacity(0.8),
        elevation: 10,
      ),
      child: Text(
        myButtonLabel,
        style: const TextStyle(
          color: Colors.redAccent,
          fontSize: 20,
        ),
      ),
    );
  }
}