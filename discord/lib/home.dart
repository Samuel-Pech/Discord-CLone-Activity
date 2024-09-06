import 'package:discord/login/login.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'server/compartir_server.dart';
import 'pages/chat.dart';
import 'bottombar.dart';
import 'server/nuevo_server.dart';
import 'pages/mensajes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Server> servers = [
    Server(
        'Amigos',
        'assets/images/amigos.png',
        {
          'General': ['Admin', 'Usuario', 'Invitado'],
          'Off-topic': ['Moderador', 'Miembro'],
          'Eventos': ['Organizador', 'Asistente']
        },
        150),
    Server(
        'Familia',
        'assets/images/familia.png',
        {
          'Principal': ['Padre', 'Madre', 'Hijo', 'Hija'],
          'Fotos': ['Tío', 'Tía', 'Abuelo', 'Abuela'],
          'Organización': ['Primo', 'Prima', 'Sobrino', 'Sobrina']
        },
        50),
    Server(
        'Trabajo',
        'assets/images/trabajo.png',
        {
          'Proyectos': ['Project Manager', 'Desarrollador', 'Diseñador'],
          'Reuniones': ['CEO', 'Director', 'Empleado'],
          'Noticias': ['Marketing', 'Ventas', 'Finanzas']
        },
        200),
    Server(
        'Gaming',
        'assets/images/gaming.png',
        {
          'LoL': ['Top', 'Jungla', 'Mid', 'ADC', 'Support'],
          'Minecraft': ['Builder', 'Minero', 'Cazador', 'Granjero'],
          'Among Us': ['Impostor', 'Tripulante']
        },
        300),
  ];

  String currentServer = 'Amigos';
  int currentServerIndex = 0;
  String currentChannel = 'General';
  bool isChatExpanded = false;
  bool showMessages = false;

  void sendMessage(String message) {
    print('Mensaje enviado: $message');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isChatExpanded) {
          setState(() {
            isChatExpanded = false;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(color: Color(0xFF36393F)),
              Row(
                children: [
                  Container(
                    width: isChatExpanded ? 0 : 70,
                    decoration: BoxDecoration(
                      color: Color(0xFF2F3136),
                      border: Border(
                          right:
                              BorderSide(color: Color(0xFF202225), width: 1)),
                    ),
                    child: serverList(),
                  ),
                  SizedBox(width: 3),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: isChatExpanded ? 0 : 310,
                    child: showMessages ? MensajesScreen() : serverDetails(),
                  ),
                  SizedBox(width: isChatExpanded ? 0 : 10),
                  Expanded(
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        if (details.primaryDelta! > 0 && isChatExpanded) {
                          setState(() {
                            isChatExpanded = false;
                          });
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        child: ChatArea(
                          currentChannel: currentChannel,
                          toggleChat: () {
                            setState(() {
                              isChatExpanded = !isChatExpanded;
                            });
                          },
                          isChatExpanded: isChatExpanded,
                          closeChat: () {
                            setState(() {
                              isChatExpanded = false;
                            });
                          },
                          sendMessage: sendMessage,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: isChatExpanded
            ? null
            : BottomBar(
                navigateTo: (route) =>
                    Navigator.pushReplacementNamed(context, route),
              ),
      ),
    );
  }

  Widget serverList() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: servers.length + 2,
            itemBuilder: (context, index) {
              if (index == 0) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      showMessages = true;
                      isChatExpanded = false;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    color: Color(0xFF2E2E2E),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: FaIcon(FontAwesomeIcons.solidCommentDots,
                            color: Colors.green),
                      ),
                    ),
                  ),
                );
              }
              if (index == servers.length + 1) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateServer()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        child: Icon(Icons.add, color: Colors.green),
                      ),
                    ),
                  ),
                );
              }
              int serverIndex = index - 1;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    currentServer = servers[serverIndex].name;
                    currentServerIndex = serverIndex;
                    currentChannel = servers[serverIndex].channels.keys.first;
                    isChatExpanded = false;
                    showMessages = false;
                  });
                },
                child: Container(
                  color: currentServer == servers[serverIndex].name
                      ? Color(0xFF36393F)
                      : Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[700],
                      backgroundImage:
                          AssetImage(servers[serverIndex].imagePath),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color(0xFF2E2E2E),
            child: Center(
              child: Text(
                'Cuenta',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget serverDetails() {
    return Container(
      color: Color(0xFF2F3136),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            color: Color(0xFF202225),
            child: Center(
              child: Text(
                currentServer,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '${servers[currentServerIndex].memberCount} miembros',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          searchAndInvite(),
          Expanded(
            child: ListView(
              children:
                  servers[currentServerIndex].channels.entries.map((entry) {
                String channel = entry.key;
                List<String> roles = entry.value;
                return ExpansionTile(
                  title: Text(
                    '#$channel',
                    style: TextStyle(color: Colors.white),
                  ),
                  children: roles.map((role) {
                    return ListTile(
                      title: Text(
                        role,
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchAndInvite() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar',
                hintStyle:
                    TextStyle(color: const Color.fromARGB(137, 255, 255, 255)),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[800],
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.person_add, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => FractionallySizedBox(
                  heightFactor: 0.9,
                  child: CompartirServer(
                    serverLink: '', // Asumiendo que se generará dinámicamente
                    serverId: '',
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.event, color: Colors.white),
            onPressed: () {
              // Lógica para manejar eventos
            },
          ),
        ],
      ),
    );
  }
}

class Server {
  final String name;
  final String imagePath;
  final Map<String, List<String>> channels;
  final int memberCount;

  Server(this.name, this.imagePath, this.channels, this.memberCount);
}
