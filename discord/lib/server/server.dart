import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'crear_server.dart';

class Server extends StatefulWidget {
  const Server({super.key});

  @override
  State<Server> createState() => _ServerState();
}

class _ServerState extends State<Server> {
  late TapGestureRecognizer tapGestureRecognizer;

  @override
  void initState() {
    super.initState();
    tapGestureRecognizer = TapGestureRecognizer()..onTap = () {};
  }

  @override
  void dispose() {
    tapGestureRecognizer.dispose();
    super.dispose();
  }

  void _navigateToCrearServer(BuildContext context, String serverType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CrearServer(
          serverType: serverType,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF36393e),
        appBar: AppBar(
          toolbarHeight: 72,
          backgroundColor: const Color(0xFF36393e),
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              const SizedBox(height: 4),
              Text(
                "Cuéntanos más sobre tu servidor",
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "Para ayudarte a configurar, ¿tu nuevo servidor es para unos pocos amigos o una comunidad más grande?",
                style: GoogleFonts.openSans(
                  color: const Color(0xFFb9bbbf),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Theme(
                data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: const Color.fromARGB(255, 69, 71, 76),
                  splashFactory: InkRipple.splashFactory,
                ),
                child: ListTileTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  tileColor: const Color(0xFF2a2b2f),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        onTap: () => _navigateToCrearServer(context, "amigos"),
                        title: Text(
                          "Para mí y mis amigos",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: const Icon(Icons.people, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListTile(
                        onTap: () =>
                            _navigateToCrearServer(context, "comunidad"),
                        title: Text(
                          "Para un club o comunidad",
                          style: TextStyle(color: Colors.white),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: const Icon(Icons.group, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.openSans(
                    color: const Color(0xFFb9bbbf),
                    fontSize: 14,
                  ),
                  children: [
                    const TextSpan(text: "¿No estás seguro? Puedes "),
                    TextSpan(
                      text: "omitir esta pregunta ",
                      style: GoogleFonts.openSans(
                        color: const Color(0xFF4ba8ee),
                      ),
                      recognizer: tapGestureRecognizer,
                    ),
                    const TextSpan(text: "por ahora."),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
