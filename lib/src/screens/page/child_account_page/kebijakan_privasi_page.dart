import 'package:flutter/material.dart';

class KebijakanPrivasiPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Kebijakan Privasi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Kebijakan Privasi RecycleHub',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Mulai dari Oktober 2024',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Maecenas eu magna eu turpis consectetur efficitur vel eget orci. '
                    'Duis laoreet sagittis nisi, vel vulputate enim eleifend eu. '
                    'Etiam finibus nibh nulla, eget interdum magna suscipit vel. '
                    'Integer dapibus sed neque ac pharetra. In hac habitasse platea dictumst. '
                    'Mauris dapibus, erat vitae faucibus consectetur, massa tortor maximus nulla, '
                    'at aliquet ligula justo et dolor.\n\n'
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Maecenas eu magna eu turpis consectetur efficitur vel eget orci. '
                    'Duis laoreet sagittis nisi, vel vulputate enim eleifend eu. '
                    'Etiam finibus nibh nulla, eget interdum magna suscipit vel. '
                    'Integer dapibus sed neque ac pharetra. In hac habitasse platea dictumst. '
                    'Mauris dapibus, erat vitae faucibus consectetur, massa tortor maximus nulla, '
                    'at aliquet ligula justo et dolor.\n\n',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
