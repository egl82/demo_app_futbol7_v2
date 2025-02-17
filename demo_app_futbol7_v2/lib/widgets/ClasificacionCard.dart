import 'package:demo_app_futbol7_v2/models/Usuario.dart';
import 'package:flutter/material.dart';

class ClasificacionCard extends StatelessWidget {
  final List<Usuario> usuarios;

  const ClasificacionCard({
    Key? key,
    required this.usuarios,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título del Card
            const Text(
              "Clasificación General",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 8),

            // Lista de Usuarios Ordenada por Puntos
            ListView.builder(
              shrinkWrap: true, // Permite que el ListView se adapte al contenido
              physics: const NeverScrollableScrollPhysics(), // Desactiva el scroll interno
              itemCount: usuarios.length,
              itemBuilder: (context, index) {
                // Ordenar usuarios por puntos antes de mostrarlos
                List<Usuario> usuariosOrdenados = List.from(usuarios)
                  ..sort((a, b) => b.puntos.compareTo(a.puntos)); // Descendente

                Usuario usuario = usuariosOrdenados[index];

                return ListTile(
                  leading: Text(
                    "${index + 1}.", // Posición en la clasificación
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  title: Text(
                    usuario.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "${usuario.puntos} pts", // Mostrar puntos
                    style: const TextStyle(color: Colors.green),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}