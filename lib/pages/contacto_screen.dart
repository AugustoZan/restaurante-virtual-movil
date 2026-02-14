import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../providers/carrito_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ContactosScreen extends StatefulWidget {
  const ContactosScreen({super.key});

  @override
  State<ContactosScreen> createState() => _ContactosScreenState();
}

class _ContactosScreenState extends State<ContactosScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mensajeController = TextEditingController();

  void _enviarMensaje() async {
    if (_formKey.currentState!.validate()) {
      final formspreeUrl = dotenv.env['FORMSPREE_URL']!;  // Usa la variable

      final body = {
        'name': _nombreController.text,  // Nombre del campo
        'email': _emailController.text,
        'message': _mensajeController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(formspreeUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          if (mounted) {  // Verificación para evitar usar context si el widget fue desmontado
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Mensaje enviado exitosamente. ¡Gracias por contactarnos!')),
            );
          }
          _nombreController.clear();
          _emailController.clear();
          _mensajeController.clear();
        } else {
          if (mounted) {  // Verificación aquí también
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${response.statusCode} - ${response.body}')),
            );
          }
          if (kDebugMode) {  // Solo imprime en modo debug
            print('Error detallado: ${response.statusCode} - ${response.body}');
          }
        }
      } catch (error) {
        if (mounted) {  // Verificación en el catch
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al enviar: $error')),
          );
        }
        if (kDebugMode) {  // Solo imprime en modo debug
          print('Error detallado: $error');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Restaurante Virtual',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFf2ebe5),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  final carrito = Provider.of<CarritoProvider>(context).carrito;
                  final totalBase = Provider.of<CarritoProvider>(context).totalBase;
                  final totalDescuento = Provider.of<CarritoProvider>(context).getTotalConDescuento();
                  final aplicaOferta = totalBase > 15.0 && carrito.any((p) => p.isHamburguesa);
                  return AlertDialog(
                    title: const Text('Carrito'),
                    content: carrito.isEmpty
                        ? const Text('El carrito está vacío')
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...carrito.map((p) => Text('${p.nombre}: \$${p.precio.toStringAsFixed(2)}')),
                              const SizedBox(height: 10),
                              Text('Total base: \$${totalBase.toStringAsFixed(2)}'),
                              Text('Total con descuento: \$${totalDescuento.toStringAsFixed(2)}'),
                              if (aplicaOferta)
                                const Text(
                                  '¡Hamburguesa Vegetariana gratis aplicada!',
                                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                                ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<CarritoProvider>(context, listen: false).vaciarCarrito();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Vaciar Carrito'),
                              ),
                            ],
                          ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cerrar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF694E35),
              ),
              child: Text(
                'Navegación',
                style: TextStyle(
                  color: Color(0xFFf2ebe5),
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.restaurant_menu),
              title: const Text('Menú'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/menu');
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Ofertas'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/ofertas');
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone),
              title: const Text('Contactos'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contáctanos',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '¿Tienes alguna pregunta o quieres hacer una reserva? ¡Envíanos un mensaje!',
                    ),
                    const SizedBox(height: 16),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _nombreController,
                            decoration: const InputDecoration(
                              labelText: 'Nombre',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu nombre';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Correo Electrónico',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu correo electrónico';
                              }
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                return 'Por favor ingresa un correo válido';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _mensajeController,
                            decoration: const InputDecoration(
                              labelText: 'Mensaje',
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 5,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa tu mensaje';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _enviarMensaje,
                            child: const Text('Enviar'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            color: const Color(0xFFf2ebe5),
            width: double.infinity,
            child: const Text(
              '© 2026 Restaurante Virtual',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _emailController.dispose();
    _mensajeController.dispose();
    super.dispose();
  }
}