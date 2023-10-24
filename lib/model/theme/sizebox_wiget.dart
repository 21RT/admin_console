
import 'package:flutter/material.dart';

class S {
  static H(h) {
    return SizedBox(
      height: h,
    );
  }

  static W(w) {
    return SizedBox(
      width: w,
    );
  }

  static D(d){
    return Divider(
      indent: d,
      endIndent: d,
      color: Colors.black,
      thickness: 0.7,
    );
  }
}