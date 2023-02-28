import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final bool isPrivate;
  final TextEditingController controller;
  final TextInputType type;
  final String hintText;
  final Icon? prefixIcon;
  const CustomTextField({super.key, this.isPrivate=false, required this.controller, this.type = TextInputType.none, this.hintText = '', this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type,
      obscureText: isPrivate,
      decoration: InputDecoration(
          prefixIcon: prefixIcon,
          hintText: hintText,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(4.0))),
          enabledBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.black, width: 1.0),
            borderRadius:
                BorderRadius.all(Radius.circular(4.0)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: Colors.black, width: 2.0),
              borderRadius:
                  BorderRadius.all(Radius.circular(4.0))),
          suffixIcon: GestureDetector(
            child: const Icon(
              Icons.clear,
              size: 20,
            ),
            onTap: () => controller.clear(),
          ),
          filled: true,
          fillColor: Colors.white),
    );
  }
}