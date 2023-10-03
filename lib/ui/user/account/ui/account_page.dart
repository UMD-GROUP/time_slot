import 'package:time_slot/utils/tools/file_importers.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('User Account'),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.h),
            child: Column(
              children: [
                InfoActionButton(
                  title: 'referral',
                  onTap: () {
                    copyToClipboard(
                        context, context.read<UserBloc>().state.user!.token);
                  },
                  icon: Icons.token,
                  subtitle: context.read<UserBloc>().state.user!.token,
                ),
                BlocListener<UserAccountBloc, UserAccountState>(
                  listener: (context, state) {
                    if (state.addCardStatus == ResponseStatus.inProgress) {
                      showLoadingDialog(context);
                    }
                    if (state.addCardStatus == ResponseStatus.inFail) {
                      Navigator.pop(context);
                      AnimatedSnackBar(
                        snackBarStrategy: RemoveSnackBarStrategy(),
                        builder: (context) => AppErrorSnackBar(
                          text: state.message,
                        ),
                      ).show(context);
                    } else if (state.addCardStatus ==
                        ResponseStatus.inSuccess) {
                      Navigator.pop(context);
                      AnimatedSnackBar(
                        snackBarStrategy: RemoveSnackBarStrategy(),
                        builder: (context) => AppSnackBar(
                          color: AppColors.c7FCD51,
                          text: 'added_successfully'.tr,
                          icon: '',
                        ),
                      ).show(context);
                      setState(() {});
                    }
                  },
                  child: InfoActionButton(
                    title: 'banking_card',
                    onTap: () {
                      showAddBankingCardDialog(context);
                    },
                    icon: Icons.credit_card,
                    subtitle:
                        context.read<UserBloc>().state.user!.card.cardNumber,
                  ),
                ),
                SizedBox(height: height(context) * 0.02),
                const UserStores(),
                SizedBox(height: height(context) * 0.02),
                const Appearance(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, RouteName.adminHome);
          },
        ),
      );
}
