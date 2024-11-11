import 'package:flutter/material.dart';
import 'src/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      onGenerateRoute: (settings) {
        // Mendapatkan widget sesuai rute
        WidgetBuilder builder = getAppRoutes()[settings.name]!;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
        );
      },
      initialRoute: '/',
    );
  }
}
