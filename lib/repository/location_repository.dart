import 'package:geolocator/geolocator.dart';

// geolocator package 최신 버전을 pubspec.yaml에 추가하면 Geolocator() 에서 에러 발생함

class LocationRepository {
  final _geolocator = Geolocator();

  Future<Position> getCurrentLocation() async {
    Position position = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return position;
  }

}

