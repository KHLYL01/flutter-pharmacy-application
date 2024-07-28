import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharmacy_managment_system/core/functions/toast.dart';

class ImageController extends GetxController {
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  // var isLoading = true.obs;

  Future<void> getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().pickImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          '${((File(selectedImagePath.value)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} MB';
      toast(msg: 'photo added successfully');
    } else {
      toast(msg: 'photo did n\'t add');
    }
  }

  clearSelectedImage() {
    selectedImagePath.value = '';
    selectedImageSize.value = '';
  }
  //
  // @override
  // void onInit() {
  //   // TODO: implement onInit
  //   Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);
  //   super.onInit();
  // }
}
