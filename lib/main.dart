import 'package:flutter/material.dart';
import 'package:flutter_services/auth/login.dart';
import 'package:flutter_services/auth/signup.dart';
import 'package:flutter_services/home.dart';

void main() {
  // fireInitialized();
  runApp(const MyApp());
}

/*fireInitialized() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "IndieFlower",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        //useMaterial3: true,
      ),
      home: const SignUp(),
      routes: {
        "home": (context) => const HomePage(title: ""),
        "login": (context) => const Login(),
        "signup": (context) => const SignUp(),
      },
    );
  }
}

