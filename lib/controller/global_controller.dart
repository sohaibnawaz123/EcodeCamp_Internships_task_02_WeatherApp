import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController {
  final RxBool _isloading = true.obs;
  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  RxBool checkLoading() => _isloading;
  RxDouble getlatitude() => _latitude;
  RxDouble getlongitude() => _longitude;

  @override
  void onInit() {
    super.onInit();
    if (_isloading.isTrue) {
      getLocation();
    }
  }

  getLocation() async {
    bool isSeviceEnable = await Geolocator.isLocationServiceEnabled();
    LocationPermission locationPermission;
    if (!isSeviceEnable) {
      return Future.error('Location Not Enable');
    }
    locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location Permission Denied Forever');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location Permission Denied');
      }
    }

    return await Geolocator.getCurrentPosition(
            // ignore: deprecated_member_use
            desiredAccuracy: LocationAccuracy.best)
        .then((value) {
      _latitude.value = value.latitude;
      _longitude.value = value.longitude;
      _isloading.value = false;
    });
  }
}
