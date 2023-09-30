import 'package:time_slot/ui/authorization/ui/login_page.dart';
import 'package:time_slot/ui/authorization/ui/sign_up_page.dart';

import '../../../utils/tools/file_importers.dart';

class AuthorizationPage extends StatefulWidget {
  const AuthorizationPage({super.key});

  @override
  State<AuthorizationPage> createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  PageController controller = PageController();
  List signInControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  List logInControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: height(context),
        width: width(context),
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            LoginPage(
              controllers: logInControllers,
              onTap: () {
                controller.nextPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceIn);
                setState(() {});
              },
            ),
            SignupPage(
              controllers: signInControllers,
              onTap: () {
                controller.previousPage(
                    duration: const Duration(seconds: 1),
                    curve: Curves.bounceIn);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
