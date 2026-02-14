import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/producto.dart';
import '../providers/carrito_provider.dart';

class OfertasScreen extends StatefulWidget {
  const OfertasScreen({super.key});

  @override
  State<OfertasScreen> createState() => _OfertasScreenState();
}

class _OfertasScreenState extends State<OfertasScreen> {

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
                Navigator.of(context).pop(); // Cierra el drawer
                Navigator.pushNamed(context, '/menu'); // Navega a menú
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Ofertas'),
              onTap: () {
                Navigator.of(context).pop(); // Cierra el drawer (ya estamos en ofertas)
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_phone),
              title: const Text('Contactos'),
              onTap: () {
                Navigator.of(context).pop(); // Cierra el drawer
                Navigator.pushNamed(context, '/contactos'); // Navega a contactos
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección Ofertas
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ofertas del Día',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  GridView.count(
                    crossAxisCount: 1,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Hamburguesa Clásica',
                          precio: 5.99,
                          imagen: 'assets/burger2.jpg',
                          descripcion: 'Deliciosa hamburguesa con queso, lechuga y tomate. ¡Oferta limitada!',
                        ),
                      ),
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Combo Familiar',
                          precio: 15.99,
                          imagen: 'assets/combo.jpg',
                          descripcion: '4 hamburguesas, papas fritas y 4 bebidas para compartir. Descuento de 20% por cada hamburguesa.',
                        ),
                      ),
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Hamburguesa Vegetariana',
                          precio: 3.99,
                          imagen: 'assets/burger3.jpg',
                          descripcion: 'Opción saludable con verduras frescas y salsa especial. ¡Gratis con pedido mayor a \$15!',
                        ),
                      ),
                      _buildProducto(
                        context,
                        Producto(
                          nombre: 'Helado Artesanal',
                          precio: 3.99,
                          imagen: 'assets/dessert.jpg',
                          descripcion: 'Sabor vainilla con toppings. Complementa tu pedido por solo \$3.99.',
                        ),
                      ),
                    ],
                  ),
                ],
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