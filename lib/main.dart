import 'package:flutter/material.dart';
import 'package:flutter_mask_stock_api/model/store.dart';
import 'package:flutter_mask_stock_api/viewmodel/store_model.dart';
import 'package:provider/provider.dart';

//View
void main() =>
    runApp(ChangeNotifierProvider.value(
        value: StoreModel(),
        child: MyApp(),
    ));

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

  var isLoading = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.where((e) {
          //원하는 조건만 보여주는 코드
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' || // ||는 or 연산자
              e.remainStat == 'few';
        }).length} 곳'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
                storeModel.fetch();

            },
          )
        ],
      ),
      body: isLoading == true
          ? loadingWidget()
          : ListView(
              // 로딩 중이면 로딩 화면을 보여주고 로딩이 false면 리스트뷰를 보여준다
              children: storeModel.stores.where((e) {
                //원하는 조건만 보여주는 코드
                return e.remainStat == 'plenty' ||
                    e.remainStat == 'some' || // ||는 or 연산자
                    e.remainStat == 'few';
              }).map((e) {
                return ListTile(
                  title: Text(e.name),
                  subtitle: Text(e.addr),
                  trailing: _buildRemainStatWidget(e),
                );
              }).toList(),
            ),
    );
  }

  Widget _buildRemainStatWidget(Store store) {
    // 단위 기능을 메소드로 만들어 위젯으로 활용하는 방식
    var remainStat = '판매중지';
    var description = '판매중지';
    var color = Colors.black;

    if (store.remainStat == 'plenty') {
      remainStat = '충분';
      description = '100개 이상';
      color = Colors.green;
    }

    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        description = '100개 이상';
        color = Colors.green;
        break;

      case 'some':
        remainStat = '보통';
        description = '30 ~ 100개';
        color = Colors.yellow;
        break;

      case 'few':
        remainStat = '부족';
        description = '2~30개 이상';
        color = Colors.red;
        break;

      case 'empty':
        remainStat = '소진임박';
        description = '1개 이하';
        color = Colors.grey;
        break;
      default:
    }

    return Column(
      children: <Widget>[
        Text(
          remainStat,
          style: TextStyle(color: color, fontWeight: FontWeight.bold),
        ),
        Text(description,
            style: TextStyle(color: color, fontWeight: FontWeight.bold))
      ],
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
