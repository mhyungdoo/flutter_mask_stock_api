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
  var isLoading = true;

  Future fetch() async {
    setState(() {
      isLoading = true;
    });
    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';

    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

    setState(() {
      stores.clear(); // 값이 담겨져 있으면 지워준다.
      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e)); //json 값을 store에 저장
      });
      isLoading = false;
    });
    //  print(jsonResult['stores']);  // JSON에서 불러오고 싶은 key 값 지정
    //  print('Response status: ${response.statusCode}');
    //  print('Response body: ${utf8.decode(response.bodyBytes)}');  //한글 깨지지 않도록 변경
    //  다시 JSON 형태로 변경
    print('fetch완료');

  }

  // fetch를 실행시켜 줌

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${stores.length} 곳'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetch,
          )
        ],
      ),
      body: isLoading == true
          ? loadingWidget()
          : ListView(
              // 로딩 중이면 로딩 화면을 보여주고 로딩이 false면 리스트뷰를 보여준다
              children: stores.map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: Text(e.remainStat ?? '매진'),
                );
              }).toList(),
            ),
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
