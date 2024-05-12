import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
   MyTextField({super.key, 
   required this.hint, 
   required this.controller,
   required this.myValidator,
   this.myIcon,this.myPrefixText,
    this.myOnsaved, required this.isEmail, required this.isPassword, required this.isNumber,
    
   });

  String hint;
  String? myPrefixText;
  TextEditingController controller = TextEditingController();
  Icon? myIcon;
  final String? Function(String?) ? myValidator;
  final String? Function(String?) ? myOnsaved;
  final bool isEmail;
  final bool isPassword;
  final bool isNumber;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        prefixText: myPrefixText,
        prefixStyle: const TextStyle(color: Colors.black),
        hintStyle: GoogleFonts.signikaNegative(
          fontWeight: FontWeight.w400,
        ),
        icon: myIcon,
      ),
      
      keyboardType: isEmail ? TextInputType.emailAddress : isNumber ? TextInputType.number : null,
      obscureText: isPassword ? true : false,
      autocorrect: isEmail ? false : isPassword ? false : true,
      textCapitalization: isEmail? TextCapitalization.none : isPassword ? TextCapitalization.none : TextCapitalization.words,
      controller: controller,
      onSaved: myOnsaved,
      validator: myValidator,
    );
  }
}