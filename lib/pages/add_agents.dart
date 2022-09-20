// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_new, duplicate_ignore, use_build_context_synchronously, avoid_print
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:reseller_apk/pages/hotel_agents.dart';

class AddAgent extends StatefulWidget {
  const AddAgent({super.key});

  @override
  State<AddAgent> createState() => _AddAgentState();
}

class _AddAgentState extends State<AddAgent> {
  //TextField controllers
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();

//function to get locally stored bearer token
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

//POST req, Add Agents Function
  void _register() async {
    var data = {
      'name': namecontroller.text,
      'email': emailcontroller.text,
      'phone': phonecontroller.text,
      'address': addresscontroller.text,
    };
    try {
      //checks if valid user by auth in API
      String? token = '';
      await getToken().then((result) {
        token = result;
      });
      print('$token');
      Response response = await post(
        Uri.parse('http://192.168.43.238:3000/api/agents'),
        headers: {
          'Authorization': 'Bearer $token',
        },
        body: data,
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext ctx) => HotelAgents(),
          ),
        );
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Agent Data Added Successfully!'),
                ),
            barrierDismissible: true);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[300],
        title: Text(
          'Goa',
          style: TextStyle(color: Colors.black),
        ),
        //save button
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {
                //data saved alert message
                showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                          title: Text('Hotel Saved!!'),
                        ),
                    barrierDismissible: true);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  CircleBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            //Name TextField
            ListTile(
              leading: const Icon(Icons.person),
              title: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  hintText: "Name",
                ),
              ),
            ),
            SizedBox(height: 20),
            // Email TextFieled
            ListTile(
              leading: const Icon(Icons.email),
              title: TextField(
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
            ),
            SizedBox(height: 20),
            //Phone TextFiled
            ListTile(
              leading: const Icon(Icons.phone),
              title: TextField(
                  controller: phonecontroller,
                  decoration: InputDecoration(
                    hintText: "Phone",
                  ),
                  keyboardType: TextInputType.phone),
            ),
            SizedBox(height: 20),
            //Address TextField
            ListTile(
              leading: const Icon(Icons.work),
              title: TextField(
                controller: addresscontroller,
                decoration: InputDecoration(
                  hintText: "address",
                ),
              ),
            ),
            SizedBox(height: 20),
            // ListTile(
            //   leading: const Icon(Icons.location_city),
            //   title: TextField(
            //     decoration: InputDecoration(
            //       hintText: "Latitude and Longitude",
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      // Add agent floatingButton
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.orange[300],
          foregroundColor: Colors.black,
          onPressed: () {
            _register();
            // Respond to button press
          },
          label: Text(
            '   ADD   ',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
