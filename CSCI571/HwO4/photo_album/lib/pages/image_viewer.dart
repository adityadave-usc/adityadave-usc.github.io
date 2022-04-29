import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewerPage extends StatelessWidget {
  late Future<ImageInfo> imageInfo;

  ImageViewerPage({Key? key}) : super(key: key);

  Future<ImageInfo> getImageInfo(Image img) async {
    final c = Completer<ImageInfo>();
    img.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo i, bool _) {
      c.complete(i);
    }));
    return c.future;
  }

  Widget imageInfoLoader(
      BuildContext context, AsyncSnapshot<ImageInfo> snapshot) {
    final Widget errorMessage =
        Row(mainAxisSize: MainAxisSize.min, children: const [
      Icon(
        Icons.error,
        color: Colors.red,
      ),
      Text(
        '  Error loading image information.',
        style: TextStyle(color: Colors.red),
      )
    ]);

    if (!snapshot.hasData) {
      return errorMessage;
    } else {
      ImageInfo? imageInfo = snapshot.data;
      if (imageInfo == null) {
        return errorMessage;
      }
      return Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text('Image Width: ${imageInfo.image.width}'),
            Text('Image Height: ${imageInfo.image.height}')
          ]));
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final imagePath = args['imagePath'];
    final Image image = Image.file(
      File(imagePath),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fullscreen Image'),
      ),
      body: ListView(
        children: [
          image,
          const SizedBox(height: 8.0),
          FutureBuilder<ImageInfo>(
              future: getImageInfo(image), builder: imageInfoLoader),
        ],
      ),
    );
  }
}


// ListView(
// children: [
// image,
// const SizedBox(height: 8.0),
// FutureBuilder<ImageInfo>(
// future: getImageInfo(image), builder: imageInfoLoader),
// ],
// )