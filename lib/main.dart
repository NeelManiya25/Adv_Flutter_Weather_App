import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/theme_model.dart';

import 'Providers/Connectivityprovider.dart';
import 'Providers/theme_provider.dart';
import 'Providers/weather_providers.dart';
import 'Views/Screens/HomePage.dart';
import 'Views/Screens/SplashScreen.dart';
import 'Views/Screens/introScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool appTheme = prefs.getBool("isDark") ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            themeModel: ThemeModel(isDark: appTheme),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ConnectivityProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherProvider(),
        ),
      ],
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ),
        themeMode: (Provider.of<ThemeProvider>(context).themeModel.isDark)
            ? ThemeMode.dark
            : ThemeMode.light,
        routes: {
          '/': (context) => intro_page(),
          'SplashScreen': (context) => const SplashScreen(),
          'HomePage': (context) => const HomePage(),
        },
      ),
    ),
  );
}
