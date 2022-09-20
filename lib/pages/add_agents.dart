// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/hotel_agents.dart';

class AddAgent extends StatefulWidget {
  const AddAgent({super.key});

  @override
  State<AddAgent> createState() => _AddAgentState();
}

class _AddAgentState extends State<AddAgent> {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HotelAgents()),
                );
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.orange[300],
          foregroundColor: Colors.black,
          onPressed: () {
            // Respond to button press
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddAgent()),
            );
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('Data Added Successfully!'),
                    ),
                barrierDismissible: true);
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
