
import 'dart:convert';
import 'package:flutter_mask_stock_api/model/store.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';


//Model

class StoreRepository {
  final _distance = Distance();

  Future<List<Store>> fetch(double lat, double lng) async {
    final stores = List<Store>();

    var url =
        'https://gist.githubusercontent.com/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94/sample.json';

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
        final jsonStores = jsonResult['stores'];

        jsonStores.forEach((e) {
          final store = Store.fromJson(e);
          final km = _distance.as(LengthUnit.Kilometer,
              LatLng(store.lat, store.lng), LatLng(lat, lng));
          store.km = km;
          stores.add(store); //json 값을 store에 저장
        });
        print('fetch완료');

        return stores.where((e) {
          //원하는 조건만 보여주는 코드
          return e.remainStat == 'plenty' ||
              e.remainStat == 'some' || // ||는 or 연산자
              e.remainStat == 'few';
        }).toList()
          ..sort((a, b) => a.km.compareTo(b.km)); // 가까운 순서대로 정렬하기
      } else {
        return [];
      }
    } catch(e) {
      return [];
    }
   }
  }
