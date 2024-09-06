import 'package:discord/login/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase.dart';
import 'login/register.dart';
import 'opciones.dart';
import 'home.dart';
import 'pages/mensajes.dart';
import 'pages/notificaciones.dart';
import 'pages/perfil.dart';
import 'scanner.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF36393e),
        scaffoldBackgroundColor: const Color(0xFF36393e),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1C1C1C),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey[700]!;
                }
                return const Color(0xFF50555b);
              },
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[800],
          hintStyle: TextStyle(color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/mensajes': (context) => MensajesScreen(),
        '/notificaciones': (context) => NotificacionesScreen(),
        '/perfil': (context) => PerfilScreen(),
        '/scanner': (context) => ScannerScreen(),
        '/login': (context) => LoginScreen(), // Añade la ruta de login
        '/register': (context) => RegisterScreen(), // Añade la ruta de registro
      },
    );
  }
}
