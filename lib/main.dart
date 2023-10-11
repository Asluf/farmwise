import 'package:device_preview/device_preview.dart';
import 'package:farmwise/buyerScreens/buyerDashboard.dart';
import 'package:farmwise/buyerScreens/buyerOrder.dart';
import 'package:farmwise/buyerScreens/buyerProfile.dart';
import 'package:farmwise/buyerScreens/buyerProfileEdit.dart';
import 'package:farmwise/farmerScreens/FarmerProfile.dart';
import 'package:farmwise/farmerScreens/FarmerProfileEdit.dart';
import 'package:farmwise/farmerScreens/farmerDashboard.dart';
import 'package:farmwise/investorScreens/dashboardInvestor.dart';
import 'package:farmwise/investorScreens/widgets/fullScreenImage.dart';

//import 'package:farmwise/farmerScreens/FarmerProfile.dart';

import 'package:farmwise/mainScreens/homePage.dart';
//import 'package:farmwise/mainScreens/info.dart';
//import 'package:farmwise/mainScreens/more.dart';
//import 'package:farmwise/mainScreens/login.dart';
//import 'package:farmwise/mainScreens/registerBuyer.dart';
//import 'package:farmwise/mainScreens/registerFarmer.dart';
//import 'package:farmwise/mainScreens/registerInvestor.dart';
//import 'package:farmwise/mainScreens/registerSelection.dart';

import 'package:flutter/material.dart';
//import 'mainScreens/registerFarmer.dart';

void main() {
  runApp(
    DevicePreview(
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

// RGB value for green: 0xRRGGBB

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Color customGreenColor = Colors.green.shade700;
    //final Color accentColor = Color.fromRGBO(255, 165, 0, 1.0);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: customGreenColor,
        //primaryColor: Color.fromRGBO(0, 128, 0, 1.0),
        //accentColor: accentColor,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color.fromARGB(
              255, 5, 46, 2), // Set the selected item color to green
        ),
      ),
      //home: const Homepage(),

      //home: const farmerDashboard(),
      home: const buyerDashboard(),
      // home: const FullScreenImage(imagePath: 'assets/bg.png'),
      //home: const DashboardInvestor(),
    );
  }
}
