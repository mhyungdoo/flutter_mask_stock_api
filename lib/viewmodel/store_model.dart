
import 'package:flutter/cupertino.dart';
import 'package:flutter_mask_stock_api/model/store.dart';
import 'package:flutter_mask_stock_api/repository/store_repository.dart';


//ViewModel

class StoreModel with ChangeNotifier {
    List<Store> stores = [];

    final _storeRepository = StoreRepository();

    StoreModel(){
      fetch();
    }

    Future fetch() async {
      stores = await _storeRepository.fetch();
      notifyListeners(); // 바뀌었으니까 통지~~ChangeNotifierProvider가 받음
    }

}