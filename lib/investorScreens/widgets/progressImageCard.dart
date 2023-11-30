import 'package:farmwise/investorScreens/models/progressImage.dart';
import 'package:farmwise/investorScreens/widgets/fullScreenImage.dart';
import 'package:flutter/material.dart';

class ProgressImageCard extends StatefulWidget {
  const ProgressImageCard(
      {super.key,
      required this.progressImagePath,
      required this.progressImageDate,
      required this.cultivation_id,
      required this.index});

  final String progressImagePath;
  final String progressImageDate;
  final String cultivation_id;
  final int index;

  @override
  State<ProgressImageCard> createState() => _ProgressImageCardState();
}

class _ProgressImageCardState extends State<ProgressImageCard> {
  void _openFullScreenImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FullScreenImage(imagePath: widget.progressImagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.progressImageDate);
    String formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FullScreenImage(imagePath: widget.progressImagePath),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias, //clip the edges
        elevation: 0.1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            width: 0.2,
            color: Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // image
            Container(
              height: 100,
              alignment: Alignment.topRight,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: NetworkImage((widget.progressImagePath != '')
                    ? 'http://localhost:5005/${widget.progressImagePath}' ??
                        'http://localhost:5005/uploads/progressImages/no.png'
                    : 'http://localhost:5005/uploads/progressImages/no.png'),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                children: [
                  Text(
                    "$formattedDate",
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
