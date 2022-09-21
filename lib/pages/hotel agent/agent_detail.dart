// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:reseller_apk/pages/hotel agent/hotel_agents.dart';

class AgentDetail extends StatelessWidget {
  final AgentDataModel agentDataModel;
  const AgentDetail({Key? key, required this.agentDataModel}) : super(key: key);

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
      //Display Agent Details
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Text(agentDataModel.id),
              Text(agentDataModel.name),
              Text(agentDataModel.email),
              Text(agentDataModel.address),
              Text(agentDataModel.phone)
            ],
          ),
        ),
      ),
    );
  }
}
