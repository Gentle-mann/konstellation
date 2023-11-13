import 'package:flutter/material.dart';

class TimerField extends StatelessWidget {
  const TimerField({
    super.key,
    required this.title,
    required this.controller,
    this.autofocus = false,
  });
  final String title;
  final TextEditingController controller;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      autofocus: autofocus,
      decoration: InputDecoration(
        label: Text(title),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
