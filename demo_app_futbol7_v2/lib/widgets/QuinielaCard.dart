import 'package:flutter/material.dart';
// Para trabajar con fechas

class QuinielaCard extends StatefulWidget {
  final String? seleccionInicial;

  const QuinielaCard({
    Key? key,
    this.seleccionInicial,
  }) : super(key: key);

  @override
  _QuinielaCardState createState() => _QuinielaCardState();
}

class _QuinielaCardState extends State<QuinielaCard> {
  String? seleccionQuiniela;

  @override
  void initState() {
    super.initState();
    seleccionQuiniela = widget.seleccionInicial;
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el miércoles de la semana actual
    DateTime miercoles = getWednesdayOfCurrentOrNextWeek();
    String formattedDate = "${miercoles.day.toString().padLeft(2, '0')}-${miercoles.month.toString().padLeft(2, '0')}-${miercoles.year % 100}";

    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // TÍTULO DEL CARD
            Text(
              "El partido de la jornada $formattedDate",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // CONTENIDO PRINCIPAL DEL CARD
            Row(
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
                              seleccionQuiniela = value;
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
                              seleccionQuiniela = value;
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
                              seleccionQuiniela = value;
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
          ],
        ),
      ),
    );
  }
/* 
  /// Método para obtener el miércoles de la semana actual
  DateTime getWednesdayOfCurrentWeek() {
    DateTime now = DateTime.now();
    int difference = DateTime.wednesday - now.weekday;
    if (difference < 0) {
      difference += 7;
    }
    return now.subtract(Duration(days: difference));
  } */


/// Método para obtener el miércoles de la semana actual o próxima
/// Método para obtener el miércoles de la semana actual o próxima
DateTime getWednesdayOfCurrentOrNextWeek() {
  DateTime now = DateTime.now();
  int difference = now.weekday - DateTime.thursday; // Cambiamos la referencia a jueves

  // Si estamos antes del jueves (lunes, martes, miércoles), mostramos el miércoles de esta semana
  if (difference < 0) {
    return DateTime(now.year, now.month, now.day).add(Duration(days: DateTime.wednesday - now.weekday));
  } 
  // Si estamos en jueves o después, avanzamos al miércoles de la próxima semana
  else {
    return DateTime(now.year, now.month, now.day).add(Duration(days: 7 + DateTime.wednesday - now.weekday));
  }
}
}