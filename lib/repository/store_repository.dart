
import 'dart:convert';
import 'package:flutter_mask_stock_api/model/store.dart';
import 'package:http/http.dart' as http;


//Model

class StoreRepository {

  Future<List<Store>> fetch() async {
    final stores = List<Store>();

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';

    var response = await http.get(url);
    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    final jsonStores = jsonResult['stores'];

      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e)); //json 값을 store에 저장
      });
    print('fetch완료');

    return stores;

  }

}
