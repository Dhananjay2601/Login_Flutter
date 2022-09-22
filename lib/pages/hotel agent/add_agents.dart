// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unnecessary_new, duplicate_ignore, use_build_context_synchronously, avoid_print
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:reseller_apk/pages/hotel%20agent/hotel_agents.dart';

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
        //radha sir ip
        Uri.parse('http://192.168.43.238:3000/api/agents'),
        //dhanu phone ip
        // Uri.parse('http://192.168.138.87:3000/api/agents'),
        //localhost
        // Uri.parse('http://localhost:3000/api/agents'),

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
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.orange[100],
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
              child: Text(
                'Add agent details here',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            SizedBox(height: 20),
            //Name TextField
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              title: TextField(
                controller: namecontroller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Name",
                ),
              ),
            ),
            SizedBox(height: 20),
            // Email TextFieled
            ListTile(
              leading: const Icon(
                Icons.email,
                color: Colors.black,
              ),
              title: TextField(
                controller: emailcontroller,
                cursorColor: Colors.black,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  hintText: "Email",
                ),
              ),
            ),
            SizedBox(height: 20),
            //Phone TextFiled
            ListTile(
              leading: const Icon(
                Icons.phone,
                color: Colors.black,
              ),
              title: TextField(
                  controller: phonecontroller,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    hintText: "Phone",
                  ),
                  keyboardType: TextInputType.phone),
            ),
            SizedBox(height: 20),
            //Address TextField
            ListTile(
              leading: const Icon(
                Icons.location_on_sharp,
                color: Colors.black,
              ),
              title: TextField(
                controller: addresscontroller,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
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
        padding: const EdgeInsets.only(bottom: 50),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.orange[500],
          foregroundColor: Colors.black,
          onPressed: () {
            showDialog(
                context: context,
                builder: (ctxt) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 100.0),
                    child: AlertDialog(
                      backgroundColor: Colors.orange[100],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      contentPadding: EdgeInsets.all(0),
                      title: Center(
                          child: Text(
                        "Add Agent!",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      content: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Do you really want to add agent?",
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 115,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange[500],
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
                                      backgroundColor: Colors.orange[500],
                                    ),
                                    child: Text(
                                      "Add",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      _register();
                                      Navigator.pop(context);
                                      showDialog(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                                title: Text(
                                                    'Agent Added Successfully!!'),
                                              ),
                                          barrierDismissible: true);
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
