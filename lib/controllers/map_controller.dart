import 'dart:convert';

import 'package:geocoding/geocoding.dart';
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
    _updateAllCoordinates();
  }

  Future<void> callPhoneNumber(String phoneNumber) async {
    final Uri url = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      Get.snackbar('Lỗi', 'Không thể mở trình gọi điện');
    }
  }

  ///API
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
          LatLng(destination.latitude.value, destination.longitude.value));
      selectedRoute.assignAll(route);
    }
  }

  /// Cập nhật tọa độ từ địa chỉ
  Future<void> updateCoordinates(DestinationModel destination) async {
    try {
      String address = destination.address.value;

      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        destination.latitude.value = locations.first.latitude;
        destination.longitude.value = locations.first.longitude;
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> _updateAllCoordinates() async {
    for (var destination in destinations) {
      if (destination.address.value.isNotEmpty) {
        await updateCoordinates(destination);
      }
    }
  }
}
