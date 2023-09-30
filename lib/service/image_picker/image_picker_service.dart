// ignore_for_file: use_build_context_synchronously, type_annotate_public_apis

import 'package:image_picker/image_picker.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

Future<XFile?> showPicker(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  late XFile? file;
  await showModalBottomSheet(
      context: context,
      builder: (bc) => SafeArea(
            child: Container(
              height: 180.h,
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  const Text('Upload photo from'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          file = await _getFromGallery(picker);
                          print('Image tanlandi');
                          Navigator.pop(context);
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 100,
                            ),
                            Text('Gallery'),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          file = await _getFromCamera(picker);
                          print('Image tanlandi');
                          Navigator.pop(context);
                        },
                        child: const Column(
                          children: [
                            Icon(
                              Icons.camera,
                              size: 100,
                            ),
                            Text('Camera'),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ));
  return file;
}

Future<XFile?> _getFromGallery(ImagePicker picker) async {
  final XFile? pickedFile = await picker.pickImage(
    maxWidth: 1200,
    maxHeight: 1200,
    source: ImageSource.gallery,
  );
  if (pickedFile != null) {
    return pickedFile;
  }
  return null;
}

Future<XFile?> _getFromCamera(ImagePicker picker) async {
  final XFile? pickedFile = await picker.pickImage(
    maxWidth: 1200,
    maxHeight: 1200,
    source: ImageSource.camera,
  );
  if (pickedFile != null) {
    return pickedFile;
  }
  return null;
}
