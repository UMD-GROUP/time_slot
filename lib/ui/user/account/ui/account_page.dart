import 'package:share_plus/share_plus.dart';
import 'package:time_slot/ui/user/account/ui/widgets/account_action_button.dart';
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
          title: Text('account'.tr),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<UserBloc>().add(
                      GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state.user != null) {
                  return Column(
                    children: [
                      InfoActionButton(
                        title: 'referral',
                        onTap: () {
                          copyToClipboard(context, state.user!.token);
                        },
                        icon: Icons.token,
                        subtitle: state.user!.token,
                      ),
                      BlocListener<UserAccountBloc, UserAccountState>(
                        listener: (context, state) {
                          if (state.addCardStatus ==
                              ResponseStatus.inProgress) {
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
                          subtitle: context
                              .read<UserBloc>()
                              .state
                              .user!
                              .card
                              .cardNumber,
                        ),
                      ),
                      SizedBox(height: height(context) * 0.02),
                      UserStores(markets: state.user!.markets),
                      SizedBox(height: height(context) * 0.02),
                      const Appearance(),
                      AccountActionButton('support'.tr, onTap: () async {
                        await launch('https://t.me/Timeslot_Admin');
                      }, icon: Icons.contact_support_outlined),
                      AccountActionButton('share'.tr, onTap: () async {
                        await Share.share(
                            'https://play.google.com/store/apps/details?id=com.uzmobdev.time_slot');
                      }, icon: Icons.share),
                      AccountActionButton('logging_out'.tr, onTap: () {
                        showLogOutDialog(context);
                      }, icon: Icons.logout)
                    ],
                  );
                }
                return CircularProgressIndicator(
                    color: AdaptiveTheme.of(context).theme.hintColor);
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepPurple,
          child: const Icon(
            Icons.admin_panel_settings_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            showAdminPasswordDialog(context, TextEditingController());
          },
        ),
      );
}
