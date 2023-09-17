import 'package:flutter/material.dart';
import 'package:flutter_services/component/customlogo.dart';
import 'package:flutter_services/component/customtextform.dart';

import '../component/customacctxtpass.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
                  title: 'Forget your Password?',
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
                    "Login",
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
