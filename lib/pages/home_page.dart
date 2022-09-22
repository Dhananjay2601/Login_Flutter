// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, sort_child_properties_last
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/hotel%20agent/hotel_agents.dart';
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
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.orange[600],
        title: Text(
          'Goa',
          style: TextStyle(color: Colors.black),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.orange[100],
        // drawer logout button
        child: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                alignment: Alignment.topLeft,
                child: TextButton(
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.orange[500]),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                    // logOut user and clear user data from local storage
                    showDialog(
                        context: context,
                        builder: (ctxt) {
                          return ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 100.0),
                            child: AlertDialog(
                              backgroundColor: Colors.orange[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              contentPadding: EdgeInsets.all(0),
                              title: Center(
                                child: Text(
                                  "Logout!",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              content: Padding(
                                padding: const EdgeInsets.all(30.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text("Do you really want to logout?"),
                                    SizedBox(height: 40),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(
                                          width: 115,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.orange[500],
                                            ),
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 115,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.orange[500],
                                            ),
                                            child: Text(
                                              "Logout",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (BuildContext ctx) =>
                                                              LoginPage()));
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.remove('email');
                  },
                ),
              ),
            ),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HotelAgents()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
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
                      MaterialPageRoute(builder: (context) => HotelAgents()),
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
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
                      MaterialPageRoute(builder: (context) => HotelAgents()),
                    );
                  },

                  child: Container(
                    padding: EdgeInsets.all(13),
                    decoration: BoxDecoration(
                      color: Colors.orange[500],
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
