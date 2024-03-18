import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rota_rehberi/screens/home.dart';
import 'package:rota_rehberi/screens/signin.dart';
import 'package:rota_rehberi/screens/signup.dart';
import 'package:rota_rehberi/screens/wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rota Rehberi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue, backgroundColor: Colors.white),
        useMaterial3: true,
      ),
      // Initial route set to Wrapper to handle authentication state
      initialRoute: '/',
      routes: {
        '/': (context) => const Wrapper(),
        '/home': (context) => const MyHomePage(),
        '/signin': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
