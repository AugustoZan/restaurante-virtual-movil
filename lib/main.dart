import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home_screen.dart';
import 'pages/menu_screen.dart';
import 'pages/ofertas_screen.dart';
import 'pages/contacto_screen.dart';
import 'providers/carrito_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';  // Ya tienes este import

void main() async {  // Agrega async aquí
  WidgetsFlutterBinding.ensureInitialized();  // Necesario para inicializar Flutter antes de cargar dotenv
  await dotenv.load(fileName: ".env");  // Carga el archivo .env (asegúrate de que esté en la raíz)
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(  // Envuelve la app con el Provider para el carrito
      create: (context) => CarritoProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Restaurante Virtual',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF694E35)),
        ),
        home: const HomeScreen(),
        routes: {
          '/menu': (context) => const MenuScreen(),
          '/ofertas': (context) => const OfertasScreen(),
          '/contactos': (context) => const ContactosScreen(),
        },
      ),
    );
  }
}