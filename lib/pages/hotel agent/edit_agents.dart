// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_new, duplicate_ignore, use_build_context_synchronously, avoid_print
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:reseller_apk/pages/hotel%20agent/hotel_agents.dart';

class EditAgent extends StatefulWidget {
  //get agent ID from agent data
  final AgentDataModel agentDataModel;
  const EditAgent({Key? key, required this.agentDataModel}) : super(key: key);

  @override
  State<EditAgent> createState() => _EditAgentState();
}

class _EditAgentState extends State<EditAgent> {
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

//PUT req, Edit Agents function
  void _edit(String id) async {
    var data = {
      '_id': id,
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
      Response response = await put(
        //radha sir ip
        Uri.parse('http://192.168.43.238:3000/api/agents/$id'),
        //dhanu phone ip
        // Uri.parse('http://192.168.138.87:3000/api/agents'),
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
      //Floating Edit Button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.orange[300],
          foregroundColor: Colors.black,
          onPressed: () {
            _edit(widget.agentDataModel.id);
            print(widget.agentDataModel.id);
          },
          label: Text(
            '   EDIT   ',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
