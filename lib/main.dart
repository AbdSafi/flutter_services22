import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_services/auth/login.dart';
import 'package:flutter_services/auth/signup.dart';
import 'package:flutter_services/category/addcat.dart';
import 'package:flutter_services/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('-----------------User is currently signed out!');
      } else {
        print('-----------------User is signed in!');
      }
    });

    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "IndieFlower",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green),

        //useMaterial3: true,
      ),
      home: (FirebaseAuth.instance.currentUser != null &&
              FirebaseAuth.instance.currentUser!.emailVerified)
          ? const HomePage(title: "")
          : const Login(),
      routes: {
        "home": (context) => const HomePage(title: ""),
        "login": (context) => const Login(),
        "signup": (context) => const SignUp(),
        "addcat": (context) => const AddCategories(),
      },
    );
  }
}
