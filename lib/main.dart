import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mask_stock_api/model/store.dart';
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

  final stores = List<Store>();

  Future fetch() async {
    var url = 'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';

    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));

    final jsonStores = jsonResult['stores'];

    stores.clear();
    jsonStores.forEach((e){
      stores.add(Store.fromJson(e));
      });

    //  print(jsonResult['stores']);  // JSON에서 불러오고 싶은 key 값 지정
    //  print('Response status: ${response.statusCode}');
    //  print('Response body: ${utf8.decode(response.bodyBytes)}');  //한글 깨지지 않도록 변경
    //  다시 JSON 형태로 변경
    //  print('Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : 0 곳'),),
      body: Center(
      child: RaisedButton(
        onPressed: () async {
          await fetch();
          print(stores.length);
        },
        child: Text('테스트'),
      ),
      ),
    );
  }
}
