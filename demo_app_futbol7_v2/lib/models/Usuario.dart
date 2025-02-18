class Usuario {
  final String id;
  final String nombre;
  double puntos;

  Usuario({
    required this.id,
    required this.nombre,
    this.puntos = 0, // Puntos iniciales en 0
  });

  /// Método para incrementar los puntos
  void incrementarPuntos(int cantidad) {
    puntos += cantidad;
  }

  /// Método para decrementar los puntos
  void decrementarPuntos(int cantidad) {
    if (puntos >= cantidad) {
      puntos -= cantidad;
    }
  }
}