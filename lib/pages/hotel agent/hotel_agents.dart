// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, sort_child_properties_last, use_key_in_widget_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/hotel%20agent/add_agents.dart';
import 'package:http/http.dart' as http;
import 'package:reseller_apk/pages/hotel%20agent/delete_agent.dart';
import 'package:reseller_apk/pages/hotel%20agent/edit_agents.dart';
import 'package:reseller_apk/pages/hotel%20agent/agent_detail.dart';

class HotelAgents extends StatefulWidget {
  @override
  State<HotelAgents> createState() => _HotelAgentsState();
}

class _HotelAgentsState extends State<HotelAgents> {
  //GET req calling list of agents from API
  Future<List<AgentDataModel>> _getAgents() async {
    var data = await http.get(
      //radha sir ip
      Uri.parse('http://192.168.43.238:3000/api/agents'),
      //dhanu phone ip
      // Uri.parse('http://192.168.138.87:3000/api/agents'),
    );
    var jsonData = json.decode(data.body);
    List<AgentDataModel> agentsData = [];
    for (var u in jsonData) {
      AgentDataModel data = AgentDataModel(
          u['_id'], u['name'], u['address'], u['phone'], u['email']);
      agentsData.add(data);
    }
    print(agentsData.length);
    return agentsData;
  }

  DeleteAgent deleteAgent = DeleteAgent();

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
                  child: Text('Loading Agents....'),
                ),
              );
            }
            //Display List of all agents
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      tileColor: Colors.grey,
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          //Edit agent button
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditAgent(
                                    agentDataModel: snapshot.data[index],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          //Delete agent button
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (ctxt) {
                                    return AlertDialog(
                                      title: Center(child: Text("Delete")),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text(
                                            "Do you really want to delete this agent?",
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange[300],
                                                ),
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange[300],
                                                ),
                                                child: Text(
                                                  "Delete",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                onPressed: () {
                                                  deleteAgent.deleteAgent(
                                                      snapshot.data[index].id,
                                                      context);
                                                  Navigator.pop(context);
                                                  showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          AlertDialog(
                                                            title: Text(
                                                                'Agent Deleted!!'),
                                                          ),
                                                      barrierDismissible: true);
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AgentDetail(
                              agentDataModel: snapshot.data[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                });
          }),
      //Add hotel button
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.orange[300],
          foregroundColor: Colors.black,
          onPressed: () {
            // Respond to button press
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddAgent()),
            );
          },
          // icon: Icon(Icons.add),
          // label: Text(
          //   'Add Hotel',
          //   style: TextStyle(fontSize: 20),
          // ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//function to get agent details
class AgentDataModel {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String email;

  AgentDataModel(this.id, this.name, this.address, this.phone, this.email);
}
