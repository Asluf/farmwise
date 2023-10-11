import 'package:farmwise/investorScreens/models/progressImage.dart';
import 'package:farmwise/investorScreens/widgets/fullScreenImage.dart';
import 'package:flutter/material.dart';

class ProgressImageCard extends StatefulWidget {
  const ProgressImageCard({super.key, required this.progressImageList});

  final ProgressImage progressImageList;

  @override
  State<ProgressImageCard> createState() => _ProgressImageCardState();
}

class _ProgressImageCardState extends State<ProgressImageCard> {
  void _openFullScreenImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FullScreenImage(imagePath: widget.progressImageList.imagePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => FullScreenImage(
                  imagePath: widget.progressImageList.imagePath)),
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
                image: AssetImage(widget.progressImageList.imagePath),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                children: [
                  Text(
                    "${widget.progressImageList.postedDate}",
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
