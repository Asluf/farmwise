import 'package:flutter/material.dart';

class subscriptionPage extends StatefulWidget {
  const subscriptionPage({super.key});

  @override
  State<subscriptionPage> createState() => _subscriptionPageState();
}

class _subscriptionPageState extends State<subscriptionPage> {
  
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
                    fontFamily: 'Montserrat'),
          ),
          leading: IconButton(
            onPressed: () {              
            },
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
                      borderRadius: BorderRadiusDirectional.circular(5),
                      side: BorderSide(
                        width: 0.2,
                        color: Colors.black,
                      ),
                    ),                               
                  child: Column(
                    children: [
                      Padding( 
                        padding:EdgeInsets.only(top: 8),
                        child: Text(
                          'Basic',
                          style: TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold,
                          ),),
                      ),
                      
                      GestureDetector(
                        onTap: () {},                             
                        child: Icon(Icons.credit_card),
                      ),
                      Text('\$19 per month',
                      style: TextStyle(
                        
                      ),),
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
                      borderRadius: BorderRadiusDirectional.circular(5),
                      side: BorderSide(
                        width: 0.2,
                        color: Colors.black,
                      ),
                    ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top:8),
                      child: Text(
                        'Pro',
                        style: TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold,
                        ),),),
                      Icon(Icons.credit_card),
                      Text('\$29 per month'),                      
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
                      borderRadius: BorderRadiusDirectional.circular(5),
                      side: BorderSide(
                        width: 0.2,
                        color: Colors.black,
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Premium',
                            style: TextStyle(
                            fontSize: 24, 
                            fontWeight: FontWeight.bold,
                            ),),
                        ),
                          Icon(Icons.credit_card),
                          Text('\$49 per month'),                        
                      ],
                    ),                    
                  ),
                ),
                
                  
                
        ],
          ),
        
    ),
        
    );
        
    
  }
}