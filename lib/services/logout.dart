import 'package:farmwise/mainScreens/homePage.dart';
import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  final AuthService _authService = AuthService();
  void hello() async {
    await _authService.saveToken('none');
    await _authService.saveRole('none');
    await _authService.saveEmail('none');
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    hello();
    return const Scaffold();
  }
}
