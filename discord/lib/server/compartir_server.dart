import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CompartirServer extends StatelessWidget {
  final String serverLink;

  CompartirServer({required this.serverLink, required String serverId});

  Future<void> _compartirWhatsApp() async {
    String mensaje = '¡Únete a nuestro servidor en Discord! $serverLink';
    Uri url = Uri.parse('https://wa.me/?text=${Uri.encodeFull(mensaje)}');

    if (!await launchUrl(url)) {
      throw 'No se pudo lanzar WhatsApp.';
    }
  }

  Future<void> _compartirMessenger() async {
    Uri url = Uri.parse(
        'fb-messenger://share/?link=${Uri.encodeComponent(serverLink)}');

    if (!await launchUrl(url)) {
      throw 'No se pudo lanzar Messenger.';
    }
  }

  Future<void> _compartirTwitter() async {
    Uri url = Uri.parse(
        'https://twitter.com/intent/tweet?text=${Uri.encodeFull("¡Únete a nuestro servidor en Discord! $serverLink")}');

    if (!await launchUrl(url)) {
      throw 'No se pudo lanzar Twitter.';
    }
  }

  Future<void> _compartirCorreo() async {
    Uri url = Uri.parse(
        'mailto:?subject=Únete a nuestro servidor en Discord&body=${Uri.encodeFull(serverLink)}');

    if (!await launchUrl(url)) {
      throw 'No se pudo lanzar Correo.';
    }
  }

  Future<void> _compartirMensaje() async {
    Uri url = Uri.parse(
        'sms:?body=${Uri.encodeFull("¡Únete a nuestro servidor en Discord! $serverLink")}');

    if (!await launchUrl(url)) {
      throw 'No se pudo lanzar Mensaje.';
    }
  }

  Future<void> _copiarEnlace(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: serverLink));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Enlace copiado al portapapeles')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF36393E),
        title: Center(child: Text('Invitar Amigos')),
        automaticallyImplyLeading: false, // Elimina la flecha de retroceso
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.whatsapp,
                      size: 30, color: Colors.green),
                  onPressed: _compartirWhatsApp,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.facebookMessenger,
                      size: 30, color: Colors.blue),
                  onPressed: _compartirMessenger,
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter,
                      size: 30, color: Colors.lightBlue),
                  onPressed: _compartirTwitter,
                ),
                IconButton(
                  icon: Icon(Icons.email, size: 30, color: Colors.red),
                  onPressed: _compartirCorreo,
                ),
                IconButton(
                  icon: Icon(Icons.message, size: 30, color: Colors.orange),
                  onPressed: _compartirMensaje,
                ),
                IconButton(
                  icon: Icon(Icons.link, size: 30, color: Colors.grey),
                  onPressed: () => _copiarEnlace(context),
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar amigos',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Color(0xFF2F3136),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                hintStyle: TextStyle(color: Colors.white54),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Card(
                color: Color(0xFF36393E),
                elevation: 5,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/amigo${index + 1}.png'),
                          ),
                          title: Text('Amigo ${index + 1}',
                              style: TextStyle(color: Colors.white)),
                          trailing: ElevatedButton(
                            onPressed: () {
                              // Lógica para invitar amigo
                            },
                            child: Text('Invitar'),
                          ),
                        ),
                        Divider(color: Colors.white),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF36393E),
    );
  }
}
