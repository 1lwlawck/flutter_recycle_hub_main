import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/auth/screens/verify_email.dart';
import 'package:flutter_recycle_hub/features/account/screens/tambah_alamat_page.dart';
import 'package:flutter_recycle_hub/features/auth/screens/otp_verification_page.dart';
import 'package:flutter_recycle_hub/features/dropoff/screens/dropoff_location.dart';
import 'package:flutter_recycle_hub/features/dropoff/screens/information_dropoff_page.dart';
import 'package:flutter_recycle_hub/features/orders/screens/empty_order_page.dart';
import 'package:flutter_recycle_hub/features/history/screens/fill_history_page.dart';
import 'package:flutter_recycle_hub/features/orders/screens/fill_order_page.dart';
import 'package:flutter_recycle_hub/features/history/screens/rincian_history_page.dart';
import 'package:flutter_recycle_hub/features/dropoff/screens/main/dropoff_page.dart';
import 'package:flutter_recycle_hub/features/orders/screens/rincian_order_page.dart';
import 'package:flutter_recycle_hub/splash/splash1.dart';
import '../../features/auth/screens/login_page.dart';
import '../../features/auth/screens/register_page.dart';
import '../../features/home/screens/home_page.dart';
import '../../features/account/screens/main/account_page.dart';
import '../../features/auth/screens/forgot_password.dart';
import '../../features/history/screens/empty_history_page.dart';
import '../../features/messages/screens/empty_message_page.dart';
import '../../features/messages/screens/fill_message_page.dart';
// import '../../features/auth/screens/verify_otp.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/': (BuildContext context) => SplashScreen(),

    // Auth
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => RegisterScreen(),
    '/change_password': (BuildContext context) => const ChangePasswordPage(),
    '/verify-email': (BuildContext context) => EmailVerificationPage(),
    '/otp-verification': (BuildContext context) {
      final email = ModalRoute.of(context)?.settings.arguments as String?;
      if (email == null || email.isEmpty) {
        return const Center(
          child: Text('Error: Email tidak ditemukan!'),
        );
      }
      return OtpVerificationPage(email: email);
    },

    // Page
    '/home': (BuildContext context) => HomePage(),

    // Dropoff
    '/dropoff': (BuildContext context) => DropOffPage(),
    '/dropoff-info': (BuildContext context) => DropOffInfoPage(),
    '/nearby-waste-bank': (BuildContext context) => NearbyWasteBankPage(),

    // Order
    '/orders': (BuildContext context) => OrderPage(),
    '/empty-order': (BuildContext context) => EmptyOrderPage(),
    '/rincian-order': (BuildContext context) => RincianOrderPage(),

    // History
    '/history': (BuildContext context) => FillHistoryPage(),
    '/empty-history': (BuildContext context) => OrderHistoryPage(),
    '/rincian-history': (BuildContext context) => RincianHistoryPage(),

    // Message
    '/empty-messages': (BuildContext context) => const EmptyMessagePage(),
    '/fill-messages': (BuildContext context) => const FillMessagePage(),

    // Account
    '/account': (BuildContext context) => AccountPage(),
    '/tambah_alamat': (BuildContext context) => TambahAlamatPage(),
  };
}
