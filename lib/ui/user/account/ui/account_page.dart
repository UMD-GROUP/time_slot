import 'dart:async';

import 'package:flutter/cupertino.dart';
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
                  context.read<UserAccountBloc>().add(
                      GetUserDataEvent(FirebaseAuth.instance.currentUser!.uid));
                  context.read<UserAccountBloc>().add(GetUserStoresEvent(
                      FirebaseAuth.instance.currentUser!.uid));
                  context.read<DataFromAdminBloc>().add(GetBannersEvent());
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                child: BlocBuilder<UserAccountBloc, UserAccountState>(
                  builder: (context, state) {
                    if (state.getUserStatus == ResponseStatus.inSuccess) {
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
                          InfoActionButton(
                            title: 'Email:'.tr,
                            onTap: () {
                              copyToClipboard(context, state.user!.email);
                            },
                            icon: Icons.email,
                            subtitle: state.user!.email,
                          ),
                          SizedBox(height: height(context) * 0.02),
                          const UserStores(),
                          SizedBox(height: height(context) * 0.02),
                          const Appearance(),
                          Visibility(
                            visible: Uri.parse(context
                                    .read<DataFromAdminBloc>()
                                    .state
                                    .data!
                                    .termsOfUsing)
                                .isAbsolute,
                            child: AccountActionButton('terms_of_using'.tr,
                                onTap: () async {
                              unawaited(Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const WebViewExample(),
                                  )));
                              // await launch(context
                              //     .read<DataFromAdminBloc>()
                              //     .state
                              //     .data!
                              //     .termsOfUsing);
                            }, icon: Icons.published_with_changes_outlined),
                          ),
                          Visibility(
                            visible: Uri.parse(context
                                    .read<DataFromAdminBloc>()
                                    .state
                                    .data!
                                    .instruction)
                                .isAbsolute,
                            child: AccountActionButton('instruction'.tr,
                                onTap: () async {
                              showVideoPlayer(
                                  context,
                                  context
                                      .read<DataFromAdminBloc>()
                                      .state
                                      .data!
                                      .instruction);
                            }, icon: Icons.integration_instructions_outlined),
                          ),
                          AccountActionButton('support'.tr, onTap: () async {
                            await launch('https://t.me/Timeslot_Admin');
                          }, icon: Icons.telegram),
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
                    return CupertinoActivityIndicator(
                        color: AdaptiveTheme.of(context).theme.hintColor);
                  },
                ),
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.deepPurple,
        //   child: const Icon(
        //     Icons.admin_panel_settings_rounded,
        //     color: Colors.white,
        //   ),
        //   onPressed: () {
        //     showAdminPasswordDialog(context, TextEditingController());
        //   },
        // ),
      );
}
