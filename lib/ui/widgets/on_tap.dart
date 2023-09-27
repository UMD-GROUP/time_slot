import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OnTap extends StatelessWidget {
  Widget child;
  VoidCallback onTap;
  OnTap({required this.child, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(onTap: onTap, child: child);
  }
}
