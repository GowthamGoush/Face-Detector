import 'package:image_picker/image_picker.dart';

class ImagePathPicker {
  XFile? _imageFile;
  ImagePicker _imagePicker = ImagePicker();

  Future getImage() async {
    try {
      _imageFile = await _imagePicker.pickImage(source: ImageSource.gallery);

      if (_imageFile != null) return _imageFile!.path;
    } catch (e) {
      print(e);
    }
  }
}
