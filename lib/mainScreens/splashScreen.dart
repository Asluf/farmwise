import 'dart:async';
import 'dart:ui';

import 'package:farmwise/mainScreens/homePage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final splashDuration = 0.75;
  late double _progress;
  double _textOpacity = 1.0; // Initial opacity for the text

  @override
  void initState() {
    super.initState();
    _progress = 0.0;

    Timer.periodic(Duration(milliseconds: (splashDuration * 10).toInt()),
        (timer) {
      if (_progress < 1.0) {
        setState(() {
          _progress += 0.01; // Adjust the increment for desired speed
        });
      } else {
        timer.cancel();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        );
      }
    });

    // Start fading animation for the text
    Timer(Duration(milliseconds: 500), () {
      _startTextFadingAnimation();
    });
  }

  // Fading animation for the text
  void _startTextFadingAnimation() {
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      if (_textOpacity > 0.0) {
        setState(() {
          _textOpacity -= 0.1; // Adjust the decrement for desired fading speed
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        // Blurred background image
        Image.asset(
          'assets/bgLeaves.jpg', // Replace with your background image path
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        // Apply the blur effect only to the background image
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10, sigmaY: 10), // Adjust the blur intensity
            child: Container(
              color: Colors.transparent, // Background color after blur
            ),
          ),
        ),
        // Main content (logo, text, and progress indicator)
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo animation
              // You can use Flutter's built-in animation widgets like AnimatedContainer, TweenAnimationBuilder, etc.
              // Example: AnimatedContainer
              AnimatedContainer(
                duration: Duration(seconds: splashDuration.toInt()),
                width: 100, // Adjust width and height as needed
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/logo.png'), // Path to your logo image
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Fading text
              AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: _textOpacity,
                child: Text('FARMWISE',
                    style: TextStyle(
                      color: Color.fromARGB(255, 231, 235, 230),
                      fontSize: 25,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 20),

              // Center and add padding to the linear progress indicator
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 110), // Adjust padding as needed
                child: LinearProgressIndicator(
                  value: _progress,
                  valueColor: AlwaysStoppedAnimation(const Color.fromARGB(
                      255, 228, 239, 228)), // Customize the color
                  backgroundColor: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
