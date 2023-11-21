// import 'package:farmwise/farmerScreens/models/progressImage.dart';
import 'package:farmwise/farmerScreens/widgets/fullScreenImage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../services/auth_services.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:quickalert/quickalert.dart';
import 'dart:typed_data';
import 'dart:convert';

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
  final AuthService _authService = AuthService();
  String token = '';

  Future<void> _openGallery() async {
    token = await _authService.getToken();
    try {
      if (kIsWeb) {
        Uint8List? imageBytes = await ImagePickerWeb.getImageAsBytes();

        if (imageBytes != null) {
          var request = http.MultipartRequest(
            'POST',
            Uri.parse('http://localhost:5005/api/uploadProgress'),
          );
          request.files.add(
            http.MultipartFile.fromBytes(
              'image',
              imageBytes.toList(),
              filename: 'image.png',
            ),
          );
          request.headers['authorization'] = 'Bearer $token';
          request.headers['x-access-token'] = token;
          request.fields['cultivation_id'] = widget.cultivation_id;
          request.fields['which_image'] = "img${widget.index}";
          request.fields['which_date'] = "date${widget.index}";
          try {
            final response = await request.send();
            if (response.statusCode == 200) {
              String imagePath = await response.stream.bytesToString();
              print('Progress image uploaded successfully.');
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Progress image updated!')));

              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/farmerDash', (route) => false);
              });
            } else {
              print('Failed to upload image. Status code: ${response}');
            }
          } catch (error) {
            print('Error uploading image: $error');
          }
        }
      } else {
        final imagePicker = ImagePicker();
        final pickedImage =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedImage != null) {
          final imageFile = File(pickedImage.path);
          final imageBytes = await imageFile.readAsBytes();
          // Rest of your code for non-web platforms

          final request = http.MultipartRequest(
              'POST', Uri.parse('http://localhost:5005/api/uploadProgress'));

          request.headers['authorization'] = 'Bearer $token';
          request.headers['x-access-token'] = token;
          request.fields['cultivation_id'] = widget.cultivation_id;

          // Create a `http.MultipartFile` object from the image bytes
          final multipartFile = http.MultipartFile.fromBytes(
            'image',
            imageBytes,
            filename: imageFile.path.split('/').last,
          );

          request.files.add(multipartFile);

          final response = await request.send();

          if (response.statusCode == 200) {
            print('Image uploaded successfully - $response');
          } else {
            print('Image upload failed - - $response');
          }
        } else {
          print("nothing picked");
        }
      }
    } catch (e) {
      print("Error reading file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.progressImageDate);
    String formattedDate = "${dateTime.year}-${dateTime.month}-${dateTime.day}";

    return GestureDetector(
      onTap: () {
        (widget.progressImagePath != '')
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FullScreenImage(imagePath: widget.progressImagePath),
                ),
              )
            : _openGallery();
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
                        'http://localhost:5005/uploads/progressImages/add.png'
                    : 'http://localhost:5005/uploads/progressImages/add.png'),
                fit: BoxFit.cover,
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                children: [
                  Text(
                    "${formattedDate}",
                    style: const TextStyle(fontSize: 13),
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
