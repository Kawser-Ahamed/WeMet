import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wemet/Test/model.dart';
import 'package:http/http.dart' as http;

class UI extends StatefulWidget {
  const UI({super.key});

  @override
  State<UI> createState() => _UIState();
}

class _UIState extends State<UI> {
  
  List<Model> myValues = [];
  Future<List<Model>> getdata() async{
    var response = await http.get(Uri.parse('http://192.168.0.107:3000/get_data'));
    var data = jsonDecode(response.body.toString());
    for(var values in data){
      myValues.add(Model.fromJson(values));
    }
    return myValues;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getdata(), 
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Text(snapshot.data![index].name);
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: (){
                  getdata();
                }, 
                child: const Text("Press Here"),
              ),
            ),
          ],
        )
      ),
    );
  }
}