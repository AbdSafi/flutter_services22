import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_services/auth/signup.dart';
import 'package:flutter_services/component/customlogo.dart';
import 'package:flutter_services/component/customtextform.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) return;

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
  }

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
                  CustomButtonLogin(
                      formKey: formKey, cEmail: cEmail, cPassword: cPassword),
                  SizedBox(
                    width: double.infinity,
                    child: MaterialButton(
                      color: Colors.red,
                      onPressed: () {
                        signInWithGoogle();
                      },
                      textColor: Colors.white,
                      child: const Text("Login with google"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  ///
  SizedBox marginH(double height) {
    return SizedBox(
      height: height,
    );
  }
}

class CustomButtonLogin extends StatelessWidget {
  const CustomButtonLogin({
    super.key,
    required this.formKey,
    required this.cEmail,
    required this.cPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController cEmail;
  final TextEditingController cPassword;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
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
            if (FirebaseAuth.instance.currentUser!.emailVerified) {
              Navigator.of(context).pushReplacementNamed("home");
            } else {
              SignUp.buildAwesomeDialog(
                      context, "check your email ", "Verify your email")
                  .show();
            }
          } on FirebaseAuthException catch (e) {
            if (e.code == 'user-not-found') {
              print('------------------No user found for that email.');
            } else if (e.code == 'wrong-password') {
              print('------------------Wrong password provided for that user.');
            } else {
              print('-----------${e.code}');
            }
          }
        }
      },
    );
  }
}
///