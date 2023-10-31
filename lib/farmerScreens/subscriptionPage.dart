import 'package:flutter/material.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("bgAppbar.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          'Pricing',
          style: TextStyle(
            color: const Color.fromARGB(255, 192, 226, 190),
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: 'Montserrat',
          ),
        ),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Choose a payment plan that works for you',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 150,
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    width: 0.2,
                    color: Colors.black,
                  ),
                ),               

                child: Stack(                 
                  children: [                                       
                    Container(
                      padding: EdgeInsets.all(16),                                  
                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,                                                                             
                            children: [
                              Text(
                                'Basic',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), 
                                Icon(Icons.credit_card),
                                Text('\$19 per month'),
                            ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios), 
                            onPressed: () {
                              showPopupDialog(context); // Call the function to show the popup
                            },
                      ), 
                    ),                      
                  ],
                ),                 
              ),
            ),
            
            
            SizedBox(height: 20),
            Container(
              height: 150,
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    width: 0.2,
                    color: Colors.black,
                  ),
                ),
                child: Stack(                 
                  children: [                                       
                    Container(
                      padding: EdgeInsets.all(16),                                  
                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,                                                                             
                            children: [
                              Text(
                                'Pro',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), 
                                Icon(Icons.credit_card),
                                Text('\$29 per month'),
                            ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios), 
                            onPressed: () {
                              showPopupDialog(context); // Call the function to show the popup
                            },
                      ), 
                    ),                      
                  ],
                ),
              ),
            ),
            
            SizedBox(height: 20),
            Container(
              height: 150,
              width: 300,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                  side: BorderSide(
                    width: 0.2,
                    color: Colors.black,
                  ),
                ),

                child: Stack(                 
                  children: [                                       
                    Container(
                      padding: EdgeInsets.all(16),                                  
                      child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,                                                                             
                            children: [
                              Text(
                                'Premium',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ), 
                                Icon(Icons.credit_card),
                                Text('\$49 per month'),
                            ],
                      ),
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios), 
                            onPressed: () {
                              showPopupDialog(context); // Call the function to show the popup
                            },
                      ), 
                    ),                      
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showPopupDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Popup Title'),
        content: Container(
          width: 400, 
          height: 300, 
          child: Column(
            children: [
              Text('This is the content of the popup dialog.'),              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); 
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}

}
