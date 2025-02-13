// screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:demo_app_futbol7_v2/models/Jugador.dart';
import 'package:demo_app_futbol7_v2/models/EquipoManager.dart';
import 'package:demo_app_futbol7_v2/widgets/EquipoWidget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late EquipoManager equipoManager;

  // Lista de nombres de jugadores
  final List<String> nombresJugadores = [
    'Antonio',
    'Álvaro B',
    'Gon',
    'Gutito',
    'Rober',
    'Álvaro R',
    'Álvaro C',
    'Joaquín',
    'Victor',
    'Miguel',
    'Nacho',
    'Caro',
    'Morán',
    'Pablo',
    'Alex',
    'Adam',
    'Alberto',
    'Iker',
    'Emmanuel',
    'Fer',
    'Pablo Silvage',
    'Tri',
  ];

  @override
  void initState() {
    super.initState();
    // Inicializamos el EquipoManager con la lista de jugadores
    equipoManager = EquipoManager(
      jugadores: nombresJugadores.map((nombre) => Jugador(nombre: nombre)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fútbol 7 App'),
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0, // Sin sombra
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/campo_futbol_pizarra_girado.jpg'), // Fondo de pantalla
            fit: BoxFit.cover, // Ajusta la imagen al tamaño de la pantalla
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Título de la pantalla
                const Text(
                  'Selecciona los jugadores',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texto blanco para contrastar con el fondo
                  ),
                ),
                const SizedBox(height: 16),

                // Lista de jugadores seleccionables
                ...equipoManager.jugadores.map((jugador) {
                  return ListTile(
                    title: Text(
                      jugador.nombre,
                      style: TextStyle(
                        color: jugador.seleccionado ? Colors.blue : Colors.white,
                      ),
                    ),
                    trailing: jugador.seleccionado
                        ? const Icon(Icons.check_circle, color: Colors.blue)
                        : null,
                    onTap: () {
                      setState(() {
                        equipoManager.seleccionarJugador(jugador); // Manejar selección de jugadores
                      });
                    },
                  );
                }).toList(),

                const SizedBox(height: 16),

                // Botón para cambiar entre equipos claros y oscuros
                if (!equipoManager.seleccionFinalizada)
                  ElevatedButton.icon(
                    onPressed: equipoManager.jugadoresSeleccionados.length == 7
                        ? () {
                            setState(() {
                              equipoManager.cambiarEquipo(); // Cambiar equipo
                            });
                          }
                        : null,
                    icon: Icon(equipoManager.seleccionEquipoClaros
                        ? Icons.lightbulb_outline
                        : Icons.nights_stay_outlined),
                    label: Text(equipoManager.seleccionEquipoClaros ? 'Equipo Claros' : 'Equipo Oscuros'),
                  ),

                const SizedBox(height: 16),

                // Botón para generar equipos aleatorios
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      equipoManager.asignarEquiposAleatorios(); // Generar equipos aleatorios
                    });
                  },
                  icon: const Icon(Icons.shuffle),
                  label: const Text('Equipos Aleatorios'),
                ),

                const SizedBox(height: 16),

                // Botón para borrar datos cuando ambos equipos estén completos
                if (equipoManager.seleccionFinalizada)
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        equipoManager.borrarDatos(); // Reiniciar selección
                      });
                    },
                    icon: const Icon(Icons.delete),
                    label: const Text('Borrar Datos'),
                  ),

                const SizedBox(height: 16),

                // Mostrar equipos completados
                if (equipoManager.seleccionFinalizada)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Equipos Completados:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: EquipoWidget(
                              equipo: equipoManager.equipoClaros,
                              color: Colors.lightBlue,
                              title: 'Equipo Claros',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: EquipoWidget(
                              equipo: equipoManager.equipoOscuros,
                              color: Colors.grey,
                              title: 'Equipo Oscuros',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: equipoManager.seleccionFinalizada
                            ? () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Equipos guardados')),
                                );
                              }
                            : null,
                        child: const Text('Enviar/Guardar'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}