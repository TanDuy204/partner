import '../models/delivery_receipt_model.dart';
import '../models/map_model.dart';
import '../models/person_model.dart';
import '../models/task_model.dart';

List<PersonModel> personList = [
  PersonModel(name: "Nguyen Tan Duy", licensePlate: "75C-456022", msx: "C123"),
];
List<Task> taskList = [
  Task(
    id: "1",
    title: "Đại học Y Dược 2",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 4, 2, 16, 30),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế1",
    price: 1200000,
  ),
  Task(
    id: "2",
    title: "Chợ Rẫy2",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 4, 2, 14, 20),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế2",
    price: 500000,
  ),
  Task(
    id: "3",
    title: "Bệnh viện FV3",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 4, 2, 17, 30),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế3",
    price: 800000,
  ),
  Task(
    id: "4",
    title: "Bệnh viện FV",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 3, 26, 17, 30),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế4",
    price: 800000,
  ),
  Task(
    id: "5",
    title: "Bệnh viện FV",
    description: "Gom đủ khối lượng...",
    datetime: DateTime(2025, 3, 13, 17, 30),
    route: "Quận 5 (TP.HCM) => Quận 10 (TP.HCM)",
    cargoType: "Rác thải y tế",
    price: 800000,
  ),
];
List<DestinationModel> destinationList = [
  DestinationModel(
    companyName: "Công Ty CP SX TM Sáng Việt",
    bd: 0,
    cc: 588,
    gom: "L1/1",
    note: "Gom đủ khối lượng không phát sinh",
    contactName: "Chị Giao",
    contactPhone: "0123456789",
    address: " 1, Hà Khê, Kim Long, Thành phố Huế, Thừa Thiên Huế, Việt Nam",
  ),
  DestinationModel(
    companyName: "Công Ty TNHH ABC",
    bd: 5,
    cc: 250,
    gom: "L1/2",
    note: "Có phát sinh khối lượng, cần kiểm tra lại",
    contactName: "Anh Huy",
    contactPhone: "0987654321",
    address: "Đại Nội, Phú Hòa, Thành phố Huế, Thừa Thiên Huế, Việt Nam",
  ),
];
List<DeliveryReceiptModel> deliveryReceiptList = [
  DeliveryReceiptModel(
    id: "003437",
    location: "Dự Án Nhà máy sử dụng nước Thái Nhiên liệu TP.HCM giai đoạn 2",
    time: DateTime(2025, 2, 21, 9, 30),
    sender: "Công ty CP Xây Dựng Đê Kè và phát triển Nông Thôn Hải Dương",
    wasteItems: [
      WasteItem(name: "Giẻ lau TPNH", code: "180201"),
      WasteItem(name: "Dầu thải", code: "190205"),
      WasteItem(name: "Bùn thải", code: "190799"),
    ],
  ),
];
