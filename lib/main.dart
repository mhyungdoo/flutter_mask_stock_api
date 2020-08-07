import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future fetch() async {
    var url = 'https://8oi9s0nnth.apigw.ntruss.com/corona19-masks/v1/storesByGeo/json?lat=37.637902&lng=126.919325&m=5000';
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
 //  print('Response body: ${response.body}');  // 한글 깨짐 발생
  //  print('Response body: ${utf8.decode(response.bodyBytes)}');  //한글 깨지지 않도록 변경
    //다시 JSON 형태로 변경
    print('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Open API'),),
      body: Center(
      child: RaisedButton(
        onPressed: fetch,
        child: Text('test'),
      ),
      ),
    );
  }
}
