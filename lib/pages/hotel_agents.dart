// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/add_agents.dart';
import 'package:http/http.dart' as http;

class HotelAgents extends StatefulWidget {
  const HotelAgents({super.key});

  @override
  State<HotelAgents> createState() => _HotelAgentsState();
}

class _HotelAgentsState extends State<HotelAgents> {
  Future<List<Agent>> _getAgents() async {
    var data = await http.get(
      Uri.parse('http://192.168.43.238:3000/api/agents'),
    );

    var jsonData = json.decode(data.body);

    List<Agent> agents = [];

    for (var u in jsonData) {
      Agent agent =
          Agent(u['name'], u['address'], u['phone'], u['email'], u['type']);
      agents.add(agent);
    }
    print(agents.length);
    return agents;
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
      body: FutureBuilder(
          future: _getAgents(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading....'),
                ),
              );
            }
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      tileColor: Colors.grey,
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: () {
                        Navigator.pushNamed(context, '/add_agents');
                      },
                    ),
                  );
                });
          }),
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

class Agent {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String type;

  Agent(this.name, this.address, this.phone, this.email, this.type);
}
