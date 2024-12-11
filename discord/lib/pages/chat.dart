import 'package:discord/DataBase/database_helper.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ChatArea extends StatefulWidget {
  final String currentChannel;
  final Function toggleChat;
  final bool isChatExpanded;
  final Function? closeChat;
  final void Function(String message) sendMessage;

  ChatArea({
    required this.currentChannel,
    required this.toggleChat,
    required this.isChatExpanded,
    this.closeChat,
    required this.sendMessage,
  });

  @override
  _ChatAreaState createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  TextEditingController messageController = TextEditingController();
  bool isMessageEmpty = true;
  List<Map<String, dynamic>> messages = [];
  List<String> predefinedResponses = [
    "¡Hola! ¿Cómo estás?",
    "¿Necesitas ayuda?",
    "¡Qué tal, qué cuentas?",
    "¡Bienvenido al chat!",
    "Estoy aquí para ayudarte.",
    "¿En qué puedo ayudarte?",
    "¡Hola! ¿En qué puedo asistirte hoy?",
    "¿Te gustaría saber algo más?",
    "¡Me alegra verte!",
    "¡Genial verte por aquí!",
    "¿Qué tal todo?",
    "¡Espero que estés bien!",
    "¡Qué bueno verte en el chat!",
    "¡Estás haciendo un gran trabajo!",
    "¡Vamos bien, sigue así!",
    "¡Cuéntame más!",
    "¡Tu mensaje me hizo sonreír!",
    "¿Quieres que te ayude con algo?",
    "¡Claro, aquí estoy para lo que necesites!",
    "¡Cuéntame, qué tal tu día!",
    "¡Hola! ¿Todo bien?",
    "¡Qué alegría verte!",
    "¿Cómo te va?",
    "¡Gracias por escribirme!",
    "¡Me encantaría ayudarte!",
    "¡Un placer saludarte!",
    "¡Estoy disponible para lo que necesites!",
    "¡Aquí estoy para responder a todas tus preguntas!",
    "¡Vamos a resolverlo juntos!",
    "¡Espero que estés teniendo un gran día!",
    "¡Me alegra que estés aquí!",
    "¡Qué gusto saludarte!",
    "¿En qué puedo ser útil hoy?",
    "¡Aquí estoy para ayudarte en lo que necesites!",
    "¡Gracias por tu mensaje, estoy listo para ayudarte!",
    "¡Qué bien verte por aquí!",
    "¡Espero que tu día esté yendo de maravilla!",
    "¿Cómo te encuentras hoy?",
    "¡Estoy disponible para cualquier consulta que tengas!",
    "¡Cuéntame, ¿cómo va todo?",
    "¿Algo que te gustaría preguntar o comentar?",
    "¡Aquí estoy para cualquier duda que tengas!",
    "¡Espero poder ayudarte con lo que necesites!",
    "¡Estoy para lo que necesites, no dudes en preguntar!",
    "¡Es un placer tener esta conversación contigo!",
    "¡Gracias por tomarte el tiempo de escribirme!",
    "¡Estoy feliz de poder ayudarte!",
    "¡Tu mensaje es importante para mí, cuéntame más!",
    "¡Qué bueno tenerte en el chat!",
    "¡Con gusto, ayúdame a entender mejor tu pregunta!",
    "¡Estoy atento a tu mensaje!",
    "¡Es un placer poder asistirte!",
    "¡Vamos a solucionar esto juntos!",
    "¡Cualquier cosa que necesites, no dudes en decirme!",
    "¡Me alegra mucho poder conversar contigo!",
    "¡Qué bueno tener esta conversación, cuéntame más!",
    "¡Siempre es bueno poder ayudarte!",
    "¡Es un placer estar aquí para ayudarte!",
    "¡Vamos a resolverlo de la mejor manera!",
    "¡Gracias por tu paciencia, estoy aquí para ayudarte!",
  ];

  bool isEmojiVisible = false;
  bool isTyping = false;
  String typingMessage = "Escribiendo...";
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final data = await DatabaseHelper().getMessages();
    setState(() {
      messages = data
          .map((e) => {
                'content': e['content'] as String,
                'image': e['image'] ?? '',
              })
          .toList();
    });
  }

  Future<void> sendMessage() async {
    if (!isMessageEmpty || _imageFile != null) {
      final content = messageController.text;

      await DatabaseHelper().insertMessage(content, _imageFile?.path ?? '');

      setState(() {
        messages.add({'content': content, 'image': _imageFile?.path ?? ''});
        messageController.clear();
        isMessageEmpty = true;
        isEmojiVisible = false;
        _imageFile = null;
        isTyping = true;
      });

      await Future.delayed(Duration(seconds: 2));

      // Verifica la conectividad antes de enviar la respuesta automática
      bool hasConnection = await _checkInternetConnection();
      if (hasConnection) {
        _sendAppropriateResponse(content);
      } else {
        setState(() {
          messages.add({'content': 'No hay conexión a Internet.', 'image': ''});
        });
      }
    }
  }

  Future<bool> _checkInternetConnection() async {
    // Verifica si hay conexión a Internet
    return await InternetConnectionChecker().hasConnection;
  }

  void _sendAppropriateResponse(String userMessage) async {
    String response = _getResponseBasedOnMessage(userMessage);

    await DatabaseHelper().insertMessage(response, '');

    setState(() {
      messages.add({'content': typingMessage, 'image': ''});
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      messages.removeWhere((msg) => msg['content'] == typingMessage);
      messages.add({'content': response, 'image': ''});
      isTyping = false;
    });
  }

  String _getResponseBasedOnMessage(String userMessage) {
    if (userMessage.toLowerCase().contains("hola")) {
      return "¡Hola! ¿Cómo estás?";
    } else if (userMessage.toLowerCase().contains("bien") ||
        userMessage.toLowerCase().contains("y tú")) {
      return "¡Qué bien! ¿En qué puedo ayudarte hoy?";
    } else if (userMessage.toLowerCase().contains("cómo estás")) {
      return "Estoy bien, gracias por preguntar. ¿Y tú?";
    } else if (userMessage.toLowerCase().contains("qué tal")) {
      return "Todo bien, ¿y tú qué tal?";
    } else if (userMessage.toLowerCase().contains("necesitas ayuda")) {
      return "Sí, ¿en qué puedo asistirte?";
    } else {
      return (predefinedResponses..shuffle())
          .first; // Selecciona una respuesta aleatoria si no encuentra coincidencias
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        isMessageEmpty = false;
      });
    }
  }

  void _removeImage() {
    setState(() {
      _imageFile = null;
      isMessageEmpty = true;
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.isChatExpanded) {
          widget.toggleChat();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFF2C2F33), // Discord background color
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      if (widget.closeChat != null) {
                        widget.closeChat!();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                  Text(
                    '#${widget.currentChannel}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      // Lógica para búsqueda
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message['image'] != '')
                          Image.file(
                            File(message['image']),
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        if (message['content'] != '')
                          Text(
                            message['content'],
                            style: TextStyle(color: Colors.white),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: widget.isChatExpanded,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.0),
                    color: Color(0xFF36393F),
                    child: Row(
                      children: [
                        if (_imageFile != null)
                          Stack(
                            children: [
                              Image.file(
                                _imageFile!,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(
                                  icon: Icon(Icons.close, color: Colors.white),
                                  onPressed: _removeImage,
                                ),
                              ),
                            ],
                          ),
                        IconButton(
                          icon: Icon(Icons.image, color: Colors.white),
                          onPressed: _pickImage,
                        ),
                        Expanded(
                          child: TextField(
                            controller: messageController,
                            onChanged: (text) {
                              setState(() {
                                isMessageEmpty =
                                    text.isEmpty && _imageFile == null;
                              });
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: 'Escribe un mensaje...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.send,
                              color:
                                  isMessageEmpty ? Colors.grey : Colors.white),
                          onPressed: isMessageEmpty ? null : sendMessage,
                        ),
                      ],
                    ),
                  ),
                  if (isEmojiVisible)
                    EmojiPicker(onEmojiSelected: (emoji, category) {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
