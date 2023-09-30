// ignore_for_file: inference_failure_on_instance_creation

import 'package:time_slot/utils/tools/file_importers.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final dynamic user = auth.currentUser;
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (user != null) {
        context.read<UserBloc>().add(GetUserDataEvent(auth.currentUser!.uid));
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.userMain, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteName.authorization, (route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          padding: EdgeInsets.all(40.h),
          height: height(context),
          width: width(context),
          child: Center(
            child: Image.asset(
              AppImages.umdLogo,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      );
}
