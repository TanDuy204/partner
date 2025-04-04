import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:partner/models/delivery_receipt_model.dart';

import '../service/uidata.dart';

class DeliveryReceiptController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final deliveryReceipts = <DeliveryReceiptModel>[].obs;
  var receiptImages = <String>[].obs;
  var isSubmitting = false.obs;

  @override
  void onInit() {
    super.onInit();
    deliveryReceipts.addAll(deliveryReceiptList);
  }

  ///Hàm chụp ảnh
  Future<void> addImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      receiptImages.add(pickedFile.path);
    }
  }

  void deleteImage(int index) {
    if (index >= 0 && index < receiptImages.length) {
      receiptImages.removeAt(index);
    }
  }

  void updateWeight(int receiptIndex, int wasteIndex, int weight) {
    deliveryReceipts[receiptIndex].wasteItems[wasteIndex].weight = weight;
    deliveryReceipts.refresh();
  }

  void updateWasteStatus(int receiptIndex, int wasteIndex, String status) {
    deliveryReceipts[receiptIndex].wasteItems[wasteIndex].status = status;
    deliveryReceipts.refresh();
  }

  /// Hàm kiểm tra tính hợp lệ
  bool validateReceipt(DeliveryReceiptModel receipt) {
    if (receipt.wasteItems.isEmpty) {
      Get.snackbar("Lỗi", "Danh sách loại rác không được để trống.");
      return false;
    }
    for (var item in receipt.wasteItems) {
      if (item.weight <= 0) {
        Get.snackbar("Lỗi", "Vui lòng nhập khối lượng cho ${item.name}.");
        return false;
      }
    }
    if (receiptImages.isEmpty) {
      Get.snackbar("Lỗi", "Vui lòng chụp ít nhất 1 ảnh biên bản.");
      return false;
    }
    return true;
  }

  ///Hàm nộp biên bản
  Future<void> submitReceipt(DeliveryReceiptModel receipt) async {
    receipt.receiptImages = receiptImages.toList();

    if (!validateReceipt(receipt)) return;

    try {
      isSubmitting.value = true;
      await Future.delayed(const Duration(seconds: 2));
      Get.back(result: "done");
    } catch (e) {
      Get.snackbar("Lỗi", "Gửi biên bản thất bại!");
    } finally {
      isSubmitting.value = false;
    }
  }
}
