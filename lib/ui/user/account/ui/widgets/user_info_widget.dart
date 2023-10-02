import 'package:time_slot/utils/tools/file_importers.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => Column(
          children: <Widget>[
            SizedBox(height: height(context) * 0.07),
            const CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage(AppImages.uzumLogo), // Add your user's picture
            ),
            const SizedBox(height: 20),
            Text(
              '${'email'.tr}:  ${state.user?.email}', // Replace with user's email
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              '${'referral'.tr}  ${state.user?.token}', // Replace with user's promo code
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      );
}
