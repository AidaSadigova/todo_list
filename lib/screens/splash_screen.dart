import 'package:flutter/material.dart';
import 'package:todo_list/screens/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const HomePage(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [
          0.2,
          0.6,
          0.9,
        ],
        colors: [
          Colors.purple,
          Colors.white,
          Colors.indigo,
        ],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'To-do App',
                style: GoogleFonts.croissantOne(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50.0,
                    color: Color.fromARGB(255, 140, 75, 151),
                    letterSpacing: .5,
                  ),
                ),
              ),
              const CircularProgressIndicator(
                color: Color.fromARGB(255, 154, 71, 202),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
