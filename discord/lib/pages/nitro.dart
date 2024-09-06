import 'package:flutter/material.dart';
import 'nitro_planes.dart'; // Importa el archivo de los planes de Nitro

class NitroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nitro'),
        backgroundColor: Colors.deepPurple,
      ),
      body: NitroContent(),
    );
  }
}

class NitroContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.deepPurple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Discord Nitro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Desbloquea características y ventajas exclusivas',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '¡Mejora tu experiencia en Discord con Nitro! Obtén acceso a una serie de beneficios que te permitirán disfrutar aún más de tu servidor y comunidad.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Ventajas de Discord Nitro:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BenefitItem(
                  icon: Icons.emoji_emotions,
                  title: 'Emojis Personalizados',
                  description:
                      'Desbloquea más espacios para emojis y usa emojis personalizados en todos los servidores.',
                ),
                BenefitItem(
                  icon: Icons.hd,
                  title: 'Video en Alta Calidad',
                  description:
                      'Transmite y sube en resolución de alta calidad.',
                ),
                BenefitItem(
                  icon: Icons.mood,
                  title: 'Avatares Animados',
                  description: 'Exprésate con avatares animados.',
                ),
                BenefitItem(
                  icon: Icons.favorite,
                  title: 'Insignia de Nitro',
                  description:
                      'Muestra tu apoyo a Discord con una insignia especial.',
                ),
                BenefitItem(
                  icon: Icons.star,
                  title: 'Más Emojis en el Servidor',
                  description: 'Añade hasta 250 emojis en tus servidores.',
                ),
                BenefitItem(
                  icon: Icons.hdr_strong,
                  title: 'Transmisión de Alta Calidad',
                  description: 'Transmite en 1080p a 60 fps.',
                ),
                BenefitItem(
                  icon: Icons.arrow_forward,
                  title: 'Aumento de Servidor',
                  description:
                      'Ayuda a mejorar la calidad del servidor con un aumento de nivel.',
                ),
                BenefitItem(
                  icon: Icons.cloud_upload,
                  title: 'Subida de Archivos Más Grande',
                  description:
                      'Sube archivos de hasta 100 MB en lugar de 8 MB.',
                ),
                BenefitItem(
                  icon: Icons.people,
                  title: 'Acceso Anticipado a Funciones',
                  description:
                      'Prueba nuevas funciones antes de que sean lanzadas.',
                ),
                BenefitItem(
                  icon: Icons.shield,
                  title: 'Soporte Prioritario',
                  description:
                      'Obtén asistencia más rápida y eficiente del equipo de soporte.',
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NitroPlansScreen()),
                );
              },
              child: Text('Ver Planes'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BenefitItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  BenefitItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.deepPurple),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
