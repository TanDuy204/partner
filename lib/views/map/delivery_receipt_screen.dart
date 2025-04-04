import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partner/common/styles.dart';
import 'package:partner/models/delivery_receipt_model.dart';
import 'package:partner/views/map/image_screen.dart';

import '../../controllers/delivery_controller.dart';

class DeliveryReceiptScreen extends StatefulWidget {
  final List<DeliveryReceiptModel> deliveryReceipt;

  const DeliveryReceiptScreen({super.key, required this.deliveryReceipt});

  @override
  State<DeliveryReceiptScreen> createState() => _DeliveryReceiptScreenState();
}

class _DeliveryReceiptScreenState extends State<DeliveryReceiptScreen> {
  late final DeliveryReceiptController deliveryReceiptController;
  final TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    deliveryReceiptController = Get.put(DeliveryReceiptController());
  }

  String formatTime(DateTime time) => DateFormat('HH:mm').format(time);
  String formatDay(DateTime time) => DateFormat('dd/MM/yyyy').format(time);

  void showInputDialog(BuildContext context, int receiptIndex, int wasteIndex) {
    final controller = Get.find<DeliveryReceiptController>();
    final wasteItem =
        controller.deliveryReceipts[receiptIndex].wasteItems[wasteIndex];
    final TextEditingController inputController =
        TextEditingController(text: wasteItem.weight.toString());

    Get.defaultDialog(
      title: "Thêm dữ liệu",
      titleStyle: const TextStyle(
          color: Color(0xFF007AFF), fontSize: 20, fontWeight: FontWeight.w500),
      content: Column(
        children: [
          TextField(
            controller: inputController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Nhập khối lượng",
              suffixText: "Kg",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: 150,
            height: 45,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007AFF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                final weight = int.tryParse(inputController.text);
                if (weight != null) {
                  controller.updateWeight(receiptIndex, wasteIndex, weight);
                  Get.back();
                } else {
                  Get.snackbar("Lỗi", "Vui lòng nhập số hợp lệ");
                }
              },
              child: const Text(
                "Thêm",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Biên bản giao nhận",
          style: TextStyle(
              color: Color(0xFF0E4A67),
              fontSize: 28,
              fontWeight: FontWeight.w800),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thông tin chung
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text("Số: ${widget.deliveryReceipt[0].id}",
                      style: AppTextStyles.bodyTextSmall(context)),
                  const SizedBox(height: 10),
                  const Text("(V/v thu gom, vận chuyển và vận chuyển CTNH)"),
                  const SizedBox(height: 10),
                  Text(
                      "Thời gian: ${formatTime(widget.deliveryReceipt[0].time)}, ngày: ${formatDay(widget.deliveryReceipt[0].time)}",
                      style: const TextStyle(color: Colors.blue)),
                  const SizedBox(height: 10),
                  _buildContent(context, "Địa điểm: ",
                      widget.deliveryReceipt[0].location),
                  const SizedBox(height: 5),
                  _buildContent(context, "Bên giao (Bên A): ",
                      widget.deliveryReceipt[0].sender),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 10),

            /// Tiêu đề danh sách
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Tên chất thải"),
                Text("Mã CTNH"),
                Text("Trạng thái"),
                Text("Số lượng (kg)"),
              ],
            ),
            const SizedBox(height: 10),

            /// Danh sách chất thải
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.deliveryReceipt.length,
              itemBuilder: (context, receiptIndex) {
                final receipt = widget.deliveryReceipt[receiptIndex];
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Obx(() {
                    final wasteItems = deliveryReceiptController
                        .deliveryReceipts[receiptIndex].wasteItems;
                    return Column(
                      children: List.generate(wasteItems.length, (wasteIndex) {
                        final wasteItem = wasteItems[wasteIndex];
                        return Container(
                          margin: const EdgeInsets.all(5),
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text(wasteItem.name,
                                    style: const TextStyle(color: Colors.grey)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(wasteItem.code,
                                    style: const TextStyle(color: Colors.grey)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  padding: const EdgeInsets.only(left: 30),
                                  height: 25,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                          blurRadius: 2,
                                          spreadRadius: 0,
                                          offset: Offset(0, 1)),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: wasteItem.status,
                                      alignment: Alignment.center,
                                      items: ["R", "L", "B"]
                                          .map((status) => DropdownMenuItem(
                                                value: status,
                                                child: Text(status,
                                                    style: const TextStyle(
                                                        color: Colors.green)),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        if (value != null) {
                                          deliveryReceiptController
                                              .updateWasteStatus(receiptIndex,
                                                  wasteIndex, value);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    showInputDialog(
                                        context, receiptIndex, wasteIndex);
                                  },
                                  child: Text(
                                    "${wasteItem.weight} Kg",
                                    style: const TextStyle(
                                        fontSize: 16, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  }),
                );
              },
            ),

            const SizedBox(height: 10),
            const Center(
              child: Text(
                "Trạng Thái: R (rắn), L (lỏng), B (bùn)",
                style: TextStyle(color: Color(0xFF787486), fontSize: 15),
              ),
            ),
            const SizedBox(height: 20),

            /// Ảnh biên bản
            Text(
              "Hình ảnh Biên Bản Giao Nhận",
              style: AppTextStyles.titleMediumGery(context),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9).withOpacity(0.29),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: deliveryReceiptController.addImageFromCamera,
                    child: Container(
                      height: 140,
                      width: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          size: 60,
                          color: Color.fromARGB(255, 115, 114, 114),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  Obx(() {
                    return SizedBox(
                      height: 150,
                      width: 150,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: List.generate(
                          deliveryReceiptController.receiptImages.length,
                          (index) {
                            String imagePath =
                                deliveryReceiptController.receiptImages[index];
                            return Positioned(
                              left: index * 5,
                              top: index * 5,
                              child: Transform.rotate(
                                angle: index == 0 ? 0 : (index - 1) * 0.08,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ImageScreen(
                                              imagePaths:
                                                  deliveryReceiptController
                                                      .receiptImages,
                                              onDeleteImages: (index) {
                                                deliveryReceiptController
                                                    .deleteImage(index);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.file(
                                        File(imagePath),
                                        fit: BoxFit.cover,
                                        width: 120,
                                        height: 140,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 20),

            /// Nút gửi biên bản
            Center(
              child: SizedBox(
                width: 300,
                height: 60,
                child: Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          deliveryReceiptController.isSubmitting.value
                              ? Colors.grey
                              : Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.white),
                      ),
                    ),
                    onPressed: deliveryReceiptController.isSubmitting.value
                        ? null
                        : () {
                            final receipt = widget.deliveryReceipt[0];
                            if (deliveryReceiptController
                                .validateReceipt(receipt)) {
                              deliveryReceiptController.submitReceipt(receipt);
                            }
                          },
                    child: deliveryReceiptController.isSubmitting.value
                        ? const CircularProgressIndicator(color: Colors.white)
                        : Text(
                            "Gửi Biên Bản Giao Nhận",
                            style: AppTextStyles.buttonLabel(context),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

Widget _buildContent(BuildContext context, String text1, String text2) {
  return Text.rich(
    TextSpan(
      text: text1,
      style: AppTextStyles.bodyTextSmall(context),
      children: [
        TextSpan(text: text2, style: AppTextStyles.titleMediumGery(context))
      ],
    ),
  );
}
