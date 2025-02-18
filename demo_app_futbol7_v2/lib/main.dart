// main.dart

import 'package:flutter/material.dart';
/* import 'package:provider/provider.dart';
import 'screens/HomeScreen.dart'; // Asegúrate de que esta ruta sea correcta
import 'models/equipoManager.dart'; // Asegúrate de que esta ruta sea correcta */


import 'package:demo_app_futbol7_v2/screens/LoginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fútbol 7 App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(), // Establecemos LoginScreen como pantalla inicial
    );
  }
}