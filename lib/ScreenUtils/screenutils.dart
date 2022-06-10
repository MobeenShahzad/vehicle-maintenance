import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ScreenUtils {
  static double screenheight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static double screenwidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Future<ImageSource?> imagePickOptions(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Color.fromARGB(255, 122, 196, 218),
            height: ScreenUtils.screenheight(context) * 0.2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, ImageSource.camera);
                      },
                      child: Text(
                        'Camera',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, ImageSource.gallery);
                      },
                      child: Text(
                        'Gallery',
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
