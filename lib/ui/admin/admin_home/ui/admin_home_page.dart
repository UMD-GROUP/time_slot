import '../../../../utils/tools/file_importers.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) => BlocListener<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state.updateOrderState == ResponseStatus.inSuccess) {
            context.read<OrderBloc>().add(GetOrderEvent());
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppSnackBar(
                  text: 'updated_successfully'.tr,
                  icon: '',
                  color: AppColors.c7FCD51),
            ).show(context);
            setState(() {});
          } else if (state.updateOrderState == ResponseStatus.inFail) {
            Navigator.pop(context);
            AnimatedSnackBar(
              snackBarStrategy: RemoveSnackBarStrategy(),
              builder: (context) => AppErrorSnackBar(text: state.message),
            ).show(context);
          } else if (state.updateOrderState == ResponseStatus.inProgress) {
            Navigator.pop(context);
            Navigator.pop(context);
            showLoadingDialog(context);
          }
        },
        child: Scaffold(
          backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
          appBar: AppBar(
              title: Text('admin_panel'.tr),
              backgroundColor: Colors.deepPurple,
              actions: [
                IconButton(
                  icon: SvgPicture.asset(AppIcons.refresh,     color: AdaptiveTheme.of(context).theme.canvasColor,
                    height: height(context) * 0.03,),
                  onPressed: () {
                       context.read<OrderBloc>().add(GetOrderEvent());
                       context.read<AllUserBloc>().add(GetAllUserEvent());
                       context.read<PurchaseBloc>().add(GetPurchasesEvent());
                       context.read<DataFromAdminBloc>().add(GetBannersEvent());
                      // context.read<DataFromAdminBloc>().add(GetPurchasesEvent());

                  },
                ),
              ],
              automaticallyImplyLeading: false),
       

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('banners'.tr,
                    style: AppTextStyles.bodyMedium(context)),
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              const AdminBannerWidget(),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'prices'.tr,
                  style: AppTextStyles.bodyMedium(context),
                ),
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              const PricesView(),
              SizedBox(
                height: height(context) * 0.01,
              ),
              const OtherView(),
              SizedBox(
                height: height(context) * 0.03,
              ),
              const Expanded(child: AdminTabBarWidget()),
            ],
          ),
        ),
      );
}
