import 'package:discord/server/server.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RemoveScrollGlowBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class CreateServer extends StatefulWidget {
  const CreateServer({Key? key}) : super(key: key);

  @override
  State<CreateServer> createState() => _CreateServerState();
}

class _CreateServerState extends State<CreateServer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF36393e),
      appBar: AppBar(
        backgroundColor: const Color(0xFF35383d),
        toolbarHeight: 72,
        leadingWidth: 36,
        leading: Padding(
          padding: const EdgeInsets.only(left: 12),
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF35383d),
          ),
          child: Column(
            children: [
              Center(
                child: Text(
                  '¿Ya tienes una invitación?',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Theme(
                data: ThemeData(
                  highlightColor: Colors.transparent,
                  splashColor: const Color.fromARGB(255, 94, 98, 102),
                  splashFactory: InkRipple.splashFactory,
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: RawMaterialButton(
                    elevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (_) => Server()));
                    },
                    fillColor: const Color(0xFF50555b),
                    child: Text(
                      "Unirse a un servidor",
                      style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ScrollConfiguration(
          behavior: RemoveScrollGlowBehavior(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 132),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    "Crea tu servidor",
                    style: GoogleFonts.openSans(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    "Tu servidor es donde tú y tus amigos se reúnen.",
                    style: GoogleFonts.openSans(
                        color: const Color(0xFFb9bbbf), fontSize: 14),
                  ),
                ),
                Center(
                  child: Text(
                    "Haz el tuyo y empieza a hablar.",
                    style: GoogleFonts.openSans(
                        color: const Color(0xFFb9bbbf), fontSize: 14),
                  ),
                ),
                const SizedBox(height: 24),
                Theme(
                  data: ThemeData(
                    highlightColor: Colors.transparent,
                    splashColor: const Color.fromARGB(255, 69, 71, 76),
                    splashFactory: InkRipple.splashFactory,
                  ),
                  child: ListTileTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    tileColor: const Color(0xFF2a2b2f),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (_) => Server())),
                          title: Text("Crear el mío",
                              style: TextStyle(color: Colors.white)),
                          leading: CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Icon(Icons.add, color: Colors.white)),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          "EMPEZAR CON UNA PLANTILLA",
                          style: GoogleFonts.openSans(
                              color: const Color(0xFFb9bbbe), fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        buildTemplateOption(
                            "Gaming", Icons.sports_esports, Colors.green),
                        buildTemplateOption(
                            "Club escolar", Icons.school, Colors.orange),
                        buildTemplateOption(
                            "Grupo de estudio", Icons.group, Colors.purple),
                        buildTemplateOption("Amigos", Icons.people, Colors.red),
                        buildTemplateOption(
                            "Artistas y creadores", Icons.brush, Colors.teal),
                        buildTemplateOption("Comunidad local",
                            Icons.location_city, Colors.brown),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTemplateOption(String title, IconData icon, Color bgColor) {
    return ListTile(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (_) => Server())),
      title: Text(title, style: TextStyle(color: Colors.white)),
      leading: CircleAvatar(
          backgroundColor: bgColor, child: Icon(icon, color: Colors.white)),
    );
  }
}
