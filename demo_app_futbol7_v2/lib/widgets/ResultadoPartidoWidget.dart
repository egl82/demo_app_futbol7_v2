import 'package:flutter/material.dart';

class ResultadoPartidoWidget extends StatefulWidget {
  final Function(String, String) onResultadoChanged;

  const ResultadoPartidoWidget({
    Key? key,
    required this.onResultadoChanged,
  }) : super(key: key);

  @override
  _ResultadoPartidoWidgetState createState() => _ResultadoPartidoWidgetState();
}

class _ResultadoPartidoWidgetState extends State<ResultadoPartidoWidget> {
  TextEditingController equipoClaroController = TextEditingController();
  TextEditingController equipoOscuroController = TextEditingController();

  @override
  void dispose() {
    // Liberar los controladores de texto
    equipoClaroController.dispose();
    equipoOscuroController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Título del Card
            const Text(
              "Introduce el resultado del partido",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // CONTENIDO PRINCIPAL DEL CARD
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // CAMPO PARA EL EQUIPO CLAROS
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.sports_soccer, size: 30, color: Colors.blue),
                      const SizedBox(height: 4),
                      const Text(
                        "Claros",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: equipoClaroController,
                          keyboardType: TextInputType.number, // Solo números
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "0", // Placeholder inicial
                          ),
                          onChanged: (value) {
                            // Validar que solo se ingresen números
                            if (int.tryParse(value) != null || value.isEmpty) {
                              widget.onResultadoChanged(equipoClaroController.text, equipoOscuroController.text);
                            } else {
                              // Si se ingresa un valor no numérico, limpiar el campo
                              equipoClaroController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                // SEPARADOR CON GUION
                const Text(
                  "-",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),

                // CAMPO PARA EL EQUIPO OSCUROS
                Expanded(
                  child: Column(
                    children: [
                      Icon(Icons.sports_soccer, size: 30, color: Colors.grey),
                      const SizedBox(height: 4),
                      const Text(
                        "Oscuros",
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 50,
                        child: TextField(
                          controller: equipoOscuroController,
                          keyboardType: TextInputType.number, // Solo números
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "0", // Placeholder inicial
                          ),
                          onChanged: (value) {
                            // Validar que solo se ingresen números
                            if (int.tryParse(value) != null || value.isEmpty) {
                              widget.onResultadoChanged(equipoClaroController.text, equipoOscuroController.text);
                            } else {
                              // Si se ingresa un valor no numérico, limpiar el campo
                              equipoOscuroController.clear();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}