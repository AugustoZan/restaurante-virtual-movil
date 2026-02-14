# 🍔 Restaurante Virtual Móvil

Una aplicación móvil interactiva para un restaurante virtual, desarrollada con Flutter. Ofrece una experiencia nativa en Android e iOS, con navegación intuitiva, menú dinámico, ofertas especiales y formulario de contacto con envío de email real. Proyecto de portafolio para demostrar habilidades en desarrollo móvil.

## 📋 Descripción
Este proyecto simula un restaurante online en formato móvil, con cuatro pantallas principales: **Inicio** (bienvenida y navegación), **Menú** (productos como hamburguesas, bebidas y postres con carrito funcional), **Ofertas** (descuentos y combos con cálculos dinámicos) y **Contacto** (formulario que envía emails usando una API). Es responsive para móviles, con un diseño temático en tonos marrones y verdes, y funcionalidades como gestión de carrito con Provider, animaciones simples y navegación con drawer.

Ideal para practicar Flutter y Dart, y para mostrar en un portafolio de desarrollo móvil. Versión móvil del proyecto web disponible en [https://augustozan.github.io/restaurante-virtual/](https://augustozan.github.io/restaurante-virtual/).

## ✨ Características
- **Pantalla de Inicio**: Bienvenida con navegación principal.
- **Menú interactivo**: Muestra productos con imágenes, descripciones y precios. Botones para "agregar al carrito" con notificaciones usando SnackBar.
- **Ofertas dinámicas**: Cálculo automático de precios (ej. Descuento en hamburguesa si total >15 y hay al menos una hamburguesa en el carrito).
- **Formulario de contacto**: Envía emails al restaurante y al usuario (usando http y una API externa). Incluye validación básica.
- **Carrito funcional**: Gestión de productos con Provider, incluyendo eliminación, vaciado y cálculo de total con descuento.
- **Navegación intuitiva**: Drawer lateral para cambiar entre pantallas.
- **Responsive**: Diseño adaptable a diferentes tamaños de pantalla móvil.
- **Tecnologías modernas**: Integración con Provider para estado, http para APIs y flutter_dotenv para variables de entorno.

## 🛠️ Tecnologías Usadas
- **Flutter**: Framework para el desarrollo de la app móvil multiplataforma.
- **Dart**: Lenguaje de programación principal.
- **Provider**: Para gestión del estado del carrito de compras.
- **http**: Para envío de emails y posibles llamadas a APIs.
- **flutter_dotenv**: Para manejo de variables de entorno (e.g., claves de API).
- **flutter_launcher_icons**: Para generar íconos de la app en Android e iOS.
- Otros: Cupertino Icons para íconos estilo iOS.

## 🚀 Instalación y Ejecución (Opcional, para Pruebas)
Este proyecto es principalmente para portafolio y demostración de código. Si deseas ejecutarlo localmente:

1. **Requisitos previos**:
   - Instala Flutter: Sigue las instrucciones en [flutter.dev](https://flutter.dev/docs/get-started/install).
   - Configura un emulador (Android Studio para Android, Xcode para iOS) o conecta un dispositivo físico.

2. **Clona el repositorio**:
   ```
   git clone https://github.com/AugustoZan/restaurante-virtual-movil.git
   cd restaurante-virtual-movil
   ```
3. **Instala dependencias**:
   ```
   flutter pub get
   ```
4. **Configura variables de entorno**:
  En la raíz del proyecto se aloja un archivo denominado "env.example". Ahí podrás colocar tu URL a la API que te permite enviar correos. Por ejemplo, he utilizado Formspree.
5. **Ejecuta la app**:
   ```
   flutter run
   ```
## 📂 Estructura del proyecto
   ```
  lib/
  ├── main.dart                    # Punto de entrada de la app
  ├── pages/
  │   ├── home_screen.dart         # Pantalla de inicio
  │   ├── menu_screen.dart         # Pantalla del menú con productos y carrito
  │   ├── ofertas_screen.dart      # Pantalla de ofertas con cálculos dinámicos
  │   └── contacto_screen.dart     # Pantalla de contacto con formulario
  ├── providers/
  │   └── carrito_provider.dart    # Gestión del estado del carrito (agregar, remover, descuento)
  └── models/
      └── producto.dart            # Modelo de datos para productos (nombre, precio, imagen, etc.)
   ```
## 📸 Capturas de Pantalla
![captura1](https://github.com/user-attachments/assets/6e5e0cc8-80e7-4d5c-874b-ddcfab8a2139)
![captura2](https://github.com/user-attachments/assets/df4da028-396c-4301-b345-3d833682e4cd)
![captura3](https://github.com/user-attachments/assets/5109cb86-f25d-49ca-a855-e9921a4685cd)
![captura4](https://github.com/user-attachments/assets/3df1a9fc-8890-42ae-bfde-c510f02596a5)
![captura5](https://github.com/user-attachments/assets/a578ac6c-af58-44ba-970d-71fff6823bef)

## 📄 Licencia
Este proyecto es de código abierto y está bajo ninguna licencia. Es para uso personal y educativo.

## 👨‍💻 Autor
- **Augusto Zanetta** - [GitHub](https://github.com/AugustoZan) | [LinkedIn](https://www.linkedin.com/in/augusto-zanetta)
- Proyecto creado en 2026 como parte de un portafolio de desarrollo móvil. Versión web: https://augustozan.github.io/restaurante-virtual/.


