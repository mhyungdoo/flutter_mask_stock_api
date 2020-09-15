import 'package:flutter/cupertino.dart';
import 'package:flutter_mask_stock_api/model/store.dart';
import 'package:flutter_mask_stock_api/repository/location_repository.dart';
import 'package:flutter_mask_stock_api/repository/store_repository.dart';
import 'package:geolocator/geolocator.dart';


//ViewModel

class StoreModel with ChangeNotifier {
  var isLoading = false;
  List<Store> stores = [];

  final _storeRepository = StoreRepository();
  final _locationRepository = LocationRepository();

  StoreModel(){
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners();

    Position position = await _locationRepository.getCurrentLocation();

    stores = await _storeRepository.fetch(position.latitude, position.longitude);
    isLoading = false;
    notifyListeners(); // 바뀌었으니까 통지~~ChangeNotifierProvider가 받음


  }

}