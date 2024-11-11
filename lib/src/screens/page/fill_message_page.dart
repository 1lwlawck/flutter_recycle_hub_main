import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/src/widgets/custom_bottom_navbar.dart';

class FillMessagePage extends StatelessWidget {
  const FillMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 74, 250),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Message',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Message item
            _buildMessageItem(
              avatar: 'assets/images/icons/avatar.png', // Adjust the path
              name: 'Bank Sampah Mawar Merah',
              date: '8 Okt',
              messagePreview:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ultricies...',
            ),
            // Add more message items as needed
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildMessageItem({
    required String avatar,
    required String name,
    required String date,
    required String messagePreview,
  }) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(avatar),
            radius: 24,
          ),
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            messagePreview,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
          trailing: Text(
            date,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ),
        Divider(color: Colors.grey[300]),
      ],
    );
  }
}
