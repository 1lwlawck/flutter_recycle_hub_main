import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/chatbot/services/ChatbotService.dart';

class Chatbotpage extends StatefulWidget {
  const Chatbotpage({super.key});

  @override
  _ChatbotpageState createState() => _ChatbotpageState();
}

class _ChatbotpageState extends State<Chatbotpage> {
  List<String> messages = [];
  TextEditingController _controller = TextEditingController();
  ChatbotService _chatbotService = ChatbotService();

  int _chatbotMessageIndex = -1;

  // Fungsi untuk mengirim pesan
  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      setState(() {
        messages.add(_controller.text); // Menambah pesan dari pengguna ke chat
      });

      String response = await _chatbotService.sendMessage(_controller.text);

      _chatbotMessageIndex = messages.length;

      _simulateTypingEffect(response);

      _controller.clear(); // Menghapus teks setelah dikirim
    }
  }

  // Fungsi untuk mensimulasikan efek mengetik (seperti GPT)
  void _simulateTypingEffect(String response) async {
    String displayedText = "";

    setState(() {
      messages.add(""); // Menambahkan pesan chatbot kosong terlebih dahulu
    });

    for (int i = 0; i < response.length; i++) {
      displayedText += response[i];
      setState(() {
        messages[_chatbotMessageIndex] = displayedText;
      });
      await Future.delayed(
          const Duration(milliseconds: 50)); // Penundaan antara karakter (50ms)
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
          'Chatbot',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          },
        ),
      ),
      body: Column(
        children: [
          // Menampilkan pesan chat
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isSentByUser = index % 2 == 0;
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
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Text(
                        messages[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input text field untuk mengirim pesan
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Tanya seputar daur ulang...',
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
                  onPressed:
                      _sendMessage, // Panggil _sendMessage hanya sekali di sini
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
