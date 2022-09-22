// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, avoid_print
import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/hotel%20agent/add_agents.dart';
import 'package:reseller_apk/pages/home_page.dart';
import 'package:reseller_apk/pages/hotel%20agent/hotel_agents.dart';
import 'package:reseller_apk/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  runApp(MaterialApp(home: email == null ? LoginPage() : HomePage()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage(),
        // initialRoute: "/pages/main_page.dart",
        routes: {
          // '/': (context) => LoginPage(),
          '/home_page': (context) => HomePage(),
          '/add_agents': (context) => AddAgent(),
          '/hotel_agents': (context) => HotelAgents(),
        });
  }
}
