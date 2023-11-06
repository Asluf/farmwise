import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:farmwise/mainScreens/registerSelection.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import '../services/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _authService = AuthService();

  void loginUser() async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json', // Set the content type
      };
      final Map<String, dynamic> data = {"email": email, "password": password};

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/login'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print('Login successfull');
        print(response.body);
        final Map<String, dynamic> responseBody = json.decode(response.body);
        final String token = responseBody['data']['token'];
        final String role = responseBody['data']['role'];
        // saving the token
        await _authService.saveToken(token);
        await _authService.saveRole(role);
        if (role == "farmer") {
          _showLoginConfirm();
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/farmerDash', (route) => false);
          });
        } else if (role == "investor") {
          _showLoginConfirm();
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/investorDash', (route) => false);
          });
        } else if (role == "buyer") {
          _showLoginConfirm();
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/buyerDash', (route) => false);
          });
        }
      } else {
        // Request failed
        print('Failed to send POST request');
        _showLoginError();
      }
    } catch (er) {
      print(er);
    }
  }

  void _showLoginConfirm() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Login",
      text: 'Successfull!',
    );
  }

  void _showLoginError() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Oops!",
      text: 'Incorrect username or password',
      confirmBtnText: 'Try again',
      confirmBtnColor: Color.fromARGB(255, 67, 78, 68),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email;
  String? password;

  Widget _buildEmailField() {
    return TextFormField(
      maxLength: 20,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter a valid email";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Username',
        labelStyle: TextStyle(
            color: Color.fromARGB(157, 3, 54, 29), fontWeight: FontWeight.bold),
        hintText: 'Enter username',
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
      onSaved: (text) {
        email = text;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      maxLength: 10,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter a password";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Password',
        labelStyle: TextStyle(
            color: Color.fromARGB(157, 3, 54, 29), fontWeight: FontWeight.bold),
        hintText: 'Enter your password',
        prefixIcon: Icon(
          Icons.key,
          color: Colors.grey,
        ),
      ),
      onSaved: (value) {
        password = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double wid = MediaQuery.of(context).size.width;
    double hei = MediaQuery.of(context).size.height;
    var grey;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(
            color: const Color.fromARGB(255, 192, 226, 190),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            // Navigator.pop(context, Placeholder());
            Navigator.pushNamed(context, '/');
          },
          icon: const Icon(
            Icons.home,
            color: const Color.fromARGB(255, 192, 226, 190),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("bgAppbar.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
              child: Stack(
            children: [
              Image.asset(
                "assets/bg.png",
              ),
              BackdropFilter(
                child: Container(
                  color: Colors.black.withOpacity(0.1),
                ),
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              ),
              Container(
                child: const Center(
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Icon(
                        Icons.lock,
                        size: 40,
                      ),
                      SizedBox(height: 32),
                      Text(
                        "Welcome Back !",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 50),
                      // const SizedBox(height: 100),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 100, 8, 8),
                        child: _buildEmailField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildPasswordField(),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('valid form');
                              _formKey.currentState!.save();
                              loginUser();
                            } else {
                              print('not valid form');
                              return;
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 192, 226, 190)),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 4, 4),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/forgot', (route) => false);
                              },
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16),
                              ))
                          // Text(
                          //   "Forgot Password ?",
                          //   style: TextStyle(
                          //       color: Colors.grey,
                          //       fontWeight: FontWeight.w300,
                          //       fontSize: 16),
                          // ),
                        ],
                      ),

                      SizedBox(height: 35),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 0.5,
                                color: Colors.grey[400],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text(
                                "or",
                                style: TextStyle(
                                    color: Colors.grey[400], fontSize: 16),
                              ),
                            ),
                            Expanded(
                                child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ))
                          ],
                        ),
                      ),
                      SizedBox(height: 35),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        width: 250,
                        child: ElevatedButton(
                          child: const Text(
                            'Create New Account',
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 4, 4),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) {
                              return registerSelection();
                            }));
                          },
                          style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromARGB(255, 192, 226, 190)),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                            padding: MaterialStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 52)),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Text("Not a member ?"),
                      //     const SizedBox(width: 4),
                      //     Text("Register Now")
                      //   ],
                      // ),
                      SizedBox(
                        width: wid,
                        height: hei / 2,
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }
}
