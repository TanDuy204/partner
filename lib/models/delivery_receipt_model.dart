class DeliveryReceiptModel {
  final String id;
  final String location;
  final DateTime time;
  final String sender;
  final List<WasteItem> wasteItems;
  List<String> receiptImages;

  DeliveryReceiptModel({
    required this.id,
    required this.location,
    required this.time,
    required this.sender,
    required this.wasteItems,
    this.receiptImages = const [],
  });
}

class WasteItem {
  final String name;
  final String code;
  String status;
  int weight;

  WasteItem({
    required this.name,
    required this.code,
    this.status = "R",
    this.weight = 0,
  });
}
