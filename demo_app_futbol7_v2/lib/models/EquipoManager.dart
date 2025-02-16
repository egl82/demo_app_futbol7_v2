// models/equipoManager.dart

import 'dart:math';
import 'package:flutter/foundation.dart'; // Importante para ChangeNotifier
import 'package:demo_app_futbol7_v2/models/JugadorPs.dart';

class EquipoManager with ChangeNotifier {
  List<JugadorPs> jugadores;
  List<JugadorPs> equipoClaros = [];
  List<JugadorPs> equipoOscuros = [];
  bool seleccionEquipoClaros = true; // Iniciamos seleccionando equipo claros
  bool seleccionFinalizada = false;

  EquipoManager({required this.jugadores});

  List<JugadorPs> get jugadoresSeleccionados {
    return seleccionEquipoClaros ? equipoClaros : equipoOscuros;
  }

  void seleccionarJugador(JugadorPs jugador) {
    if (jugador.seleccionado) {
      // Deseleccionar jugador
      if (seleccionEquipoClaros) {
        equipoClaros.remove(jugador);
      } else {
        equipoOscuros.remove(jugador);
      }
      jugador.seleccionado = false;
    } else {
      // Seleccionar jugador
      if (seleccionEquipoClaros && equipoClaros.length < 7) {
        equipoClaros.add(jugador);
        jugador.seleccionado = true;
      } else if (!seleccionEquipoClaros && equipoOscuros.length < 7) {
        equipoOscuros.add(jugador);
        jugador.seleccionado = true;
      }
    }

    // Verificar si la selección está finalizada
    if (equipoClaros.length == 7 && equipoOscuros.length == 7) {
      seleccionFinalizada = true;
    } else {
      seleccionFinalizada = false;
    }

    notifyListeners(); // Notificar cambios al estado
  }

  void cambiarEquipo() {
    seleccionEquipoClaros = !seleccionEquipoClaros; // Cambiar entre equipos claros y oscuros
    notifyListeners(); // Notificar cambios al estado
  }

  void asignarEquiposAleatorios() {
    equipoClaros.clear();
    equipoOscuros.clear();

    List<JugadorPs> availablePlayers = List.from(jugadores);

    Random random = Random();

    // Seleccionar 7 jugadores aleatorios para el equipo claro
    for (int i = 0; i < 7 && availablePlayers.isNotEmpty; i++) {
      int index = random.nextInt(availablePlayers.length);
      JugadorPs selectedPlayer = availablePlayers.removeAt(index);
      selectedPlayer.seleccionado = true;
      equipoClaros.add(selectedPlayer);
    }

    // Seleccionar 7 jugadores aleatorios para el equipo oscuro
    if (availablePlayers.length >= 7) {
      for (int i = 0; i < 7 && availablePlayers.isNotEmpty; i++) {
        int index = random.nextInt(availablePlayers.length);
        JugadorPs selectedPlayer = availablePlayers.removeAt(index);
        selectedPlayer.seleccionado = true;
        equipoOscuros.add(selectedPlayer);
      }
    } else {
      print('Error: No hay suficientes jugadores para formar el equipo oscuro.');
    }

    seleccionFinalizada = equipoClaros.length == 7 && equipoOscuros.length == 7;
    notifyListeners(); // Notificar cambios al estado
  }

  void borrarDatos() {
    for (var jugador in equipoClaros) {
      jugador.seleccionado = false;
    }
    for (var jugador in equipoOscuros) {
      jugador.seleccionado = false;
    }
    equipoClaros.clear();
    equipoOscuros.clear();
    seleccionEquipoClaros = true;
    seleccionFinalizada = false;
    notifyListeners(); // Notificar cambios al estado
  }
}