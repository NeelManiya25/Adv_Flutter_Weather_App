import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/models/app_model.dart';
import 'package:weather_app/models/theme_model.dart';
import 'package:weather_app/providers/app_providers.dart';
import 'package:weather_app/providers/connectivity_provider.dart';
import 'package:weather_app/providers/theme_provider.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/views/screens/HomePage.dart';
import 'package:weather_app/views/screens/Home_page_ios.dart';
import 'package:weather_app/views/screens/SplashScreen.dart';
import 'package:weather_app/views/screens/intoScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool appTheme = prefs.getBool("isDark") ?? false;

  var isvisited;
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppProvider(
            appModel: AppModel(isIos: true),
          ),
        ),
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
        initialRoute: (isvisited) ? 'Splash' : '/',
        routes: {
          'HomePage': (context) => const HomePage(),
          '/': (context) => const SplashScreen(),
          'into': (context) => const intro_page(),
          'Home_ios': (context) => const Home_ios_Page(),
        },
      ),
    ),
  );
}
