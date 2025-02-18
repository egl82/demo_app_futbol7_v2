import 'package:demo_app_futbol7_v2/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nombreController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nombreController.dispose(); // Liberar el controlador al cerrar la pantalla
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[300], // Fondo gris claro
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // TÍTULO INGENIOSO
                const Text(
                  "Bienvenido, ¡Mister Carletto!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),

                // FORMULARIO DE INICIO DE SESIÓN
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // CAMPO PARA EL NOMBRE DE USUARIO
                      TextFormField(
                        controller: _nombreController,
                        decoration: const InputDecoration(
                          labelText: "Nombre de Usuario",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Por favor, introduce tu nombre"; // Validación futura
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // BOTÓN PARA INICIAR SESIÓN
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            String nombreUsuario = _nombreController.text.trim();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(nombreUsuario: nombreUsuario),
                              ),
                            );
                          }
                        },
                        child: const Text("Iniciar Sesión"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}