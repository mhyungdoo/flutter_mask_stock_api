import 'package:flutter/material.dart';
import 'package:flutter_mask_stock_api/ui/view/main_page.dart';
import 'package:flutter_mask_stock_api/viewmodel/store_model.dart';
import 'package:provider/provider.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider.value(
    value: StoreModel(), //ViewModel 추가
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {  //상태 변경할 필요가 없으므로 stateless로 변경. 상태 변경은 다른 파일로 분리
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}