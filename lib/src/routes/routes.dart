import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/src/screens/auth/verify_email.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_account_page/tambah_alamat_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_dropoff_page/dropoff_location.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_dropoff_page/information_dropoff_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_order_page/empty_order_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_order_page/fill_history_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/fill_order_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_order_page/rincian_history_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/dropoff_page.dart';
import 'package:flutter_recycle_hub/src/screens/page/child_order_page/rincian_order_page.dart';
import 'package:flutter_recycle_hub/src/screens/splash/splash1.dart';
import '../screens/auth/login_page.dart';
import '../screens/auth/register_page.dart';
import '../screens/page/home_page.dart';
import '../screens/page/account_page.dart';
import '../screens/auth/forgot_password.dart';
import '../screens/page/child_order_page/empty_history_page.dart';
import '../screens/page/empty_message_page.dart';
import '../screens/page/fill_message_page.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/': (BuildContext context) => SplashScreen(),

    // Auth
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/change_password': (BuildContext context) => const ChangePasswordPage(),
    '/verify_email': (BuildContext context) => EmailVerificationPage(),

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
