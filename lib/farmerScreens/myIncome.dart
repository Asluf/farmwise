import 'package:flutter/material.dart';

class myIncome extends StatefulWidget {
  const myIncome({Key? key}) : super(key: key);

  @override
  State<myIncome> createState() => _myIncomeState();
}

class _myIncomeState extends State<myIncome> {
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
                    // Handle the tap on the NotificationCard
                    // For example, print the tapped index
                    print('Tapped index: $index');
                  },
                  child: IncomeCard(
                    invid: '000 $index',
                    total: 150000,
                    my: 30000,
                    ROI: 15,
                    
                    // Replace 'Date' with the actual date
                    expecIncome: 5000, // Replace 'Time' with the actual time
                    onPressed: () {
                      // Handle individual notification button press
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

class IncomeCard extends StatelessWidget {
  final String invid;
  final double total;
  final double my;
  final double ROI;
  final double expecIncome;
  final VoidCallback onPressed;

  const IncomeCard({
    Key? key,
    required this.invid,
    required this.total,
    required this.my,
    required this.ROI,
    required this.expecIncome,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //  margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5),
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
                      Text(
                        "Investment id: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Text(invid)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Investment Amount : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        total.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Investment : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        my.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ROI  : ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(ROI.toString() + "%")
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Expected Income: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        expecIncome.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
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
