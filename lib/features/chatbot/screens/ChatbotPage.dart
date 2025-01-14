import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/chatbot/services/ChatbotService.dart';

class Chatbotpage extends StatefulWidget {
  const Chatbotpage({super.key});

  @override
  _ChatbotpageState createState() => _ChatbotpageState();
}

class _ChatbotpageState extends State<Chatbotpage> {
  List<String> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ChatbotService _chatbotService = ChatbotService();

  int? _chatbotMessageIndex; // Indeks untuk pesan chatbot

  void _sendMessage() async {
    if (_controller.text.isNotEmpty) {
      final userMessage = _controller.text; // Simpan teks input sebelum dihapus

      setState(() {
        messages.add(userMessage); // Tambahkan pesan pengguna ke daftar
        _controller.clear(); // Hapus teks dari TextField
      });

      // Tunggu respons dari chatbot
      String response = await _chatbotService.sendMessage(userMessage);

      setState(() {
        _chatbotMessageIndex = messages.length; // Simpan indeks untuk respons
        messages.add(""); // Tambahkan placeholder untuk efek mengetik
      });

      // Gunakan efek mengetik untuk menampilkan respons
      _simulateTypingEffect(response);
    }
  }

  void _simulateTypingEffect(String response) async {
    if (_chatbotMessageIndex == null) return; // Pastikan indeks valid

    String displayedText = "";

    for (int i = 0; i < response.length; i++) {
      displayedText += response[i];
      await Future.delayed(const Duration(milliseconds: 50)); // Efek delay

      setState(() {
        messages[_chatbotMessageIndex!] = displayedText; // Perbarui teks di UI
      });
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
                      key: Key('chat_bubble_$index'),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('chat_input_field'),
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
                  key: const Key('send_button'),
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
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
