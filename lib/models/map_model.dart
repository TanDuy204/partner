import 'package:get/get.dart';

class DestinationModel {
  final String companyName;
  final int bd;
  final int cc;
  final String gom;
  final String note;
  final String contactName;
  final String contactPhone;
  final double latitude;
  final double longitude;
  RxBool isSigned;
  RxString address;

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
    required this.latitude,
    required this.longitude,
  })  : isSigned = RxBool(isSigned),
        address = RxString(address);
}
