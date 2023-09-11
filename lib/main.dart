import 'package:flutter/material.dart';
import 'package:newsapp/view/splash_screen.dart';

void main() {
  runApp(const MyApp());

  // https://newsapi.org/v2/everything?q=bitcoin&apiKey=ae739577b56c46baa6f90975a6ae465a
  // https://newsapi.org/v2/top-headlines?country=us&apiKey=ae739577b56c46baa6f90975a6ae465a
  // Your API key is: ae739577b56c46baa6f90975a6ae465a
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
