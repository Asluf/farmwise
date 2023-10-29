import 'package:flutter/material.dart';

class NotificationFarmer extends StatefulWidget {
  const NotificationFarmer({Key? key}) : super(key: key);

  @override
  State<NotificationFarmer> createState() => _NotificationFarmerState();
}

class _NotificationFarmerState extends State<NotificationFarmer> {
  @override
  Widget build(BuildContext context) {
    final double wid = MediaQuery.of(context).size.width;
    final double hei = MediaQuery.of(context).size.height;
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
        title: Text("Notifications"),
      ),
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end, // Align to the end (right) side
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle Mark All Notifications button press
                  },
                  child: Text('Mark All Notifications'),
                    style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 5, 46, 2), // Set the specified color
              ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 4,
              separatorBuilder: (BuildContext context, int index) => SizedBox(height: 0), // No space between items
              itemBuilder: (context, index) {
                bool isAccepted = index.isEven;
                return GestureDetector(
                  onTap: () {
                    // Handle the tap on the NotificationCard
                    // For example, print the tapped index
                    print('Tapped index: $index');
                  },
                  child: NotificationCard(
                    profilePhoto: 'assets/progress/a.webp', // Using Transparant.jpg
                    name: 'Ishani  $index', // Replace with names
                    isAccepted: isAccepted,
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
              child: Text('View All Notifications'),
                  style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 5, 46, 2), // Set the specified color
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String profilePhoto;
  final String name;
  final bool isAccepted;

  NotificationCard({
    required this.profilePhoto,
    required this.name,
    required this.isAccepted,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage(profilePhoto),
              radius: 30,
            ),
            SizedBox(width: 20),
            Text(
              name,
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            if (!isAccepted) // Only show buttons if not accepted
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Accept button press
                    },
                    child: Text('Accept'),
                     style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 5, 46, 2), // Set the specified color
              ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Decline button press
                    },
                    child: Text('Decline'),
                    style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 5, 46, 2), // Set the specified color
              ),
                  ),
                ],
              )
            else // Show text if already accepted
              Text('Already Accepted', style: TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}
