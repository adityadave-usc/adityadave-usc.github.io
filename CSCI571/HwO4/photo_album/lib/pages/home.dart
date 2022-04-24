import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<XFile> images = [];

  void saveImagesToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final storeImages = <String>[];
    for (XFile image in this.images) {
      storeImages.add(image.path);
    }
    prefs.setStringList('images', storeImages);
  }

  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context)?.settings.arguments as Map;

    print(args['images']);
    // Load previous images
    for (String imagePath in args['images']) {
      images.add(XFile(imagePath));
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Album 571')),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(children: [
          images.isEmpty
              ? Expanded(
                  child: Center(child: Image.asset('assets/images/empty.png')))
              : Expanded(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      primary: false,
                      itemCount: images.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(8)),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/image_viewer',
                                        arguments: {
                                          'imagePath': images[index].path
                                        });
                                  },
                                  child: Image.file(File(images[index].path),
                                      fit: BoxFit.cover,
                                      width: 120.0,
                                      height: 120.0)))
                        ]);
                      }),
                ),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: ElevatedButton.icon(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final List<XFile> images =
                          await _picker.pickMultiImage() ?? [];
                      setState(() {
                        if (images.isNotEmpty) {
                          final updatedImages = [...this.images];
                          updatedImages.addAll(images);
                          this.images = updatedImages;
                        }
                      });
                      // Save to preferences
                      saveImagesToPrefs();
                    },
                    icon: const Icon(Icons.photo_library_sharp),
                    label: const Text('Add from Gallery')),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () async {
                        final ImagePicker _picker = ImagePicker();
                        final XFile? image =
                            await _picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          // getting a directory path for saving
                          final String path =
                              (await getApplicationDocumentsDirectory()).path;

                          // copy the file to a new path
                          final File newImage = await File(image.path).copy(
                              '$path/${md5.convert(utf8.encode(image.path))}.png');

                          setState(() {
                            images.add(XFile(newImage.path));
                          });

                          // Save to preferences
                          saveImagesToPrefs();
                        }
                      },
                      icon: const Icon(Icons.photo_camera),
                      label: const Text('Use Camera')))
            ],
          )
        ]),
      ),
    );
  }
}
