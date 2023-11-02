import 'dart:ui';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quickalert/quickalert.dart';
//import 'package:image_picker/image_picker.dart';

import 'package:flutter/material.dart';

class registerInvestor extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<registerInvestor> {
  void sendInvestor() async {
    try {
      final Map<String, String> headers = {
        'Content-Type': 'application/json', // Set the content type
      };
      final Map<String, dynamic> data = {
        "investor_name": name,
        "nic": nic,
        "address": address,
        "mobile": mobile,
        "email": email,
        "province": "Eastern",
        "district": "Trinco",
        "city": "kinniya",
        "password": originalPassword,
        "profile_pic": ""
      };

      final response = await http.post(
        Uri.parse('http://localhost:5005/api/registerInvestor'),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Request was successful
        print('Investor registerred successfully');
        print(response.body);
        // call to alert fn
        _showRegistrationConfirm();
      } else {
        // Request failed
        print('Failed to send POST request');
        _showRegistrationError();
      }
    } catch (er) {
      print(er);
    }
  }

  void _showRegistrationConfirm() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: "Registration",
      text: 'Successfull!',
      confirmBtnText: 'Continue',
      confirmBtnColor: Color.fromARGB(255, 101, 145, 103),
      onConfirmBtnTap: () async {
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      },
    );
  }

  void _showRegistrationError() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: "Oops!",
      text: 'Sorry, something went wrong',
      confirmBtnText: 'Try again',
      confirmBtnColor: Color.fromARGB(255, 67, 78, 68),
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? name;
  String? nic;
  String? address;
  int? mobile;
  String? email;
  String? originalPassword;
  String? repassword;

  Widget _buildNameField() {
    return TextFormField(
      validator: (text) {
        if (text!.isEmpty) {
          return "Name can't be empty";
        }
        if (text.length < 2) {
          return "Name must be at least 2 characters long";
        }
        return null;
        //return HelperValidator.nameValidate('text');
      },
      maxLength: 20,
      maxLines: 1,
      decoration: const InputDecoration(
        labelText: 'Name',
        hintText: 'Enter your full name',
        prefixIcon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
      ),
      onSaved: (text) {
        name = text;
      },
    );
  }

  Widget _buildNICField() {
    return TextFormField(
      validator: (text) {
        if (text!.isEmpty) {
          return "NIC can't be empty";
        }
        return null;
        //return HelperValidator.nameValidate('text');
      },
      maxLength: 20,
      maxLines: 1,
      decoration: const InputDecoration(
        labelText: 'NIC',
        hintText: 'Enter your NIC',
        prefixIcon: Icon(
          Icons.add_card,
          color: Colors.grey,
        ),
      ),
      onSaved: (text) {
        nic = text;
      },
    );
  }

  Widget _buildAddressField() {
    return TextFormField(
      maxLength: 100,
      validator: (text) {
        if (text!.isEmpty) {
          return "Address cannot be empty";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Address',
        hintText: 'Enter your /  -=]address',
        prefixIcon: Icon(
          Icons.home,
          color: Colors.grey,
        ),
      ),
      onSaved: (text) {
        address = text;
      },
    );
  }

  Widget _buildMobileNumberField() {
    return TextFormField(
        maxLength: 10,
        keyboardType: TextInputType.number,
        validator: (text) {
          if (text!.isEmpty) {
            return "Please enter a mobile Number";
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: 'Mobile Number',
          hintText: 'Enter a mobile number',
          prefixIcon: Icon(
            Icons.phone,
            color: Colors.grey,
          ),
        ),
        onSaved: (value) {
          if (value != null && int.tryParse(value) != null) {
            mobile = int.parse(value);
          } else {
            // Handle invalid input
          }
        });
  }

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
        labelText: 'Email',
        hintText: 'Enter your email',
        prefixIcon: Icon(
          Icons.email,
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
        hintText: 'Enter your password',
        prefixIcon: Icon(
          Icons.key,
          color: Colors.grey,
        ),
      ),
      onSaved: (value) {
        originalPassword = value;
      },
      onChanged: (value) {
        originalPassword = value;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      obscureText: true,
      maxLength: 10,
      validator: (text) {
        if (text!.isEmpty) {
          return "Please enter a password";
        } else if (text != originalPassword) {
          return "Password is not matching";
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Re-enter your password',
        prefixIcon: Icon(
          Icons.key_sharp,
          color: Colors.grey,
        ),
      ),
      onSaved: (value) {
        repassword = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register as an Investor',style: TextStyle(color: Color.fromARGB(255, 192, 226, 190)),),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context, Placeholder());
            },
            icon: const Icon(Icons.arrow_back,color: Color.fromARGB(255, 192, 226, 190)),
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
        body: Container(
          child: SingleChildScrollView(
              child: Stack(
            children: [
              Image.asset("assets/bg.png"),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                    //color: Colors.black.withOpacity(0.1),
                    ),
              ),
              // Title(
              //   color: Colors.black,
              //   child: const Text("Personal Information"),
              // ),
              Container(
                margin: const EdgeInsets.all(24.0),
                // decoration: BoxDecoration(
                //   color: Colors.transparent,
                //   border: Border.all(
                //     color: Colors.black, // Border color
                //     width: 0.5, // Border width
                //   ),
                //   borderRadius: BorderRadius.circular(10.0), // Border radius
                // ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // const Text(
                      //   'Personal Information',
                      //   style: TextStyle(
                      //     fontSize: 20.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildNameField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildNICField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildAddressField(),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildMobileNumberField(),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildEmailField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildPasswordField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildConfirmPasswordField(),
                      ),

                      // const Text(
                      //   'Cultivation Information',
                      //   style: TextStyle(
                      //     fontSize: 20.0,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      const SizedBox(height: 50),
                      Container(
                        width: 150,
                        child: ElevatedButton(
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                              color: Color.fromARGB(255, 18, 17, 18),
                              fontSize: 16.0,
                            ),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              print('valid form');
                              _formKey.currentState!.save();
                              sendInvestor();
                            } else {
                              print('not valid form');
                              return;
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Color.fromARGB(255, 192, 226, 190)),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            )),
                          ),
                        ),
                      ),
                      SizedBox(height: 25)
                    ],
                  ),
                ),
              ),
            ],
          )),
        )
        // bottomNavigationBar: BottomNavigationBar(
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.message),
        //       label: 'Messages',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.person),
        //       label: 'Profile',
        //     ),
        //   ],
        // ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        //       return Fifthpage();
        //     }));
        //   },
        //   child: const Icon(Icons.add),
        // ),
        );
  }
}
