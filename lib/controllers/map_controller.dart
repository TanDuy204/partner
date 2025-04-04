import 'dart:convert';

// import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import "package:http/http.dart" as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:url_launcher/url_launcher.dart';

import '../models/map_model.dart';

class MapsController extends GetxController {
  var driverLocation = Rxn<LatLng>();
  var selectedRoute = RxList<LatLng>();
  var destinations = <DestinationModel>[].obs;
  loc.Location location = loc.Location();

  @override
  void onInit() {
    super.onInit();
    _checkLocationPermission();
    _updateDriverLocation();
  }

  Future<void> _checkLocationPermission() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    loc.PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == loc.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != loc.PermissionStatus.granted) return;
    }
    loc.LocationData currentLocationData = await location.getLocation();
    if (currentLocationData.latitude != null &&
        currentLocationData.longitude != null) {
      driverLocation.value =
          LatLng(currentLocationData.latitude!, currentLocationData.longitude!);
    }
  }

  Future<void> _updateDriverLocation() async {
    location.onLocationChanged.listen((loc.LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        driverLocation.value =
            LatLng(currentLocation.latitude!, currentLocation.longitude!);
      }
    });
  }

  void markAsSigned(int index) {
    destinations[index].isSigned.value = true;
    destinations.refresh();
  }

  void loadDestinations(List<DestinationModel> data) {
    destinations.assignAll(data);
  }

  /// Ham gọi
  Future<void> callPhoneNumber(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar('Lỗi', 'Không thể mở trình gọi điện');
    }
  }

  ///Api
  Future<List<LatLng>> getRoute(LatLng start, LatLng end) async {
    final url = Uri.parse(
      'https://router.project-osrm.org/route/v1/driving/'
      '${start.longitude},${start.latitude};${end.longitude},${end.latitude}'
      '?overview=full&geometries=geojson',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List coordinates = data['routes'][0]['geometry']['coordinates'];

        return coordinates.map((coord) {
          return LatLng(coord[1], coord[0]);
        }).toList();
      }
    } catch (e) {
      print("Lỗi tải tuyến đường: $e");
    }
    return [];
  }

  void clearRoute() {
    selectedRoute.clear();
  }

  ///Lấy tuến đường
  Future<void> fetchRouteToDestination(DestinationModel destination) async {
    clearRoute();
    if (driverLocation.value != null) {
      List<LatLng> route = await getRoute(driverLocation.value!,
          LatLng(destination.latitude, destination.longitude));
      selectedRoute.assignAll(route);
    }
  }

  // Future<void> updateAddress(DestinationModel destination) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       destination.latitude,
  //       destination.longitude,
  //     );
  //
  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks.first;
  //       String newAddress =
  //           "${place.street}, ${place.locality}, ${place.country}";
  //
  //       destination.address.value = newAddress;
  //
  //       print("Địa chỉ: $newAddress");
  //     }
  //   } catch (e) {
  //     destination.address.value = "Không tìm thấy địa chỉ";
  //   }
  // }
}
