import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_recycle_hub/core/services/config.dart'; // Import the Config class

class ChatbotService {
  // Function to send message to the API
  Future<String> sendMessage(String message) async {
    // Endpoint URL from the Config class
    final Uri url =
        Uri.parse('${Config.API_URL}chat'); // Append the correct endpoint

    try {
      // Prepare the JSON body with the message
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'message': message}), // Send message in JSON format
      );

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        // Parse the response body
        final Map<String, dynamic> data = jsonDecode(response.body);
        // Assuming the response contains a 'response' field
        return data['response'] ??
            'No response from API'; // Return the 'response' field
      } else {
        // If the response status code is not 200, return an error message
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      // Handle network or other errors
      return 'Error: $e';
    }
  }
}
