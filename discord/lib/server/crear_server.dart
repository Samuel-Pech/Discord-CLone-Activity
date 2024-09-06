import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CrearServer extends StatefulWidget {
  const CrearServer({Key? key, required String serverType}) : super(key: key);

  @override
  _CrearServerState createState() => _CrearServerState();
}

class _CrearServerState extends State<CrearServer> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _serverNameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _createServer() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final response = await http.post(
        Uri.parse('https://discord.com/api/v9/guilds'),
        headers: {
          'Authorization': 'Bot YOUR_BOT_TOKEN',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': _serverNameController.text,
        }),
      );

      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 201) {
        Navigator.of(context).pop(_serverNameController.text);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al crear el servidor')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Servidor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Text(
                "Crear un nuevo servidor",
                style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _serverNameController,
                decoration: InputDecoration(
                  labelText: 'Nombre del Servidor',
                  labelStyle: TextStyle(color: Colors.white54),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del servidor';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _createServer,
                      child: Text('Crear Servidor'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
