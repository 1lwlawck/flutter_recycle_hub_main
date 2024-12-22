import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login Page Validation', () {
    test('should show error when email is empty', () {
      final email = '';
      final isValidEmail = email.isNotEmpty;
      expect(isValidEmail, false);
    });

    test('should show error when email format is invalid', () {
      final email = 'invalidemail';
      final isValidEmail =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
              .hasMatch(email);
      expect(isValidEmail, false);
    });

    test('should validate correct email format', () {
      final email = 'test@example.com';
      final isValidEmail =
          RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
              .hasMatch(email);
      expect(isValidEmail, true);
    });

    test('should show error when password is empty', () {
      final password = '';
      final isValidPassword = password.isNotEmpty;
      expect(isValidPassword, false);
    });
  });
}
