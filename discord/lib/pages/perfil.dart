import 'package:flutter/material.dart';
import 'amigos.dart';
import 'nitro.dart';
import '../bottombar.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 43, 46, 50),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Banner(),
                Positioned(
                  top: 130,
                  left: 20,
                  child: UserAvatar(),
                ),
              ],
            ),
            SizedBox(height: 70),
            UserCard(),
            SizedBox(height: 20),
            MemberSinceCard(),
            FriendsRow(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        navigateTo: (routeName) {
          Navigator.pushReplacementNamed(context, routeName);
        },
      ),
    );
  }
}

class Banner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 23, 23),
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, top: 70.0, bottom: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NitroScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFF23272A), // Match card color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text('Nitro', style: TextStyle(color: Colors.white)),
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.settings, color: Colors.white),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color.fromARGB(255, 43, 46, 50),
          width: 4.0,
        ),
      ),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/logo.png'),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF23272A),
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserDetails(),
            SizedBox(height: 20),
            ActionButtons(),
          ],
        ),
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'BY-Z0ND3RX',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'by-z0nd3rx',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }
}

class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // Center the buttons
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 12, 60, 233),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text('Añadir Estado'),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 12, 60, 233),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: Text('Editar Perfil'),
        ),
      ],
    );
  }
}

class MemberSinceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF23272A),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.calendar_today, color: Colors.white),
        title: Text(
          'Miembro de Discord desde',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          '01 de Enero de 2020',
          style: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}

class FriendsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF23272A),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tus Amigos:',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Row(
              children: [
                FriendTile(imageUrl: 'assets/images/minecraft.png'),
                SizedBox(width: 5),
                FriendTile(imageUrl: 'assets/images/valorant.png'),
                SizedBox(width: 5),
                FriendTile(imageUrl: 'assets/images/chems.png'),
                SizedBox(width: 5),
                IconButton(
                  icon: Icon(Icons.chevron_right, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AmigosScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class FriendTile extends StatelessWidget {
  final String imageUrl;

  FriendTile({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 16, // Reduced size
      backgroundImage: AssetImage(imageUrl),
    );
  }
}
