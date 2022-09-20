// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/add_agents.dart';
import 'package:reseller_apk/pages/home_page.dart';
import 'package:reseller_apk/pages/hotel_agents.dart';
import 'package:reseller_apk/pages/login_page.dart';

void main() async {
  runApp(const MyApp());
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