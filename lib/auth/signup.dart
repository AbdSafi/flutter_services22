import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/customacctxtpass.dart';
import '../component/customlogo.dart';
import '../component/customtextform.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController cName = TextEditingController();
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                marginH(50),
                const CustomLogo(),
                marginH(50),
                CustomTxtForm(
                  controller: cName,
                  title: "Name",
                  hint: "Enter your name",
                  icon: CupertinoIcons.profile_circled,
                  obscureText: false,
                ),
                marginH(20),
                CustomTxtForm(
                  controller: cEmail,
                  title: "Email",
                  hint: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                  icon: Icons.email,
                  obscureText: false,
                ),
                marginH(20),
                CustomTxtForm(
                  controller: cPassword,
                  title: "Password",
                  hint: "Enter your password",
                  icon: Icons.lock,
                  obscureText: true,
                ),
                ForgetPassHaveAcc(
                  title: 'Do you have account?',
                  onPressed: () {},
                ),
                MaterialButton(
                  padding: const EdgeInsets.all(15),
                  elevation: 5,
                  shape: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  minWidth: double.maxFinite,
                  color: Colors.green,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  SizedBox marginH(double height) {
    return SizedBox(
      height: height,
    );
  }
}
