import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';
import 'package:go_rider/utils/app_constant/app_string.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static Future<CroppedFile?> cropImage(
      {required File? imageFile, required bool applyAspectRatio}) async {
    var croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        aspectRatio: applyAspectRatio
            ? const CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
            : null,
        compressFormat: ImageCompressFormat.png,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: AppStrings.appName,
            toolbarColor: AppColor.primaryColor,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: AppStrings.appName),
        ]);
    return croppedFile;
  }

  static Future<File> compress({
    required File image,
    bool forceAspectRatio = false,
    int quality = 100,
    int percentage = 50,
  }) async {
    const maxSizeAllowed = 1024.0;

    final sizeInKbBefore = image.lengthSync() / 1024;
    debugPrint('Before Compress: $sizeInKbBefore kb');

    if (sizeInKbBefore > maxSizeAllowed) {
      var compressedImageFile = await FlutterNativeImage.compressImage(
          image.absolute.path,
          quality: quality,
          percentage: percentage);

      double sizeInKbAfter = compressedImageFile.lengthSync() / 1024;
      debugPrint('After Compress: $sizeInKbAfter kb');

      while (sizeInKbAfter > maxSizeAllowed) {
        compressedImageFile = await FlutterNativeImage.compressImage(
          compressedImageFile.absolute.path,
          quality: quality,
          percentage: 80,
        );
        sizeInKbAfter = compressedImageFile.lengthSync() / 1024;
        debugPrint('After Compress again -> $sizeInKbAfter kb');
      }

      var croppedImage = await ImageHelper.cropImage(
          imageFile: compressedImageFile, applyAspectRatio: forceAspectRatio);
      if (croppedImage == null) {
        return compressedImageFile;
      }
      compressedImageFile = File(croppedImage.path);
      return compressedImageFile;
    } else {
      var croppedImage = await ImageHelper.cropImage(
          imageFile: image, applyAspectRatio: forceAspectRatio);
      if (croppedImage == null) {
        return image;
      }
      image = File(croppedImage.path);

      return image;
    }
  }

  static Future<File?> getFromGallery(bool enforceAspectRatio) async {
    File? selectedImage;
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      var pickedImage = File(pickedFile.path);
      debugPrint('Current filepath: ${pickedFile.path}');
      var editedImage = await ImageHelper.compress(
          image: pickedImage, forceAspectRatio: enforceAspectRatio);
      selectedImage = File(editedImage.path);
    }
    return selectedImage;
  }
}
