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
        context.read<UserAccountBloc>().add(GetUserDataEvent(user.uid));
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
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        body: SizedBox(
          height: height(context),
          width: width(context),
          child: Center(
            child: Container(
              margin: EdgeInsets.only(right: 10.h),
              alignment: Alignment.center,
              height: width(context) * 0.16,
              width: width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  Container(
                      alignment: Alignment.center,
                      height: height(context) * 0.06,
                      width: height(context) * 0.06,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.h)),
                      child: Image.asset(
                        AppImages.logo,
                        height: height(context) * 0.16,
                        width: height(context) * 0.16,
                        fit: BoxFit.fitWidth,
                      )),
                  SizedBox(width: width(context) * 0.03),
                  Text(
                    'Seller Pro',
                    style: AppTextStyles.labelSBold(context,
                        fontSize: 30.sp, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      );
}
