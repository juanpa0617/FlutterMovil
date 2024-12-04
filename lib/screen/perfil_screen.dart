import 'package:bookedge/screen/sign_in.dart';
import 'package:flutter/material.dart';
import '../widget/profile/data_widget.dart';
import '../layout/menu_widget.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});
  static const routerName = '/perfil';

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  @override
  Widget build(BuildContext context) {
    double horizontal = 20;
    double vertical = 10;
    double radio = 8.0;
    double iconSize = 180;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: horizontal,
                vertical: vertical,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: Icon(
                Icons.person,
                size: iconSize,
                color: Colors.white,
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DataWidget(hintText: "Nombre", dataText: "Juan Pérez"),
                DataWidget(hintText: "Correo", dataText: "juan.perez@example.com"),
                DataWidget(hintText: "Teléfono", dataText: "+54 300 123 4567"),
                DataWidget(hintText: "Dirección", dataText: "Calle Falsa 123"),
                DataWidget(hintText: "Ocupación", dataText: "Desarrollador"),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 255, 0, 25),
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: horizontal,
                  vertical: vertical,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radio),
                ),
              ),
              onPressed: () {
                // Redirige al LoginScreen
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: const Text("Cerrar Sesión"),
            )
          ],
        ),
      ),
      bottomNavigationBar: const MenuWidget(
        currentIndex: 2,
      ),
    );
  }
}
