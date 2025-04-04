import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partner/common/styles.dart';
import 'package:partner/controllers/home_controller.dart';

class TripScheduleScreen extends StatelessWidget {
  const TripScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find();

    DateTime currentDay = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(currentDay);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Danh sách chuyến",
          style: AppTextStyles.titleMedium(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'Xin chào, ',
                    style: AppTextStyles.bodyTextMedium(context),
                    children: [
                      TextSpan(
                        text: 'Nguyễn Tấn Duy',
                        style: AppTextStyles.titleSmall(context),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Text(
                      "Lịch thu gom hôm nay:",
                      style: AppTextStyles.titleSmall(context),
                    ),
                    const Spacer(),
                    Text(
                      formattedDate,
                      style: AppTextStyles.titleSmall(context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(
              () => ReorderableListView(
                onReorder: (oldIndex, newIndex) {
                  homeController.swapItems(oldIndex, newIndex);
                },
                children: List.generate(homeController.tasks.length, (index) {
                  final task = homeController.tasks[index];
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(task.datetime);
                  return Container(
                    key: ValueKey(index),
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              "assets/icons/car_icon.png",
                              width: 30,
                              height: 30,
                            ),
                            const SizedBox(width: 8),
                            Text("Chuyến thu gom",
                                style: AppTextStyles.titleSmall(context)),
                            const Spacer(),
                            Container(
                              alignment: Alignment.center,
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.blue),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              child: Text(task.id,
                                  style: AppTextStyles.titleSmall(context)),
                            ),
                            const Spacer(),
                            Text("CTG_22223",
                                style: AppTextStyles.titleSmall(context)),
                          ],
                        ),
                        const Divider(),
                        _list(context, "Tuyến:", task.route),
                        const SizedBox(height: 8),
                        _list(context, "Loại hàng:", task.cargoType),
                        const SizedBox(height: 8),
                        _list(context, "Ngày gom hàng:", formattedDate),
                        const SizedBox(height: 8),
                        _list(context, "Đơn giá:", "${task.price}"),
                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _list(BuildContext context, String text1, dynamic text2) {
  String formattedText = text1 == "Đơn giá:"
      ? NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
          .format(text2 is num ? text2 : double.tryParse(text2.toString()))
      : text2.toString();

  return Row(
    children: [
      Text(text1,
          style: text1 == "Đơn giá:"
              ? AppTextStyles.titleSmall(context)
              : AppTextStyles.bodyTextMedium(context)),
      const Spacer(),
      Text(formattedText,
          style: text1 == "Đơn giá:"
              ? AppTextStyles.titleSmall(context)
              : AppTextStyles.bodyTextMedium(context)),
    ],
  );
}
