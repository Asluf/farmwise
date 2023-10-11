import 'package:flutter/material.dart';
import 'dart:async';

class FullScreenImage extends StatefulWidget {
  const FullScreenImage({super.key, required this.imagePath});
  final String imagePath;
  @override
  State<FullScreenImage> createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  bool isTopBarVisible = false;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _hideTopBar() {
    setState(() {
      isTopBarVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.pop(context),
      onTap: () {
        setState(() {
          isTopBarVisible = !isTopBarVisible;
        });

        if (isTopBarVisible) {
          // Cancel any previous timer if it exists
          _timer?.cancel();

          // Start a new timer to hide the top bar after 3 seconds
          _timer = Timer(Duration(seconds: 3), _hideTopBar);
        }
      },

      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            widget.imagePath, // Replace with your image
            fit: BoxFit.contain,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: isTopBarVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: AppBar(
                title: Text('Top Bar'),
                backgroundColor: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
