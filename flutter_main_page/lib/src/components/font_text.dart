import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum FontType { MAIN, SUB }

class FontText extends StatelessWidget {
  final FontType type;
  final double fontSize;
  final String text;
  const FontText({super.key, required this.type, this.fontSize = 17, required this.text});

  @override
  Widget build(BuildContext context) {

    switch(type) {
      case FontType.MAIN:
        return Text(
                text,
                style: GoogleFonts.eastSeaDokdo(
                  textStyle: TextStyle(
                    fontSize: fontSize,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        );
      case FontType.SUB:
        return Text(
                text,
                style: GoogleFonts.doHyeon(
                  textStyle: TextStyle(
                    fontSize: fontSize,
                    color: Colors.black,
                    
                  ),
                ),
              );
    }
  }
}