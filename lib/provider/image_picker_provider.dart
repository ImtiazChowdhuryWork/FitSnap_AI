import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerProviderFitsnap extends ChangeNotifier {
  File? _selectedImage;
  bool? _isFromCamera;
  File? get selectedImage => _selectedImage;
  bool? get isFromCamera => _isFromCamera;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _isFromCamera = false;
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _isFromCamera = true;
      _selectedImage = File(pickedFile.path);
      notifyListeners();
    }
  }

  void removeImage() {
    _selectedImage = null;
    notifyListeners();
  }
}
