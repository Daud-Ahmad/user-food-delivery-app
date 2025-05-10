import 'package:flutter/material.dart';

const cGray = Color(0xFFFAFAFA);
const cBlack = Color(0xFF000000);
const cButtonColor = Color(0xFF8660D7);
const cGradientColor2 = Color(0xFFD159DB);
const cBlack50 = Color(0x50000000);
const cUnselectedTabColor = Color(0xFF6C6C6C);
const cSelectedTabColor = Color(0xFF793FDA);
const cTitleColor = Color(0xFF393939);
const cMessageColor = Color(0xFF323232);
const cTextColorBlack = Color(0xFF323232);

abstract class TextStyles {
  static const TextStyle standard = TextStyle(
    color: Color.fromRGBO(0, 0, 0, 1.0),
    fontSize: 16,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.normal,
  );
}

abstract class InputStyles {
  static InputDecoration genInput({hint, icon, suffixIcon}) {
    return InputDecoration(
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(
          color: Color.fromRGBO(0x6b, 0xaa, 0xc7, 1.0),
          width: 1.0,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      hintText: hint,
      prefixIcon: Icon(icon),
      suffixIcon: suffixIcon,
    );
  }


  static InputDecoration getAuthInput({hint, suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: cGray,
      counterText: '',
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(
          color: cBlack50,
          width: 1.0,
        ),
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
        borderSide: BorderSide(
          color: cBlack50,
          width: 2.0,
        ),
      ),
      // hintText: hint,
      labelText: hint,
      labelStyle: const TextStyle(color: cBlack50),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15)
    );
  }

  static InputDecoration getDescriptionInput({hint, suffixIcon}) {
    return InputDecoration(
        filled: true,
        fillColor: cGray,
        counterText: '',
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: cBlack50,
            width: 1.0,
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(
            color: cBlack50,
            width: 2.0,
          ),
        ),
        // hintText: hint,
        labelText: hint,
        labelStyle: const TextStyle(color: cBlack50),
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10)
    );
  }
}
