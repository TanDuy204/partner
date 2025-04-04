import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partner/common/styles.dart';
import 'package:partner/controllers/home_controller.dart';
import 'package:partner/models/task_model.dart';
import 'package:partner/routes/app_route.dart';

class CollectionScheduleScreen extends StatelessWidget {
  const CollectionScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Task> taskList = Get.arguments;
    final HomeController homeController = Get.find();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Sắp lịch gom",
          style: AppTextStyles.titleMedium(context),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            color: AppColors.lightBlueColor,
            height: 50,
            child: Row(
              children: [
                Image.asset(
                  "assets/icons/info_icon.png",
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 15),
                const Text("Danh sách lịch gom chưa sắp trong ngày")
              ],
            ),
          ),
          Expanded(
              child: Obx(
            () => ListView.builder(
                itemCount: homeController.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskList[index];
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(task.datetime);
                  return Container(
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
                            Text("CTG_22223",
                                style: AppTextStyles.titleSmall(context)),
                          ],
                        ),
                        const Divider(),
                        _list(context, "Tuyến:", task.route, task),
                        const SizedBox(height: 8),
                        _list(context, "Loại hàng:", task.cargoType, task),
                        const SizedBox(height: 8),
                        _list(context, "Ngày gom hàng:", formattedDate, task),
                        const SizedBox(height: 8),
                        _list(context, "Đơn giá:", "${task.price}", task),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Color(0xFF79747E),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text("Chi tiết",
                                    style:
                                        AppTextStyles.bodyTextSmall(context)),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              flex: 2,
                              child: OutlinedButton(
                                onPressed: () {
                                  Get.toNamed(AppRoutes.tripSchedule,
                                      arguments: taskList);
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: AppColors.blueColor,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Text("Sắp lịch",
                                    style: AppTextStyles.titleMedium(context)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                      ],
                    ),
                  );
                }),
          )),
        ],
      ),
    );
  }
}

Widget _list(BuildContext context, String text1, dynamic text2, Task task) {
  String formattedText = text1 == "Đơn giá:"
      ? NumberFormat.currency(locale: 'vi_VN', symbol: '₫')
          .format(text2 is num ? text2 : double.tryParse(text2.toString()))
      : text2.toString();

  return Row(
    children: [
      Text(
        text1,
        style: text1 == "Đơn giá:"
            ? AppTextStyles.titleSmall(context)
            : AppTextStyles.bodyTextMedium(context),
      ),
      const Spacer(),
      Text(
        formattedText,
        style: text1 == "Đơn giá:"
            ? AppTextStyles.titleSmall(context)
            : AppTextStyles.bodyTextMedium(context),
      ),
    ],
  );
}
