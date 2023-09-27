import 'package:time_slot/utils/tools/file_importers.dart';

class SignupPage extends StatelessWidget {
  VoidCallback onTap;

  SignupPage({super.key, required this.onTap});

  TextEditingController referellId = TextEditingController();
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
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                height: MediaQuery.of(context).size.height - 50,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "sign_up".tr,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "create_account".tr,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        inputFile(label: "email".tr, controller: email),
                        inputFile(
                            label: "password".tr,
                            obscureText: true,
                            controller: password),
                        inputFile(label: "Referall".tr, controller: referellId),
                      ],
                    ),
                    Container(
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
                          context
                              .read<AuthorizationBloc>()
                              .add(CreateAccountEvent(UserModel(
                                password: password.text.trim(),
                                email: email.text.trim(),
                                referallId: referellId.text.trim(),
                              )));
                        },
                        color: Colors.deepPurple,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: state.status == ResponseStatus.inProgress
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                "sign_up".tr,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?".tr),
                        OnTap(
                          onTap: onTap,
                          child: Text(
                            "Login".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.deepPurple),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// we will be creating a widget for text field
Widget inputFile({label, obscureText = false, controller}) {
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
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepPurple),
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
