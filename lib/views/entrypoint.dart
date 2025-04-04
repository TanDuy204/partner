import 'package:flutter/material.dart';
import 'package:partner/views/home/home_screen.dart';
import 'package:partner/views/person/person_screen.dart';
import 'package:partner/views/time/time_screen.dart';

import '../service/uidata.dart';
import 'map/map_screen.dart';
import 'notification/notification_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(
      personList: personList,
    ),
    MapScreen(
      destinations: destinationList,
    ),
    const TimeScreen(),
    const NotificationScreen(),
    const PersonScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 80,
        child: Stack(
          children: [
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width, 80),
              painter: BNBCustomPainter(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.calendar_today, "Bản đồ", 1),
                  _buildNavItem(Icons.timer_outlined, "Thời gian", 2),
                  Container(width: 50),
                  _buildNavItem(
                      Icons.notifications_none_outlined, "Thông báo", 3),
                  _buildNavItem(Icons.person_outline, "Cá nhân", 4),
                ],
              ),
            ),
            Center(
              heightFactor: 0.8,
              child: FloatingActionButton(
                onPressed: () => _onItemTapped(0),
                backgroundColor: const Color(0xFF3E9AFE).withOpacity(0.47),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                elevation: 0,
                child: const Icon(
                  Icons.home_outlined,
                  size: 35,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color:
                _currentIndex == index ? Colors.blue : const Color(0xFF787486),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: _currentIndex == index
                  ? Colors.blue
                  : const Color(0xFF787486),
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.circular(10.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black.withOpacity(0.7), 30, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
