import 'package:get/get.dart';

class DestinationModel extends GetxController {
  final String companyName;
  final int bd;
  final int cc;
  final String gom;
  final String note;
  final String contactName;
  final String contactPhone;
  RxBool isSigned;
  RxString address;
  RxDouble latitude;
  RxDouble longitude;

  DestinationModel({
    required this.companyName,
    required this.bd,
    required this.cc,
    required this.gom,
    required this.note,
    required this.contactName,
    required this.contactPhone,
    bool isSigned = false,
    required String address,
    double latitude = 0.0,
    double longitude = 0.0,
  })  : isSigned = RxBool(isSigned),
        address = RxString(address),
        latitude = RxDouble(latitude),
        longitude = RxDouble(longitude);
}
