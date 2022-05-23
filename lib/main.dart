import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytutor/views/loginscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Tutor',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(),
        ),
      ),
      home: const MySplashScreen(title: 'My Tutor'),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key, required String title}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  late double screenHeight, screenWidth;
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(64.0),
                child: Image.asset(
                  'assets/images/mytutor.png',
                  scale: 2.0,
                ),
              ),
              const Text(
                "Login",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const CircularProgressIndicator(),
              const Text("Version 0.1",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
