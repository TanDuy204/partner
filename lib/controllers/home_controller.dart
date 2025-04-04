import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:partner/models/task_model.dart';

import '../service/uidata.dart';

class HomeController extends GetxController {
  var tasks = <Task>[].obs;
  var startDate = (DateTime.now().subtract(const Duration(days: 2))).obs;
  var selectedDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    filterTaskByDate(DateTime.now());
  }

  ///Hàm cập nhật ngày
  void updateDate(DateTime newDate) {
    selectedDate.value = newDate;
    startDate.value = newDate.subtract(const Duration(days: 2));

    filterTaskByDate(newDate);
  }

  ///Hàm lọc
  void filterTaskByDate(DateTime selectDate) {
    var formattedDay = DateFormat("yyyy/MM/dd").format(selectDate);
    tasks.value = taskList.where((task) {
      return DateFormat('yyyy/MM/dd').format(task.datetime) == formattedDay;
    }).toList();
  }

  ///Hàm sắp xếp
  void swapItems(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    if (oldIndex >= 0 &&
        newIndex >= 0 &&
        oldIndex < tasks.length &&
        newIndex < tasks.length) {
      final Task temp = tasks[oldIndex];
      tasks.removeAt(oldIndex);
      tasks.insert(newIndex, temp);
    }
  }
}
