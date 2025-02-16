import 'package:flutter/material.dart';
import 'package:demo_app_futbol7_v2/models/JugadorPs.dart';

class JugadorSelectionScreen extends StatefulWidget {
  final List<JugadorPs> jugadoresDisponibles;

  const JugadorSelectionScreen({
    Key? key,
    required this.jugadoresDisponibles,
  }) : super(key: key);

  @override
  _JugadorSelectionScreenState createState() => _JugadorSelectionScreenState();
}

class _JugadorSelectionScreenState extends State<JugadorSelectionScreen> {
  List<JugadorPs> jugadoresSeleccionados = [];

  void toggleJugadorSeleccion(JugadorPs jugador) {
    setState(() {
      if (jugadoresSeleccionados.contains(jugador)) {
        jugadoresSeleccionados.remove(jugador);
      } else if (jugadoresSeleccionados.length < 7) {
        jugadoresSeleccionados.add(jugador);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco para mejorar la legibilidad
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Selecciona 7 jugadores",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.black),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.jugadoresDisponibles.length,
                itemBuilder: (context, index) {
                  final jugador = widget.jugadoresDisponibles[index];
                  return Card( // Mostrar cada jugador en un Card
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: ListTile(
                      title: Text(
                        jugador.nombre,
                        style: const TextStyle(color: Colors.black), // Texto negro para contraste
                      ),
                      trailing: Icon(
                        jugadoresSeleccionados.contains(jugador)
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: jugadoresSeleccionados.contains(jugador)
                            ? Colors.green
                            : Colors.grey,
                      ),
                      onTap: () => toggleJugadorSeleccion(jugador),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, null), // Cancelar
                    child: const Text("Cancelar", style: TextStyle(color: Colors.red)),
                  ),
                  ElevatedButton(
                    onPressed: jugadoresSeleccionados.length == 7
                        ? () => Navigator.pop(context, jugadoresSeleccionados) // Confirmar selección
                        : null,
                    child: const Text("Aceptar"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}