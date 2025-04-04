import 'package:get/get.dart';
import 'package:partner/views/entrypoint.dart';
import 'package:partner/views/home/collection_schedule_screen.dart';
import 'package:partner/views/home/trip_schedule_screen.dart';

class AppRoutes {
  static const String main = '/main';
  static const String collectSchedule = '/collectSchedule';
  static const String tripSchedule = '/tripSchedule';

  static final pages = [
    GetPage(name: main, page: () => const MainScreen()),
    GetPage(
        name: collectSchedule,
        page: () => const CollectionScheduleScreen(),
        transition: Transition.fadeIn),
    GetPage(
        name: tripSchedule,
        page: () => TripScheduleScreen(),
        transition: Transition.fadeIn),
  ];
}
