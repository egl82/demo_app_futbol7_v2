import 'package:flutter/material.dart';

class QuinielaCard extends StatefulWidget {
  final String? seleccionInicial; // Valor inicial de la selección (opcional)

  const QuinielaCard({
    Key? key,
    this.seleccionInicial,
  }) : super(key: key);

  @override
  _QuinielaCardState createState() => _QuinielaCardState();
}

class _QuinielaCardState extends State<QuinielaCard> {
  String? seleccionQuiniela; // Variable para almacenar la selección actual

  @override
  void initState() {
    super.initState();
    // Inicializamos la selección con el valor proporcionado (si existe)
    seleccionQuiniela = widget.seleccionInicial;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // LOGO Y NOMBRE DEL EQUIPO CLAROS
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
                    const Text("1", style: TextStyle(fontSize: 12, color: Colors.green)),
                    const SizedBox(width: 16),
                    const Text("X", style: TextStyle(fontSize: 12, color: Colors.orange)),
                    const SizedBox(width: 16),
                    const Text("2", style: TextStyle(fontSize: 12, color: Colors.red)),
                  ],
                ),

                const SizedBox(height: 4),

                // Fila para los Radio Buttons
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<String>(
                      value: "1",
                      groupValue: seleccionQuiniela,
                      onChanged: (value) {
                        setState(() {
                          seleccionQuiniela = value; // Actualizar selección
                        });
                      },
                      activeColor: Colors.green,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const SizedBox(width: 16),

                    Radio<String>(
                      value: "X",
                      groupValue: seleccionQuiniela,
                      onChanged: (value) {
                        setState(() {
                          seleccionQuiniela = value; // Actualizar selección
                        });
                      },
                      activeColor: Colors.orange,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    const SizedBox(width: 16),

                    Radio<String>(
                      value: "2",
                      groupValue: seleccionQuiniela,
                      onChanged: (value) {
                        setState(() {
                          seleccionQuiniela = value; // Actualizar selección
                        });
                      },
                      activeColor: Colors.red,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ],
                ),
              ],
            ),

            // LOGO Y NOMBRE DEL EQUIPO OSCUROS
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}