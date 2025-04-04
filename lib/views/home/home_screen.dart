import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partner/common/styles.dart';
import 'package:partner/controllers/home_controller.dart';
import 'package:partner/models/person_model.dart';
import 'package:partner/routes/app_route.dart';
import 'package:partner/service/uidata.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());
  final List<PersonModel> personList;
  HomeScreen({super.key, required this.personList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Xin chào bác tài',
              style: AppTextStyles.bodyTextSmall(context),
            ),
            Text(
              personList[0].name,
              style: AppTextStyles.bodyTextLarge(context),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: AppColors.blueColor.withOpacity(0.16),
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_outlined,
                color: AppColors.blueColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xFFFEF7FF),
          padding: const EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    personList[0].licensePlate,
                    style: AppTextStyles.titleLarge(context),
                  ),
                  const Spacer(),
                  Text(
                    personList[0].msx,
                    style: AppTextStyles.titleLarge(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Tiện ích của bác tài",
                  style: AppTextStyles.bodyTextLarge(context)),
              const SizedBox(height: 15),
              GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                mainAxisSpacing: 17,
                crossAxisSpacing: 17,
                childAspectRatio: 1,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildMenuItem(
                      context,
                      AppColors.lightPurple.withOpacity(0.3),
                      AppColors.darkPurple.withOpacity(0.4),
                      Icons.calendar_today,
                      "Lịch thu gom",
                      "Tổng hợp các lịch thu gom của bác tài", () {
                    Get.toNamed(AppRoutes.collectSchedule, arguments: taskList);
                  }),
                  _buildMenuItem(
                      context,
                      AppColors.lightGreen.withOpacity(0.45),
                      AppColors.limeGreen.withOpacity(0.35),
                      Icons.bar_chart,
                      "Thống kê",
                      "Thống kê các chỉ số hoạt động của bác tài",
                      () {}),
                  _buildMenuItem(
                      context,
                      AppColors.softGreen1.withOpacity(0.5),
                      AppColors.softGreen2.withOpacity(0.5),
                      Icons.help_outline,
                      "Hỗ trợ",
                      "Hãy liên hệ với chúng tôi khi cần bác tài nhé",
                      () {}),
                  _buildMenuItem(
                      context,
                      AppColors.brightYellow.withOpacity(0.3),
                      AppColors.brightOrange.withOpacity(0.3),
                      Icons.history,
                      "Lịch sử",
                      "Tổng hợp lịch sử thu gom của bác tài",
                      () {}),
                ],
              ),
              const SizedBox(height: 10),
              Text("Lịch gom nổi bật",
                  style: AppTextStyles.bodyTextLarge(context)),
              const SizedBox(height: 10),

              /// Lịch
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        final startDate = homeController.startDate.value;
                        final selectedDate = homeController.selectedDate.value;
                        return DatePicker(
                          height: 90,
                          width: 80,
                          startDate,
                          locale: "vi_VN",
                          daysCount: 7,
                          initialSelectedDate: selectedDate,
                          selectionColor:
                              AppColors.lightBlueColor.withOpacity(0.16),
                          selectedTextColor: AppColors.redColor,
                          onDateChange: (date) {
                            homeController.updateDate(date);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text('Chuyến thu gom hôm nay',
                          style: AppTextStyles.titleSmall(context)),
                    ),

                    /// Lịch chuyến thu gom
                    Obx(
                      () {
                        if (homeController.tasks.isEmpty) {
                          return const SizedBox(
                            height: 100,
                            child: Center(
                              child: Text("Không có ghi chú"),
                            ),
                          );
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeController.tasks.length,
                          itemBuilder: (context, index) {
                            final task = homeController.tasks[index];

                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 10, top: 10, bottom: 20),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                        DateFormat.Hm().format(task.datetime),
                                        style: AppTextStyles.bodyTextSmall(
                                            context)),
                                  ),
                                  const SizedBox(width: 40),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF007AFF)
                                            .withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(task.title,
                                          style: AppTextStyles.bodyTextMedium(
                                              context)),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text("Ghi chú quan trọng",
                  style: AppTextStyles.titleMedium(context)),
              Text("Đừng quên mình có ghi chú quan trọng nhé bác tài",
                  style: AppTextStyles.bodyTextSmall(context)),
              const SizedBox(height: 10),

              /// Ghi chú thu gom
              Obx(
                () {
                  if (homeController.tasks.isEmpty) {
                    return const SizedBox(
                      height: 100,
                      child: Center(
                        child: Text("Không có ghi chú"),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: homeController.tasks.length,
                    itemBuilder: (context, index) {
                      final task = homeController.tasks[index];
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF8572FF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.calendar_today,
                                    color: Colors.white, size: 32),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title,
                                      style:
                                          AppTextStyles.bodyTextLarge(context),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      task.description,
                                      style:
                                          AppTextStyles.bodyTextMedium(context),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        const Icon(Icons.access_time,
                                            size: 18, color: Colors.white),
                                        const SizedBox(width: 6),
                                        Text(
                                          DateFormat.Hm().format(task.datetime),
                                          style: AppTextStyles.bodyTextMedium(
                                              context),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildMenuItem(BuildContext context, Color color1, Color color2,
    IconData icon, String title, String subTitle, VoidCallback onTap) {
  {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [color1, color2],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon,
                size: MediaQuery.of(context).size.width < 376 ? 25 : 37,
                color: Colors.black),
            const SizedBox(height: 10),
            Text(title, style: AppTextStyles.titleMedium(context)),
            const SizedBox(height: 10),
            Text(subTitle, style: AppTextStyles.bodyTextMedium(context)),
          ],
        ),
      ),
    );
  }
}
