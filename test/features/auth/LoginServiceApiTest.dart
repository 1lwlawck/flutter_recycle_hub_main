import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_recycle_hub/features/auth/service/LoginServiceApi.dart';
import 'package:flutter_recycle_hub/core/services/config.dart';

// Mocking http.Client
class MockClient extends Mock implements http.Client {}

void main() {
  group('AuthLoginService Test', () {
    late AuthLoginService authLoginService;
    late MockClient mockClient;

    setUp(() {
      mockClient = MockClient();
      authLoginService = AuthLoginService(client: mockClient);
    });

    final loginUrl = Uri.parse('${Config.API_URL}/api/auth/login');

    test('should return success when login is successful', () async {
      // Arrange
      final mockSuccessResponse = {
        "user": {
          "email": "test@example.com",
          "nama_user": "Test User",
          "id": 1
        },
        "access_token": "test_access_token",
        "refresh_token": "test_refresh_token"
      };

      when(mockClient.post(
        loginUrl, // Menggunakan URL dari Config
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': 'test@example.com',
          'password': 'password',
          'remember': true
        }),
      )).thenAnswer(
        (_) async => http.Response(json.encode(mockSuccessResponse), 200),
      );

      // Act
      final result = await authLoginService.login(
        email: 'test@example.com',
        password: 'password',
        remember: true,
      );

      // Assert
      expect(result['success'], true);
      expect(result['access_token'], 'test_access_token');
      expect(result['refresh_token'], 'test_refresh_token');
    });

    test('should return failure when login fails', () async {
      // Arrange
      final mockFailureResponse = {"message": "Invalid credentials"};

      when(mockClient.post(
        loginUrl, // Menggunakan URL dari Config
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': 'wrong@example.com',
          'password': 'wrongpassword',
          'remember': false
        }),
      )).thenAnswer(
        (_) async => http.Response(json.encode(mockFailureResponse), 401),
      );

      // Act
      final result = await authLoginService.login(
        email: 'wrong@example.com',
        password: 'wrongpassword',
        remember: false,
      );

      // Assert
      expect(result['success'], false);
      expect(result['message'], "Invalid credentials");
    });

    test('should handle exception when network error occurs', () async {
      // Arrange
      when(mockClient.post(
        loginUrl,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenThrow(Exception('Network Error'));

      // Act
      final result = await authLoginService.login(
        email: 'test@example.com',
        password: 'password',
        remember: false,
      );

      // Assert
      expect(result['success'], false);
      expect(result['message'], contains('Terjadi kesalahan saat login'));
    });
  });
}
