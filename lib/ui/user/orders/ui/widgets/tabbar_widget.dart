import '../../../../../utils/tools/file_importers.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Container(
          height: height(context)*0.06,

          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(width: 0.5, color: Colors.grey)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TabBarCustomItem(text: 'all', isActive: _currentIndex == 0, context: context, onTap: (){_onTabTapped(0);}),
              TabBarCustomItem(text: 'mine', isActive: _currentIndex == 1, context: context, onTap: (){_onTabTapped(1);}),
              TabBarCustomItem(text: 'referals', isActive: _currentIndex == 2, context: context, onTap: (){_onTabTapped(2);}),
            ],
          ),
        ),
      ),
      BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state){},
        builder: (context, state) {
          if(state.status == ResponseStatus.pure){
            context.read<OrderBloc>().add(GetOrderEvent());
          }
          else if(state.status == ResponseStatus.inProgress){
            return const OrderShimmerWidget();
              //const Center(child: CircularProgressIndicator(color: Colors.deepPurple,),);
          }
          if (state.status == ResponseStatus.inSuccess){
            final List<OrderModel>  data = state.orders!.cast();

            final List<OrderModel> curData = _currentIndex == 0 ?  data.where((e) => e.ownerId == context.read<UserBloc>().state.user!.uid &&  e.referallId ==context.read<UserBloc>().state.user!.token).toList() :
            _currentIndex == 1? data.where((e) => e.ownerId == context.read<UserBloc>().state.user!.uid).toList() : data.where((e) =>   e.referallId ==context.read<UserBloc>().state.user!.token).toList();
            return curData.isEmpty ?
             Center(
              child: SizedBox(
                  height: height(context)*0.35,
                  child: Lottie.asset(AppLotties.empty))
              ,
            )
            : Expanded(
              child: ListView.builder(
                  itemCount: curData.length,
                  itemBuilder: (context, index )=> Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.w),
                    child: Container(
                      height: height(context)*0.15,
                      width: width(context),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.3, color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: height(context)*0.14,
                            width: width(context)*0.35,
                            child: CachedNetworkImage(
                              imageUrl: curData[index].userPhoto,
                              placeholder: (context, url) => Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 10.h),
                                  child: CustomShimmer(
                                      child: Container(
                                        height: height(context),
                                        width: width(context),
                                        decoration: const BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ))),
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                    width: width(context),
                                    margin:
                                    EdgeInsets.symmetric(horizontal: 5.h),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(10.h),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fill)),
                                    ),
                                  ),
                            ),
                          ),
                          Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             SizedBox(height: height(context)*0.01,),
                              OrderTextWidget(context: context, type: 'Order id:',value: curData[index].orderId.toString()),
                              OrderTextWidget(context: context, type: 'product count:',value: curData[index].marketName.toString()),
                              OrderTextWidget(context: context, type: 'sum',value: curData[index].sum.toString()),
                              OrderTextWidget(context: context, type: 'Partner id:',value: curData[index].referallId.toString()),
                         //     OrderTextWidget(context: context, type: 'Status:',value: data[index].status.toString()),
                              Row(
                                children: [
                                  Text('Status:'.tr, style: AppTextStyles.bodyMedium(context,fontWeight: FontWeight.bold),),
                                  SizedBox(width: 5.w,),
                                  Text(curData[index].status.toString() == 'OrderStatus.created' ? 'created'.tr : curData[index].status.toString() == 'OrderStatus.inProgress' ? 'progress'.tr : curData[index].status.toString() == 'OrderStatus.cancelled'? 'cancelled' : 'done', style: AppTextStyles.bodyLargeSmall(context, fontWeight: FontWeight.bold,fontSize: 15.sp, color:
                                  curData[index].status.toString() == 'OrderStatus.created' ? Colors.yellow : curData[index].status.toString() == 'OrderStatus.inProgress' ? AppColors.cGold : curData[index].status.toString() == 'OrderStatus.cancelled'? AppColors.cFF3333 : Colors.green
                                  ),),
                                ],
                              ),
                              SizedBox(height: height(context)*0.01,),
                            ],
                          ),
                          const Spacer(),
                        ],
                      )
                    ),)),);
          }else{
            return const Center(child: Text('error'),);
          }

        },
      ),
    ],
  );

  // ignore: non_constant_identifier_names
  Row OrderTextWidget({required BuildContext context, required String type,required String value}) => Row(
                              children: [
                                Text(type.tr, style: AppTextStyles.bodyMedium(context,fontWeight: FontWeight.bold),),
                                SizedBox(width: 5.w,),
                                Text(value, style: AppTextStyles.bodyLargeSmall(context, fontSize: 15.sp),),
                              ],
                            );

  // ignore: non_constant_identifier_names
  GestureDetector TabBarCustomItem({required BuildContext context,required bool isActive, required String text, required VoidCallback onTap}) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: height(context)*0.05,
      width: width(context)*0.29,
      decoration: BoxDecoration(
          color:isActive ? Colors.deepPurple : Colors.white,
          borderRadius: BorderRadius.circular(10.r)
      ),
      child: Center(
        child: Text(text.tr, style: AppTextStyles.bodyMedium(context, fontWeight: FontWeight.bold, color: isActive ? Colors.white : Colors.black),),
      ),
    ),
  );
}
