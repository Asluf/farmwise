import 'dart:ui';

import 'package:farmwise/mainScreens/homePage.dart';
import 'package:farmwise/mainScreens/registerSelection.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, Placeholder());
          },
          icon: const Icon(Icons.arrow_back),
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
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color.fromARGB(255, 4, 4, 4),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('Valid form');
                              _formKey.currentState!.save();
                            } else {
                              print('not Valid form');
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
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Forgot Password ?",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300,
                                fontSize: 16),
                          ),
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
