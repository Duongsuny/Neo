import 'package:firebase_auth/firebase_auth.dart';
import "package:im_hungry/colors.dart";
import "package:im_hungry/components/shadow.dart";
import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController phoneNumber = TextEditingController();
  String phoneNumberConverted() {
    return "$countryCode ${phoneNumber.text.startsWith('0') ? phoneNumber.text.substring(1) : phoneNumber.text}";
  }

  String countryCode = "+84";
  void onCountryChanged(Country country) {
    setState(() {
      countryCode = country.dialCode;
    });
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  TextStyle phoneNumberStyle = TextStyle(
      color: HungryColors().surfaceBrown,
      fontSize: 18,
      fontWeight: FontWeight.bold);

  void signIn() async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumberConverted(),
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (e) {
          if (e.code == 'invalid-phone-number') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 20),
              duration: Durations.long4,
              content: Text(
                "SDT khong hop le",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: HungryColors().backYellow,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              backgroundColor: const Color.fromARGB(255, 152, 75, 60),
              behavior: SnackBarBehavior.floating,
            ));
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          String smsCode = '123456';
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);
          await auth.signInWithCredential(credential);
        },
        codeAutoRetrievalTimeout: (verificationId) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: HungryColors().backYellow,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: NeoShadow(
                              blurRadius: 15,
                              offset: 5,
                              opacity: 0.3,
                              inset: true)
                          .shadow),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: IntlPhoneField(
                      controller: phoneNumber,
                      cursorColor: HungryColors().surfaceBrown,
                      initialCountryCode: "VN",
                      onCountryChanged: onCountryChanged,
                      disableLengthCheck: true,
                      style: phoneNumberStyle,
                      dropdownTextStyle: phoneNumberStyle,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: signIn,
                  child: Container(
                    height: 80,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: HungryColors().backYellow,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow:
                            NeoShadow(blurRadius: 20, offset: 10, opacity: 0.2)
                                .shadow),
                    child: Text(
                      "Login",
                      style: phoneNumberStyle,
                    ),
                  ),
                ),
              ],
            )),
      )),
    );
  }
}