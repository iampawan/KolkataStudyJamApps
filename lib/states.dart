import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatesPage extends StatefulWidget {
  @override
  _StatesPageState createState() => _StatesPageState();
}

class _StatesPageState extends State<StatesPage> {
  var states;
  Random random;
  @override
  void initState() {
    super.initState();
    random = Random();
    fetchStates();
  }

  fetchStates() async {
    var res = await http.get("http://vocab.nic.in/rest.php/states/json");
    var decodedRes = jsonDecode(res.body);
    states = decodedRes['states'];
    print(states);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("States App"),
      ),
      body: states != null
          ? ListView.builder(
              itemCount: states.length,
              itemBuilder: (context, index) => ListTile(
                    title:
                        Text(states[index]['state']['state_name'].toString()),
                    leading: CircleAvatar(
                      backgroundColor:
                          Color(0xff000000 + random.nextInt(0x00ffffff)),
                      child:
                          Text(states[index]['state']['state_id'].toString()),
                    ),
                  ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
