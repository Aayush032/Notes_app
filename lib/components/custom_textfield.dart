import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController descriptionController;
  final String hintText;
  final int maxLines;
  final Color bgColor;

  const CustomTextField({super.key, required this.descriptionController, required this.hintText, required this.maxLines, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(
          // color: Theme.of(context).colorScheme.inversePrimary
        ),
       borderRadius: BorderRadius.circular(15)
      ),
      child: TextField(
        controller: descriptionController,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}