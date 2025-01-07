import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  List<Map<String, String>> messages = [
    {"sender": "You", "message": "Hi, how are you?"},
    {"sender": "Receiver", "message": "I'm good, thanks! How about you?"},
    {"sender": "You", "message": "I'm doing well, just working on some tasks."},
    {
      "sender": "Receiver",
      "message": "Sounds good! Let me know if you need help."
    },
  ];

  final TextEditingController _controller = TextEditingController();

  // Fungsi untuk mengirim pesan
  void _sendMessage() {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      setState(() {
        messages.add({"sender": "You", "message": message});
      });
      _controller.clear(); // Clear text field after sending
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF006769),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Message',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context); // Navigate back to previous screen
          },
        ),
      ),
      body: Column(
        children: [
          // Displaying chat messages with bubbles
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isSentByUser = messages[index]['sender'] == "You";
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: isSentByUser
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isSentByUser
                            ? const Color(0xFF006769)
                            : Colors.grey[700],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: Offset(4, 4),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Text(
                        messages[index]['message']!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input text field for typing messages
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage, // Send message when pressed
                  splashRadius: 20,
                  iconSize: 30,
                  color: Colors.black,
                  padding: const EdgeInsets.all(10),
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
