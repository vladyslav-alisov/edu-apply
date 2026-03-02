import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();

enum ImageSourceOption {
  camera,
  gallery;
}

Future<File?> selectImage(ImageSourceOption source) async {
  ImageSource imageSource = switch (source) {
    ImageSourceOption.camera => ImageSource.camera,
    ImageSourceOption.gallery => ImageSource.gallery,
  };
  XFile? xFile = await picker.pickImage(source: imageSource, maxHeight: 200, maxWidth: 200);
  return xFile != null ? File(xFile.path) : null;
}

Future<ImageSourceOption?> selectSource(BuildContext context) async {
  ImageSourceOption? source = await showModalBottomSheet(
    context: context,
    builder: (context) {
      return CupertinoActionSheet(
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(context),
          isDestructiveAction: true,
          child: Text("Cancel"),
        ),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, ImageSourceOption.camera),
            child: Text("Camera"),
          ),
          CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context, ImageSourceOption.gallery),
            child: Text("Gallery"),
          ),
        ],
      );
    },
  );
  return source;
}
