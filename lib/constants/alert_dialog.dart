import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;
  final Function()? onButtonPressed;

  const MyAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.green, width: 2),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.green,
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Lato',
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Cabin',
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.green,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Colors.white, width: 2),
            ),
          ),
          onPressed: onButtonPressed,
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
