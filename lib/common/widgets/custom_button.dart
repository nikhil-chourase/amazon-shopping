import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.text, required this.onTap, this.color});

  final String text;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap, 
      child: Text(
        text,
        style: TextStyle(
          color: color == null ? Colors.white : Colors.black,
        ),
        ),

      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: color ?? GlobalVariables.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5), // Set the desired radius here
        ),
        
      ),
      );
  }
}