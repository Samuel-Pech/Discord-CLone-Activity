import 'package:flutter/material.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

class ChatArea extends StatefulWidget {
  final String currentChannel;
  final Function toggleChat;
  final bool isChatExpanded;
  final Function closeChat;
  final void Function(String message) sendMessage;

  ChatArea({
    required this.currentChannel,
    required this.toggleChat,
    required this.isChatExpanded,
    required this.closeChat,
    required this.sendMessage,
  });

  @override
  _ChatAreaState createState() => _ChatAreaState();
}

class _ChatAreaState extends State<ChatArea> {
  TextEditingController messageController = TextEditingController();
  bool isMessageEmpty = true;
  List<String> messages = []; // Lista de mensajes
  bool isEmojiVisible = false;

  @override
  void initState() {
    super.initState();
    // Aquí podrías inicializar tu servicio de Discord
  }

  void sendMessage() {
    if (!isMessageEmpty) {
      widget.sendMessage(messageController.text);
      setState(() {
        messages.add(messageController.text);
        messageController.clear();
        isMessageEmpty = true;
        isEmojiVisible = false;
      });
    }
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
          color: Color(0xFF2C2F33),
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
                      widget.closeChat();
                    },
                  ),
                  Text(
                    '#${widget.currentChannel}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      // Search logic here
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(messages[index],
                        style: TextStyle(color: Colors.white)),
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
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: () {
                            // Add logic here
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.comment, color: Colors.white),
                          onPressed: () {
                            // Comment logic here
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.card_giftcard, color: Colors.white),
                          onPressed: () {
                            // Gift logic here
                          },
                        ),
                        Flexible(
                          child: TextField(
                            controller: messageController,
                            onChanged: (value) {
                              setState(() {
                                isMessageEmpty = value.isEmpty;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: 'Escribe un mensaje...',
                              hintStyle: TextStyle(color: Colors.white54),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: Colors.grey[800],
                            ),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        if (!isMessageEmpty)
                          IconButton(
                            icon: Icon(Icons.send, color: Colors.white),
                            onPressed: sendMessage,
                          ),
                        if (isMessageEmpty)
                          IconButton(
                            icon:
                                Icon(Icons.emoji_emotions, color: Colors.white),
                            onPressed: () {
                              setState(() {
                                isEmojiVisible = !isEmojiVisible;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isEmojiVisible,
                    child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        onEmojiSelected: (emoji, category) {
                          setState(() {
                            var emoji;
                            messageController.text += emoji!.emoji;
                            isMessageEmpty = messageController.text.isEmpty;
                          });
                        },
                        config: const Config(
                          columns: 7,
                          emojiSizeMax: 32.0,
                          verticalSpacing: 0,
                          horizontalSpacing: 0,
                          initCategory: Category.RECENT,
                          bgColor: Color(0xFF2C2F33),
                          indicatorColor: Colors.blue,
                          iconColor: Colors.grey,
                          iconColorSelected: Colors.white,
                          backspaceColor: Colors.white,
                          skinToneDialogBgColor: Colors.white,
                          skinToneIndicatorColor: Colors.grey,
                          enableSkinTones: true,
                          recentsLimit: 28,
                          tabIndicatorAnimDuration: kTabScrollDuration,
                          categoryIcons: CategoryIcons(),
                          buttonMode: ButtonMode.MATERIAL,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
