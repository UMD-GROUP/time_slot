import '../../../utils/tools/file_importers.dart';

class LoginPage extends StatelessWidget {
  VoidCallback onTap;

  LoginPage({super.key, required this.onTap});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthorizationBloc(),
      child: BlocConsumer<AuthorizationBloc, AuthorizationState>(
        listener: (context, state) {
          if (state.status == ResponseStatus.inFail) {
            AnimatedSnackBar(
                duration: const Duration(seconds: 4),
                snackBarStrategy: RemoveSnackBarStrategy(),
                builder: (context) =>
                    AppErrorSnackBar(text: state.message.tr)).show(context);
          }
          if (state.status == ResponseStatus.inSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, RouteName.userMain, (route) => false);
          }
        },
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "login".tr,
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "login_to_your_account".tr,
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.h),
                        child: Column(
                          children: <Widget>[
                            inputFile(label: "email".tr, controller: email),
                            inputFile(
                                label: "password".tr,
                                obscureText: true,
                                controller: password)
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                          padding: const EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: const Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () {
                              context.read<AuthorizationBloc>().add(SignInEvent(
                                  UserModel(
                                      email: email.text.trim(),
                                      password: password.text.trim())));
                            },
                            color: const Color(0xff0095FF),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: state.status == ResponseStatus.inProgress
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : Text(
                                    "login".tr,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("do_not_have_an_account".tr),
                          OnTap(
                            onTap: onTap,
                            child: Text(
                              "sign_up".tr,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 100),
                        height: 200,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppImages.background),
                              fit: BoxFit.fitHeight),
                        ),
                      )
                    ],
                  ))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile({label, controller, obscureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10.h),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400))),
      ),
      const SizedBox(
        height: 10,
      )
    ],
  );
}
