// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/HomeScreen.dart'; // Asegúrate de que esta ruta sea correcta
import 'models/equipoManager.dart'; // Asegúrate de que esta ruta sea correcta

// main.dart

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EquipoManager(jugadores: []), // Proveer el EquipoManager
      child: MaterialApp(
        title: 'Fútbol 7 App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.transparent, // Fondo transparente para la app
        ),
        home: HomeScreen(),
      ),
    );
  }
}