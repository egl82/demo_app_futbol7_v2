// widgets/equipoWidget.dart

import 'package:demo_app_futbol7_v2/models/JugadorPs.dart';
import 'package:flutter/material.dart';



class EquipoWidget extends StatelessWidget {
  final List<JugadorPs> equipo;
  final Color color;
  final String title;

  const EquipoWidget({
    super.key,
    required this.equipo,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color.withOpacity(0.7), // Fondo semi-transparente
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            ...equipo.map((jugador) {
              return ListTile(
                title: Text(
                  jugador.nombre,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}