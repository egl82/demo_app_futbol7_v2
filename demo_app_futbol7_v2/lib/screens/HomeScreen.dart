import 'package:demo_app_futbol7_v2/screens/JugadorSelectionScreen.dart';
import 'package:demo_app_futbol7_v2/widgets/ClasificacionCard.dart';
import 'package:demo_app_futbol7_v2/widgets/ResultadoPartidoWidget.dart';
import 'package:flutter/material.dart';
import 'package:demo_app_futbol7_v2/models/JugadorPs.dart';
import 'package:demo_app_futbol7_v2/models/EquipoManager.dart';
import 'package:demo_app_futbol7_v2/widgets/QuinielaCard.dart'; // Importamos el nuevo widget
import 'package:demo_app_futbol7_v2/models/Usuario.dart';

class HomeScreen extends StatefulWidget {

 final String nombreUsuario;


  const HomeScreen({
    Key? key,
    required this.nombreUsuario,
  }) : super(key: key);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late EquipoManager equipoManager;

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
    'Facu',
  ];

    // Lista de usuarios con puntos iniciales
  final List<Usuario> usuarios = [
    Usuario(id: "1", nombre: "Alex", puntos: 50),
    Usuario(id: "2", nombre: "Antonio", puntos: 30),
    Usuario(id: "3", nombre: "Emmanuel", puntos: 70),
    Usuario(id: "4", nombre: "Joaquín", puntos: 40),
    Usuario(id: "5", nombre: "Iker", puntos: 25),
    Usuario(id: "5", nombre: "Rober", puntos: 85.5),
  ];


  // Variable para almacenar la selección quinielística
  String? seleccionQuiniela; // Puede ser "1", "X" o "2"
  
  // Variables para almacenar el resultado del partido
  String golesEquipoClaro = "";
  String golesEquipoOscuro = "";

  @override
  void initState() {
    super.initState();
    equipoManager = EquipoManager(
      jugadores:
          nombresJugadores.map((nombre) => JugadorPs(nombre: nombre)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fútbol 7 App - ${widget.nombreUsuario}',style: TextStyle(fontWeight: FontWeight.bold,)),
        backgroundColor: Colors.green, // AppBar transparente
        elevation: 0, // Sin sombra
      ),
      body: Container(
        color: Colors.grey[300], // Fondo de pantalla en gris claro
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Título de la pantalla
                  const Text(
                    'Selecciona los jugadores',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Botón para seleccionar equipo claro
                  if (!equipoManager.seleccionFinalizada)
                    ElevatedButton.icon(
                      onPressed: equipoManager.equipoClaros.isEmpty
                          ? () =>
                              _selectEquipo(context, equipoManager.equipoClaros)
                          : null,
                      icon: const Icon(Icons.lightbulb_outline),
                      label: const Text('Seleccionar Equipo Claros'),
                    ),

                  // Mostrar equipo claro seleccionado
                  if (equipoManager.equipoClaros.isNotEmpty)
                    buildSelectedJugadoresList(
                        equipoManager.equipoClaros, "EQUIPO Claros"),

                  const SizedBox(height: 16),

                  // Botón para seleccionar equipo oscuro
                  if (!equipoManager.seleccionFinalizada &&
                      equipoManager.equipoClaros.isNotEmpty)
                    ElevatedButton.icon(
                      onPressed: equipoManager.equipoOscuros.isEmpty
                          ? () => _selectEquipo(
                              context, equipoManager.equipoOscuros)
                          : null,
                      icon: const Icon(Icons.nights_stay_outlined),
                      label: const Text('Seleccionar Equipo Oscuros'),
                    ),

                  // Mostrar equipo oscuro seleccionado
                  if (equipoManager.equipoOscuros.isNotEmpty)
                    buildSelectedJugadoresList(
                        equipoManager.equipoOscuros, "EQUIPO Oscuros"),

                  const SizedBox(height: 16),

                  // Botón para generar equipos aleatorios
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        equipoManager.asignarEquiposAleatorios();
                      });
                    },
                    icon: const Icon(Icons.shuffle),
                    label: const Text('Equipos Aleatorios'),
                  ),

                  const SizedBox(height: 16),

                  // BOTÓN PARA BORRAR DATOS
                  if (equipoManager.seleccionFinalizada)
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          equipoManager.borrarDatos();
                          seleccionQuiniela =
                              null; // Reiniciar selección quinielística
                        });
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Borrar Datos'),
                    ),

                  const SizedBox(height: 16),

                  // CARD DE SELECCIÓN QUINIELÍSTICA
               // CARD QUINIELÍSTICO (USANDO EL NUEVO WIDGET)
                  const QuinielaCard(), // Usamos el widget separado aquí

                  const SizedBox(height: 16),

                  // WIDGET PARA INTRODUCIR RESULTADO DEL PARTIDO
                  ResultadoPartidoWidget(
                    onResultadoChanged: (claros, oscuros) {
                      setState(() {
                        golesEquipoClaro = claros;
                        golesEquipoOscuro = oscuros;
                      });
                    },
                  ),

                  // BOTÓN PARA ENVIAR/GUARDAR
                  ElevatedButton(
                    onPressed: equipoManager.seleccionFinalizada
                        ? () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Equipos guardados')),
                            );
                          }
                        : null,
                    child: const Text('Enviar/Guardar'),
                  ),
                  const SizedBox(height: 16),

                  // CLASIFICACIÓN DE USUARIOS
                  ClasificacionCard(usuarios: usuarios), // Añadimos el nuevo widget aquí
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Función para seleccionar un equipo mediante BottomSheet
  Future<void> _selectEquipo(
      BuildContext context, List<JugadorPs> equipoActual) async {
    // Filtrar jugadores disponibles excluyendo los ya seleccionados en cualquier equipo
    final jugadoresDisponibles = equipoManager.jugadores.where((jugador) {
      return !equipoManager.equipoClaros.contains(jugador) &&
          !equipoManager.equipoOscuros.contains(jugador);
    }).toList();

    // Abrir la pantalla de selección de jugadores
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JugadorSelectionScreen(
          jugadoresDisponibles: jugadoresDisponibles,
        ),
        fullscreenDialog: true,
      ),
    );

    // Verificar si se seleccionaron jugadores válidos
    if (result is List<JugadorPs> && result.length == 7) {
      setState(() {
        if (equipoActual == equipoManager.equipoClaros) {
          equipoManager.equipoClaros = result;
        } else if (equipoActual == equipoManager.equipoOscuros) {
          equipoManager.equipoOscuros = result;
        }

        // Verificar si ambos equipos están completos
        if (equipoManager.equipoClaros.isNotEmpty &&
            equipoManager.equipoOscuros.isNotEmpty) {
          equipoManager.seleccionFinalizada = true;
        }
      });
    }
  }

  /// Widget para mostrar jugadores seleccionados en Cards
  Widget buildSelectedJugadoresList(
      List<JugadorPs> jugadores, String equipoNombre) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$equipoNombre:",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.black),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: jugadores.map((jugador) {
            return Card(
              elevation: 4,
              color: Colors.white,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(
                      jugador.nombre,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Widget para el Card Quinielístico

/* Widget _buildQuinielaCard() {
  return Card(
    
    elevation: 4,
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(8.0), // Reducimos el padding para ahorrar espacio
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // LOGO Y NOMBRE DEL EQUIPO CLAROS
          Expanded(
            child: Column(
              children: [
                Icon(Icons.sports_soccer, size: 30, color: Colors.blue), // Reducimos el tamaño del logo
                const SizedBox(height: 4), // Espacio reducido
                const Text(
                  "Claros",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black), // Reducimos el tamaño del texto
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // CONTENEDOR PARA LOS RADIO BUTTONS
          Column(
            children: [
              // Fila para los números (1, X, 2) encima de los Radio Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("1", style: TextStyle(fontSize: 12, color: Colors.green)), // Número 1
                  const SizedBox(width: 16), // Espacio entre elementos
                  const Text("X", style: TextStyle(fontSize: 12, color: Colors.orange)), // Número X
                  const SizedBox(width: 16), // Espacio entre elementos
                  const Text("2", style: TextStyle(fontSize: 12, color: Colors.red)), // Número 2
                ],
              ),

              const SizedBox(height: 4), // Separación entre números y Radio Buttons

              // Fila para los Radio Buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: "1",
                    groupValue: seleccionQuiniela, // Valor seleccionado actualmente
                    onChanged: (value) {
                      setState(() {
                        seleccionQuiniela = value; // Actualizar selección
                      });
                    },
                    activeColor: Colors.green, // Color cuando está seleccionado
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reducir el tamaño del target
                  ),
                  const SizedBox(width: 16), // Espacio entre elementos

                  Radio<String>(
                    value: "X",
                    groupValue: seleccionQuiniela, // Valor seleccionado actualmente
                    onChanged: (value) {
                      setState(() {
                        seleccionQuiniela = value; // Actualizar selección
                      });
                    },
                    activeColor: Colors.orange, // Color cuando está seleccionado
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reducir el tamaño del target
                  ),
                  const SizedBox(width: 16), // Espacio entre elementos

                  Radio<String>(
                    value: "2",
                    groupValue: seleccionQuiniela, // Valor seleccionado actualmente
                    onChanged: (value) {
                      setState(() {
                        seleccionQuiniela = value; // Actualizar selección
                      });
                    },
                    activeColor: Colors.red, // Color cuando está seleccionado
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reducir el tamaño del target
                  ),
                ],
              ),
            ],
          ),

          // LOGO Y NOMBRE DEL EQUIPO OSCUROS
          Expanded(
            child: Column(
              children: [
                Icon(Icons.sports_soccer, size: 30, color: Colors.grey), // Reducimos el tamaño del logo
                const SizedBox(height: 4), // Espacio reducido
                const Text(
                  "Oscuros",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black), // Reducimos el tamaño del texto
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
} */
}
