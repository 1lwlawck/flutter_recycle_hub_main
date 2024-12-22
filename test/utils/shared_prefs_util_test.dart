import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_recycle_hub/utils/shared_prefs_util.dart';

void main() {
  group('SharedPrefsUtil Test', () {
    setUp(() async {
      SharedPreferences.setMockInitialValues({});
    });

    test('should save and get access token', () async {
      await SharedPrefsUtil.saveAccessToken('test_token');
      final token = await SharedPrefsUtil.getAccessToken();

      expect(token, 'test_token');
    });

    test('should save and get user email', () async {
      await SharedPrefsUtil.saveUserEmail('test@example.com');
      final email = await SharedPrefsUtil.getUserEmail();

      expect(email, 'test@example.com');
    });

    test('should clear all data', () async {
      await SharedPrefsUtil.saveUserEmail('test@example.com');
      await SharedPrefsUtil.saveAccessToken('test_token');

      await SharedPrefsUtil.clearAll();

      final email = await SharedPrefsUtil.getUserEmail();
      final token = await SharedPrefsUtil.getAccessToken();

      expect(email, '');
      expect(token, '');
    });
  });
}
