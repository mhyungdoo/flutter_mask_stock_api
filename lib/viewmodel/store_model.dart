
import 'package:flutter/cupertino.dart';
import 'package:flutter_mask_stock_api/model/store.dart';
import 'package:flutter_mask_stock_api/repository/store_repository.dart';


//ViewModel

class StoreModel with ChangeNotifier {
  var isLoading = false;
    List<Store> stores = [];

    final _storeRepository = StoreRepository();

    StoreModel(){
      fetch();
    }

    Future fetch() async {
      isLoading = true;
      notifyListeners();

      stores = await _storeRepository.fetch();
      isLoading = false;
      notifyListeners(); // 바뀌었으니까 통지~~ChangeNotifierProvider가 받음


    }

}