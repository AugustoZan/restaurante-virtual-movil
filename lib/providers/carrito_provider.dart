import 'package:flutter/material.dart';
import '../models/producto.dart';

class CarritoProvider with ChangeNotifier {
  final List<Producto> _carrito = [];

  List<Producto> get carrito => _carrito;

  void addProducto(Producto producto) {
    _carrito.add(producto);
    notifyListeners();
  }

  void removeProducto(int index) {
    _carrito.removeAt(index);
    notifyListeners();
  }

  void vaciarCarrito() {
    _carrito.clear();
    notifyListeners();
  }

  double get totalBase => _carrito.fold(0.0, (sum, p) => sum + p.precio);

  // Lógica de la oferta: Si total base > 15 y hay al menos una hamburguesa, hacer gratis la hamburguesa más barata
  double getTotalConDescuento() {
    double total = totalBase;
    if (total > 15.0 && _carrito.any((p) => p.isHamburguesa)) {
      // Encuentra la hamburguesa más barata y descuenta su precio
      Producto hamburguesaMasBarata = _carrito
          .where((p) => p.isHamburguesa)
          .reduce((a, b) => a.precio < b.precio ? a : b);
      total -= hamburguesaMasBarata.precio;
    }
    return total;
  }
}