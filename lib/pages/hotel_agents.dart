// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/add_agents.dart';

class HotelAgents extends StatefulWidget {
  const HotelAgents({super.key});

  @override
  State<HotelAgents> createState() => _HotelAgentsState();
}

class _HotelAgentsState extends State<HotelAgents> {
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
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Hotel Shivleela ',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 50),
              Text(
                'Hotel Taj',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 50),
              Text(
                'Hotel Marriott',
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 50),
              Text(
                'Hotel Sun Inn',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
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
          },
          icon: Icon(Icons.add),
          label: Text(
            'Add Hotel',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
