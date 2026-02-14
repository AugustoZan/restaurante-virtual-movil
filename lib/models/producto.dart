class Producto {
  final String nombre;
  final double precio;
  final String imagen;
  final String descripcion;

  Producto({
    required this.nombre,
    required this.precio,
    required this.imagen,
    required this.descripcion,
  });

  // Método para verificar si es una hamburguesa (para la oferta)
  bool get isHamburguesa => nombre.toLowerCase().contains('hamburguesa');
}