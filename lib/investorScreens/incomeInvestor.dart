import 'package:flutter/material.dart';

class incomeInvestor extends StatefulWidget {
  const incomeInvestor({Key? key}) : super(key: key);

  @override
  State<incomeInvestor> createState() => _incomeInvestorState();
}

class _incomeInvestorState extends State<incomeInvestor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {                    
                    print('Tapped index: $index');
                  },
                  child: NotificationCard(
                    invid: '000 $index',
                    total: 15000,
                    ROI: 15,                    
                    expecIncome: 5000, 
                    onPressed: () {                      
                      print('Button in notification $index pressed.');
                    },
                  ),
                );
              },
            ),
          ),
          
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String invid;
  final double total;
  final double ROI;
  final double expecIncome;
  final VoidCallback onPressed;

  const NotificationCard({
    Key? key,
    required this.invid,
    required this.total,
    required this.ROI,
    required this.expecIncome,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text("Investment id: ",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                      ),
                      ),
                      
                      Text(invid)
                    ],
                  ),
                  Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Investment Amount : " ,
                       style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                      ),
                         Text(total.toString(),
                           style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),)
                      
                     
                    ],
                  ),
                    Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(" ROI % : " ,
                        style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),), 
                      Text(ROI.toString()+"%")
                    ],
                  ),
                    Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Expected Income: " ,
                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),),
                Text(expecIncome.toString() ,
                  style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),),
              ],
            ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
