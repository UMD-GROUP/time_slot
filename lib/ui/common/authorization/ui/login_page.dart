// ignore_for_file: type_annotate_public_apis

import 'package:time_slot/ui/common/authorization/ui/widgets/google_button.dart';
import 'package:time_slot/ui/user/membership/data/models/banking_card_model.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.onTap, required this.controllers});
  VoidCallback onTap;
  List controllers;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AuthorizationBloc(),
        child: BlocConsumer<AuthorizationBloc, AuthorizationState>(
          listener: (context, state) {
            if (state.status == ResponseStatus.inFail) {
              AnimatedSnackBar(
                  duration: const Duration(seconds: 6),
                  snackBarStrategy: RemoveSnackBarStrategy(),
                  builder: (context) =>
                      AppErrorSnackBar(text: state.message.tr)).show(context);
            }
            if (state.status == ResponseStatus.inSuccess) {
              context.read<UserBloc>().add(
                  GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.userMain, (route) => false);
            }
          },
          builder: (context, state) => Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                        height: height(context) * 0.65,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  'login'.tr,
                                  style: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'login_to_your_account'.tr,
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.grey[700]),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40.h),
                              child: Column(
                                children: <Widget>[
                                  inputFile(
                                      label: 'email'.tr,
                                      controller: controllers[0]),
                                  inputFile(
                                      label: 'password'.tr,
                                      obscureText: true,
                                      controller: controllers[1])
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              child: Container(
                                padding: const EdgeInsets.only(top: 3, left: 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  // border: const Border(
                                  //   bottom: BorderSide(),
                                  //   top: BorderSide(),
                                  //   left: BorderSide(),
                                  //   right: BorderSide(),
                                  // )
                                ),
                                child: MaterialButton(
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () {
                                    context.read<AuthorizationBloc>().add(
                                        SignInEvent(UserModel(
                                            card: BankingCardModel(
                                                cardNumber: ''),
                                            email: controllers[0].text.trim(),
                                            password:
                                                controllers[1].text.trim())));
                                  },
                                  color: Colors.deepPurple,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child:
                                      state.status == ResponseStatus.inProgress
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              'login'.tr,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color: Colors.white,
                                              ),
                                            ),
                                ),
                              ),
                            ),
                          ],
                        )),
                    Column(
                      children: [
                        GoogleButton(isSignIn: true),
                        SizedBox(height: height(context) * 0.03),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('do_not_have_an_account'.tr),
                            OnTap(
                              onTap: onTap,
                              child: Text(
                                'sign_up'.tr,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.deepPurple),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: height(context) * 0.03),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}

// we will be creating a widget for text field
Widget inputFile({label, controller, obscureText = false}) => Column(
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
              focusColor: Colors.deepPurple,
              contentPadding: EdgeInsets.symmetric(horizontal: 10.h),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple))),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
