// ignore_for_file: use_build_context_synchronously, type_annotate_public_apis

import 'package:time_slot/utils/tools/file_importers.dart';

Future<XFile?> showPicker(BuildContext context) async {
  final ImagePicker picker = ImagePicker();
  late XFile? file;
  await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (bc) => SafeArea(
            child: Container(
              height: height(context) * 0.23,
              decoration: BoxDecoration(
                  color: AdaptiveTheme.of(context).theme.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.h),
                      topLeft: Radius.circular(20.h))),
              padding: EdgeInsets.all(12.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('upload_photo_from'.tr,
                      style:
                          AppTextStyles.labelMedium(context, fontSize: 16.sp)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () async {
                          file = await _getFromGallery(picker);
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 100,
                              color: AdaptiveTheme.of(context).theme.hintColor,
                            ),
                            Text('gallery'.tr,
                                style: AppTextStyles.labelLarge(context)),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          file = await _getFromCamera(picker);
                          Navigator.pop(context);
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera,
                              size: 100,
                              color: AdaptiveTheme.of(context).theme.hintColor,
                            ),
                            Text('camera'.tr,
                                style: AppTextStyles.labelLarge(context)),
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
