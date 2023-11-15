import 'package:flutter/material.dart';

class NotificationFarmer extends StatefulWidget {
  const NotificationFarmer({Key? key}) : super(key: key);

  @override
  State<NotificationFarmer> createState() => _NotificationFarmerState();
}

class _NotificationFarmerState extends State<NotificationFarmer> {
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
        title: const Text("Notifications"),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Mark All Notifications button press
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 46, 2),
                  ),
                  child: const Text('Mark All Notifications'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                bool isAccepted = index.isEven;
                return GestureDetector(
                  onTap: () {
                    // Handle the tap on the NotificationCard
                    // For example, print the tapped index
                    print('Tapped index: $index');
                  },
                  child: NotificationCard(
                    name: 'Ishani $index',
                    isAccepted: isAccepted,
                    date: 'Date',
                    // Replace 'Date' with the actual date
                    time: 'Time', // Replace 'Time' with the actual time
                    onPressed: () {
                      // Handle individual notification button press
                      print('Button in notification $index pressed.');
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                // Handle View All Notifications button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 5, 46, 2),
              ),
              child: const Text('View All Notifications'),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String name;
  final bool isAccepted;
  final String date;
  final String time;
  final VoidCallback onPressed;

  const NotificationCard({
    Key? key,
    required this.name,
    required this.isAccepted,
    required this.date,
    required this.time,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // margin: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.notifications, // Use the notifications icon
              size: 30,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                    
                      Text(
                        'Description',
                        style: const TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Spacer(),
                      Text(
                        'Date: $date, Time: $time',
                        style: const TextStyle(fontSize: 14),
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
