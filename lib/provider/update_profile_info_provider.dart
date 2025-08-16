import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UpdateProfileInfoProvider extends ChangeNotifier {
  ///Profile Image Picker Start
  ///
  File? _selectedImage;
  File? get selectedImage => _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void removeImage() {
    _selectedImage = null;
    notifyListeners();
  }

  ///Profile Image Picker End
  ///
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
}
