import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bottombar.dart';

class AmigosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 46, 50),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Amigos', style: TextStyle(color: Colors.white)),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              // Acción para "Añadir amigos"
            },
            child: Text('Añadir Amigos',
                style: TextStyle(color: Color(0xFF7289DA))),
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 43, 46, 50), // Color del perfil
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Buscar amigos',
                labelStyle: TextStyle(color: Colors.white),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.grey.shade600),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 10), // Espacio entre la barra de búsqueda y el botón
          GestureDetector(
            onTap: () {
              // Acción para revisar las solicitudes de amistad
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 16),
              color: Color.fromARGB(255, 53, 56, 60), // Color del card
              child: ListTile(
                leading: Icon(Icons.people_alt, color: Colors.white),
                title: Text(
                  'Revisar solicitudes de amistad',
                  style: TextStyle(color: Colors.white),
                ),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                // Friend cards
                FriendSection(letter: 'A', friends: [
                  Friend(
                      name: 'Amigo 1', imageUrl: 'assets/images/minecraft.png'),
                ]),
                FriendSection(letter: 'B', friends: [
                  Friend(
                      name: 'Amigo 2', imageUrl: 'assets/images/valorant.png'),
                ]),
                FriendSection(letter: 'C', friends: [
                  Friend(name: 'Amigo 3', imageUrl: 'assets/images/chems.png'),
                ]),
                FriendSection(letter: 'D', friends: [
                  Friend(
                      name: 'Amigo 4', imageUrl: 'assets/images/minecraft.png'),
                ]),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(
        navigateTo: (routeName) {
          Navigator.pushReplacementNamed(context, routeName);
        },
      ),
    );
  }
}

class FriendSection extends StatelessWidget {
  final String letter;
  final List<Friend> friends;

  FriendSection({required this.letter, required this.friends});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            letter,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children:
              friends.map((friend) => FriendCard(friend: friend)).toList(),
        ),
      ],
    );
  }
}

class FriendCard extends StatelessWidget {
  final Friend friend;

  FriendCard({required this.friend});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      color: Color.fromARGB(255, 53, 56, 60), // Color del card
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(friend.imageUrl),
        ),
        title: Text(friend.name, style: TextStyle(color: Colors.white)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.call, color: Colors.white), // Icono de llamada
              onPressed: () {
                // Implementar acción de llamada
              },
            ),
            IconButton(
              icon: FaIcon(FontAwesomeIcons.solidCommentDots,
                  color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class Friend {
  final String name;
  final String imageUrl;

  Friend({required this.name, required this.imageUrl});
}
