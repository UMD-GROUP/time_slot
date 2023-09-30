import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class OnTap extends StatelessWidget {
  OnTap({required this.child, required this.onTap, super.key});
  Widget child;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) =>
      ZoomTapAnimation(onTap: onTap, child: child);
}
