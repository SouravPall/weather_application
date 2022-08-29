import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_application/pages/settings_page.dart';
import 'package:weather_application/pages/weather_page.dart';
import 'package:weather_application/provider/weather_provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (_) => WeatherProvider(),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Application',
      theme: ThemeData(
        fontFamily: 'RobotoMono',
        primarySwatch: Colors.blue,
      ),
      initialRoute: WeatherPage.routeName,
      routes: {
        WeatherPage.routeName : (_) => WeatherPage(),
        SettingsPage.routeName: (_) => SettingsPage(),
      },
    );
  }
}

