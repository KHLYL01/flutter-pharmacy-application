import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pharmacy_managment_system/core/extensions/widget_extension.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({
    Key? key,
    required this.image,
    required this.isFile,
  }) : super(key: key);

  final String image;
  final bool isFile;

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  TransformationController viewController = TransformationController();
  var initialControllerValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: SafeArea(
          child: InteractiveViewer(
        transformationController: viewController,
        minScale: 0.3,
        maxScale: 8,
        onInteractionStart: (details) {
          initialControllerValue = viewController.value;
        },
        onInteractionEnd: (details) {
          viewController.value = initialControllerValue;
        },
        child: widget.isFile
            ? Image.file(File(widget.image)).center()
            : Image.network(widget.image).center(),
      )),
    );
  }
}

/*
*



    InteractiveViewer(

        transformationController: viewController,
        onInteractionStart: (details){

            initialControllerValue = viewController.value;
        },

        onInteractionEnd: (details){

            viewController.value = initialControllerValue;
        },
           */
