// ignore_for_file: type_annotate_public_apis

import 'package:time_slot/ui/user/membership/data/models/banking_card_model.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class SignupPage extends StatelessWidget {
  SignupPage({required this.controllers, super.key, required this.onTap});
  VoidCallback onTap;
  List controllers;

  @override
  Widget build(BuildContext context) => BlocProvider(
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
              context.read<UserBloc>().add(
                  GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
              Navigator.pushNamedAndRemoveUntil(
                  context, RouteName.userMain, (route) => false);
            }
          },
          builder: (context, state) => Scaffold(
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
                          'sign_up'.tr,
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
                          'create_account'.tr,
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        inputFile(
                            label: 'email'.tr, controller: controllers[0]),
                        inputFile(
                            label: 'password'.tr,
                            obscureText: true,
                            controller: controllers[1]),
                        inputFile(
                            label: 'Referall'.tr, controller: controllers[2]),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: const Border(
                            bottom: BorderSide(),
                            top: BorderSide(),
                            left: BorderSide(),
                            right: BorderSide(),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () {
                          context
                              .read<AuthorizationBloc>()
                              .add(CreateAccountEvent(UserModel(
                                createdAt: DateTime.now(),
                                card: BankingCardModel(cardNumber: ''),
                                password: controllers[1].text.trim(),
                                email: controllers[0].text.trim(),
                                referallId: controllers[2].text.trim(),
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
                                'sign_up'.tr,
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
                        Text('Already have an account?'.tr),
                        OnTap(
                          onTap: onTap,
                          child: Text(
                            'Login'.tr,
                            style: const TextStyle(
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
          ),
        ),
      );
}

// we will be creating a widget for text field
Widget inputFile({label, obscureText = false, controller}) => Column(
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
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