import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:im_hungry/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset("lib/assets/loading_cat.png"),
          Text("Đợi xíu",
          style: TextStyle(
            fontSize: 20,
            color: HungryColors().surfaceBrown,
            fontWeight: FontWeight.w900
          ))
        ],
      )
    );
  }
}