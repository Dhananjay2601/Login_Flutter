// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, avoid_print
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

//function to get locally stored bearer token
Future<String?> getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

//delete agent function by using agent ID
class DeleteAgent {
  Future deleteAgent(String id, BuildContext context) async {
    try {
      //checks if valid user by auth in API
      String? token = '';
      await getToken().then((result) {
        token = result;
      });
      print('$token');
      Response response = await delete(
        //radha sir ip
        Uri.parse('http://192.168.43.238:3000/api/agents/$id'),
        //dhanu phone ip
        // Uri.parse('http://192.168.138.87:3000/api/agents'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        Navigator.pushNamed(context, '/hotel_agents');
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Agent Deleted Successfully!'),
                ),
            barrierDismissible: true);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
