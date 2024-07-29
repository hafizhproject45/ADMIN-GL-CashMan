// ignore_for_file: file_names

import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/utils/text_style.dart';
import '../../../core/utils/colors.dart';
import '../../../core/utils/toast.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({
    super.key,
  });

  @override
  State<ImagePickerWidget> createState() => _ImagePickerWidgetState();
}

File? selectedImage;

class _ImagePickerWidgetState extends State<ImagePickerWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pickImage(ImageSource.gallery);
      },
      child: selectedImage != null
          ? Container(
              width: selectedImage != null
                  ? MediaQuery.of(context).size.width
                  : 300,
              height: selectedImage != null
                  ? MediaQuery.of(context).size.width
                  : 300,
              decoration: selectedImage != null
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(selectedImage!),
                        fit: BoxFit.contain,
                      ),
                    )
                  : null,
            )
          : Column(
              children: [
                DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: const [10, 5],
                  color: AppColor.primary,
                  radius: const Radius.circular(10),
                  strokeWidth: 2,
                  stackFit: StackFit.loose,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: AppColor.primary.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_outlined,
                          color: AppColor.primary,
                          size: 100,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Payment Photo',
                          style: AppTextStyle.mediumPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // void _showPicker(BuildContext context) {
  //   showModalBottomSheet(
  //     backgroundColor: Colors.white,
  //     context: context,
  //     isScrollControlled: true,
  //     shape: const RoundedRectangleBorder(
  //       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
  //     ),
  //     builder: (BuildContext context) {
  //       return Padding(
  //         padding: const EdgeInsets.all(20),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             ListTile(
  //               leading: const Icon(
  //                 Icons.photo_library,
  //                 color: AppColor.textSmall,
  //               ),
  //               title: const Text('Gallery'),
  //               onTap: () {
  //                 _pickImage(ImageSource.gallery);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //             ListTile(
  //               leading: const Icon(
  //                 Icons.photo_camera,
  //                 color: AppColor.textSmall,
  //               ),
  //               title: const Text('Camera'),
  //               onTap: () {
  //                 _pickImage(ImageSource.camera);
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final File imageFile = File(pickedImage.path);

      int fileSize = await imageFile.length();

      if (fileSize > 500 * 1024) {
        dangerToast(msg: 'File size max: 500kb');
      } else {
        final croppedImage = await ImageCropper().cropImage(
          sourcePath: imageFile.path,
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: AppColor.primary,
              cropGridColor: AppColor.primary,
              statusBarColor: AppColor.primary,
              cropFrameColor: AppColor.primary,
              activeControlsWidgetColor: AppColor.primary,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: false,
            ),
            IOSUiSettings(
              title: 'Crop Image',
            ),
          ],
        );

        if (croppedImage != null) {
          setState(() {
            selectedImage = File(croppedImage.path);
          });
        }
      }
    }
  }
}
