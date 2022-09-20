// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, sort_child_properties_last
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/hotel_agents.dart';
import 'package:reseller_apk/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SharedPreferences sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.orange[300],
        title: Text(
          'Goa',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        // drawer logout button
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: TextButton(
            child: Text(
              'Log Out',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              // logOut user and clear user data from local storage
              showDialog(
                  context: context,
                  builder: (ctxt) {
                    return AlertDialog(
                      title: Text("Logout"),
                      content: Column(
                        children: [
                          Text("Do you Really want to logout?"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child: Text("Logout"),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext ctx) =>
                                              LoginPage()));
                                },
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  });
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // button to go to hotel agent
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  // onTap: signIn,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HotelAgents()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Hotel Agent',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // button to go to restaurent agent
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  // onTap: signIn,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HotelAgents()),
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        'Restaurent Agent',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),

              // button to go to taxi agent
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextButton(
                  // onTap: signIn,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HotelAgents()),
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.orange[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        ' Taxi Agent',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
