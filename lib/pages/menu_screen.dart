import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../providers/carrito_provider.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {

  void agregarAlCarrito(BuildContext context, Producto producto) {
    Provider.of<CarritoProvider>(context, listen: false).addProducto(producto);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${producto.nombre} agregado al carrito')),
    );
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
              // Muestra un diálogo simple con el carrito usando el provider
              showDialog(
                context: context,
                builder: (context) {
                  final carrito = Provider.of<CarritoProvider>(context).carrito;
                  final total = Provider.of<CarritoProvider>(context).getTotalConDescuento();
                  return AlertDialog(
                    title: const Text('Carrito'),
                    content: carrito.isEmpty
                        ? const Text('El carrito está vacío')
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ...carrito.map((p) => Text('${p.nombre}: \$${p.precio.toStringAsFixed(2)}')),
                              const SizedBox(height: 10),
                              Text('Total: \$${total.toStringAsFixed(2)}'),
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
                Navigator.pushNamed(context, '/contactos');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Nuestro Menú',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  // Hamburguesas
                  const Text(
                    'Hamburguesas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Hamburguesa',
                          precio: 3.49,
                          imagen: 'assets/burger.jpg',
                          descripcion: 'Hamburguesa con carne, lechuga tomate y queso.',
                        ),
                      ),
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Hamburguesa Clásica',
                          precio: 4.49,
                          imagen: 'assets/burger2.jpg',
                          descripcion: 'Carne jugosa, lechuga, tomate, bacon y cebolla en pan suave.',
                        ),
                      ),
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Hamburguesa Vegetariana',
                          precio: 3.99,
                          imagen: 'assets/burger3.jpg',
                          descripcion: 'Patty de verduras, lechuga, tomate y cebolla en pan suave.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Bebidas
                  const Text(
                    'Bebidas',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Refresco Cola',
                          precio: 1.99,
                          imagen: 'assets/cola.jpg',
                          descripcion: 'Refresco carbonatado refrescante, 500ml.',
                        ),
                      ),
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Jugo de Naranja',
                          precio: 2.49,
                          imagen: 'assets/orange.jpg',
                          descripcion: 'Jugo natural exprimido, 500ml.',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Postres
                  const Text(
                    'Postres',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Helado de Vainilla',
                          precio: 3.49,
                          imagen: 'assets/dessert.jpg',
                          descripcion: 'Copa de helado cremoso.',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Color(0xFFf2ebe5),
              width: double.infinity,
              child: const Text(
                '© 2026 Restaurante Virtual',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProducto(BuildContext context, Producto producto) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(producto.imagen, width: 120, height: 120, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(
              producto.nombre,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              producto.descripcion,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '\$${producto.precio.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => agregarAlCarrito(context, producto),
              child: const Text('Agregar al Carrito'),
            ),
          ],
        ),
      ),
    );
  }
}