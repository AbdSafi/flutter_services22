import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../component/customacctxtpass.dart';
import '../component/customlogo.dart';
import '../component/customtextform.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();

  static AwesomeDialog buildAwesomeDialog(
      BuildContext context, String title, String description) {
    return AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.rightSlide,
      title: title,
      desc: description,
      btnOkOnPress: () {},
    );
  }
}

class _SignUpState extends State<SignUp> {
  TextEditingController cName = TextEditingController();
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
                    controller: cName,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This Filed Can’t Be Empty";
                      }
                      return null;
                    },
                    title: "Name",
                    hint: "Enter your name",
                    icon: CupertinoIcons.profile_circled,
                    obscureText: false,
                  ),
                  marginH(20),
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
                    title: 'Do you have account?',
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed("login"),
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
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: cEmail.text,
                            password: cPassword.text,
                          );
                          FirebaseAuth.instance.currentUser!
                              .sendEmailVerification();
                          Navigator.of(context).pushReplacementNamed("login");
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            // ignore: use_build_context_synchronously
                            SignUp.buildAwesomeDialog(context, "Weak Password",
                                    "The password provided is too weak.")
                                .show();
                            print("The password provided is too weak");
                          } else if (e.code == 'email-already-in-use') {
                            // ignore: use_build_context_synchronously
                            SignUp.buildAwesomeDialog(
                                    context,
                                    " account already exists",
                                    "The account already exists for that email.")
                                .show();
                            print("The account already exists for that email");
                          }
                        } catch (e) {
                          print(e);
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
