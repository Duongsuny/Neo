import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:im_hungry/pages/choose_role.dart';
import 'package:im_hungry/pages/components_test.dart';
import 'package:im_hungry/pages/loading.dart';

void main() {
  runApp(const ImHungry());
}

class ImHungry extends StatelessWidget {
  const ImHungry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: HexColor("#754e29"),
        textTheme: GoogleFonts.quicksandTextTheme(),
        scaffoldBackgroundColor: HexColor("#fffaea"),
      ),
      home: ComponentsTest()
    );
  }
}