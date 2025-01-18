import 'package:flutter/material.dart';
import 'package:flutter_recycle_hub/features/account/screens/TambahAlamatPage.dart';
import 'package:flutter_recycle_hub/features/chatbot/screens/ChatbotPage.dart';
import 'package:flutter_recycle_hub/features/dropoff/screens/DropOffLocationPage.dart';
import 'package:flutter_recycle_hub/features/dropoff/screens/DropOffInformationPage.dart';
import 'package:flutter_recycle_hub/features/orders/screens/OrderEmptyPage.dart';
import 'package:flutter_recycle_hub/features/history/screens/HistoryFillPage.dart';
import 'package:flutter_recycle_hub/features/orders/screens/OrderFillPage.dart';
import 'package:flutter_recycle_hub/features/history/screens/HistoryEmptyPage.dart';
import 'package:flutter_recycle_hub/features/dropoff/screens/main/DropOffPage.dart';
import 'package:flutter_recycle_hub/features/orders/screens/OrderRincianPage.dart';
import 'package:flutter_recycle_hub/splash/SecondSplash.dart';
import '../../features/auth/screens/LoginUserPage.dart';
import '../../features/auth/screens/RegisterUserPage.dart';
import '../../features/home/screens/Homepage.dart';
import '../../features/account/screens/main/AccountPage.dart';
import '../../features/history/screens/HistoryRincianPage.dart';
import '../../features/article/screens/ArticleListPage.dart';
import '../../features/account/screens/EditProfilePage.dart';

Map<String, WidgetBuilder> getAppRoutes() {
  return {
    '/': (BuildContext context) => SplashScreen2(),

    // Auth
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => RegisterScreen(),

    // Page
    '/home': (BuildContext context) => HomePage(),

    // Chatbot
    '/chatbot': (BuildContext context) => const Chatbotpage(),

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

    // Article
    '/articles': (BuildContext context) => const ArticleListPage(),

    // Account
    '/account': (BuildContext context) => AccountPage(),
    '/tambah_alamat': (BuildContext context) => TambahAlamatPage(),
    '/edit_profile': (BuildContext context) => EditProfilePage(),
  };
}
