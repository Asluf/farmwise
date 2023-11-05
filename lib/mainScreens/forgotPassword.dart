import 'package:farmwise/farmerScreens/verificationForgot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailController = TextEditingController();

  void _sendResetLink() {
    // Perform sending reset link functionality here
    String email = _emailController.text;
    // You can add your logic to send the reset link using the entered email
    print('Reset link sent to $email');
  }

  @override
  Widget build(BuildContext context) {
        final double wid = MediaQuery.of(context).size.width;
    final double hei = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("bgAppbar.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, hei/6, 0, 0),
          child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter Email Address',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Small space after text
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'example@gmail.com',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0), // Set border radius for TextField
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            
            SizedBox(height: 10), // Small space after the Send button
            TextButton(
              onPressed: () {
                // Add logic to navigate back to the sign-in screen
                print('Navigate back to Sign In');
              },
              child: const Text('Back to Sign In', 
               style: TextStyle(
                  color: const Color.fromARGB(255, 5, 46, 2),
              ),)
            ),
            SizedBox(height: 10), // Small space after text field
          ElevatedButton(
  onPressed: () {
    _sendResetLink(); // Send the reset link

    // Navigate to the Verification page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => VerificationForgot()), // Replace 'VerificationForgot' with the actual Verification page class
    );
  },
  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 5, 46, 2)),
    elevation: MaterialStateProperty.all(4),
    minimumSize: MaterialStateProperty.all(Size(wid - 120, 60)),
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 70)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    ),
  ),
  child: const Text(
    "Send",
    style: TextStyle(color: Colors.white, fontSize: 22),
  ),
),

          ],
        ),
        )
      ),
    );
  }
}
