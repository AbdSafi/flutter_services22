import 'package:firebase_auth/firebase_auth.dart';
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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: ListView(
        children: [
          Form(
            key: formKey,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  marginH(50),
                  const CustomLogo(),
                  marginH(50),
                  CustomTxtForm(
                    controller: cEmail,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Filed Can’t Be Empty";
                      }
                      return null;
                    },
                    title: "Email",
                    hint: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    icon: Icons.email,
                    obscureText: false,
                  ),
                  marginH(20),
                  CustomTxtForm(
                    controller: cPassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Filed Can’t Be Empty";
                      }
                      return null;
                    },
                    title: "Password",
                    hint: "Enter your password",
                    icon: Icons.lock,
                    obscureText: true,
                  ),
                  ForgetPassHaveAcc(
                    title: 'Forget your Password?',
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed("signup"),
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
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: cEmail.text, password: cPassword.text);
                          //if (!context.mounted) return;
                          Navigator.of(context).pushReplacementNamed("home");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user not found') {
                            print(
                                '------------------No user found for that email.');
                          } else if (e.code == 'wrong password') {
                            print(
                                '------------------Wrong password provided for that user.');
                          } else {
                            print('-----------${e.code}');
                          }
                        }
                      }
                    },
                  ),
                ],
              ),
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
