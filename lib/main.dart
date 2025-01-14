import 'package:flutter/material.dart';
import 'core/routes/Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: (settings) {
        WidgetBuilder? builder = getAppRoutes()[settings.name];
        if (builder == null) {
          return null;
        }
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              builder(context),
        );
      },
      initialRoute: '/',
      routes: getAppRoutes(),
    );
  }
}
