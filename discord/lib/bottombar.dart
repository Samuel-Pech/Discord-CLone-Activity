import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final Function(String) navigateTo;

  BottomBar({required this.navigateTo});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Colors.grey[850],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            onPressed: () => navigateTo('/'),
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () => navigateTo('/notificaciones'),
          ),
          IconButton(
            icon: Icon(Icons.qr_code_scanner),
            onPressed: () => navigateTo('/scanner'),
          ),
          GestureDetector(
            onTap: () => navigateTo('/perfil'),
            child: ClipOval(
              child: Image.asset(
                'assets/images/logo.png',
                height: 24,
                width: 24,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
