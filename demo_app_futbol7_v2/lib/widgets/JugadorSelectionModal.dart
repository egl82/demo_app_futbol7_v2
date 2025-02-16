import 'package:flutter/material.dart';
import 'package:demo_app_futbol7_v2/models/JugadorPs.dart'; // Ajusta la ruta según tu proyecto

class JugadorSelectionModal extends StatefulWidget {
  final List<JugadorPs> jugadoresDisponibles;
  final Function(List<JugadorPs>) onJugadoresSeleccionados;

  const JugadorSelectionModal({
    super.key,
    required this.jugadoresDisponibles,
    required this.onJugadoresSeleccionados,
  });

  @override
  _JugadorSelectionModalState createState() => _JugadorSelectionModalState();
}

class _JugadorSelectionModalState extends State<JugadorSelectionModal> {
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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Selecciona 7 jugadores",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.jugadoresDisponibles.length,
              itemBuilder: (context, index) {
                final jugador = widget.jugadoresDisponibles[index];
                return ListTile(
                  title: Text(jugador.nombre),
                  trailing: Icon(
                    jugadoresSeleccionados.contains(jugador)
                        ? Icons.check_circle
                        : Icons.circle_outlined,
                    color: jugadoresSeleccionados.contains(jugador)
                        ? Colors.green
                        : Colors.grey,
                  ),
                  onTap: () => toggleJugadorSeleccion(jugador),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: jugadoresSeleccionados.length == 7
                    ? () {
                        widget.onJugadoresSeleccionados(jugadoresSeleccionados);
                        Navigator.pop(context);
                      }
                    : null,
                child: const Text("Aceptar"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}