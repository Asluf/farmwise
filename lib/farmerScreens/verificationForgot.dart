import 'package:flutter/material.dart';

class VerificationForgot extends StatefulWidget {
  const VerificationForgot({Key? key}) : super(key: key);

  @override
  State<VerificationForgot> createState() => _VerificationForgotState();
}

class _VerificationForgotState extends State<VerificationForgot> {
  final TextEditingController _verificationCodeController = TextEditingController();

  void _sendResetLink() {
    // Perform sending reset link functionality here
    String verificationCode = _verificationCodeController.text;
    // You can add your logic to handle the verification code entered
    print('Verification code entered: $verificationCode');
    // Add logic to validate the verification code or perform further actions
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
        title: const Text("Verification"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: EdgeInsets.fromLTRB(0, hei / 6, 0, 0),
          child: Column(
            children: <Widget>[
              Text(
                'Enter Verification Code', // Updated text
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _verificationCodeController,
                decoration: InputDecoration(
                  labelText: 'Enter verification code', // Updated placeholder
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                keyboardType: TextInputType.number, // Set keyboard type to number for verification code
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Add logic to navigate back to the sign-in screen
                  print('Navigate back to Sign In');
                },
                child: const Text(
                  'If you didn\'t receive a code. Resend',
                  style: TextStyle(
                    color: Color.fromARGB(255, 5, 46, 2),
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _sendResetLink,
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
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: VerificationForgot(),
  ));
}
