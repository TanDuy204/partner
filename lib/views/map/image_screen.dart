import 'dart:io';

import 'package:flutter/material.dart';

class ImageScreen extends StatefulWidget {
  final List<String> imagePaths;
  final Function(int) onDeleteImages;

  const ImageScreen(
      {super.key, required this.imagePaths, required this.onDeleteImages});

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Xem ảnh"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                widget.onDeleteImages(_currentPage);
                Navigator.pop(context);
              },
              child: const Icon(Icons.delete),
            ),
          ),
        ],
      ),
      body: Center(
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.imagePaths.length,
          itemBuilder: (context, index) {
            String imagePath = widget.imagePaths[index];
            return Center(
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            );
          },
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
        ),
      ),
    );
  }
}
