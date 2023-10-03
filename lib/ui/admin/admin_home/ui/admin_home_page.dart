import 'package:time_slot/ui/admin/admin_home/ui/widget/admin_tabbar.dart';

import '../../../../utils/tools/file_importers.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) =>  Scaffold(
    appBar: AppBar(
      title:  Text('admin_panel'.tr),
      backgroundColor: Colors.deepPurple,
      automaticallyImplyLeading: false
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height(context)*0.01,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('banners'.tr,style: AppTextStyles.bodyMedium(context),),
        ),
        SizedBox(height: height(context)*0.01,),
        SizedBox(
          height: height(context)*0.06,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index)=> Padding(
                padding:   EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                height: height(context)*0.06,
                width: width(context)*0.3,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10.r)
                ),

            ),
              )),
        ),
        SizedBox(height: height(context)*0.01,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('prices'.tr,style: AppTextStyles.bodyMedium(context),),
        ),
        SizedBox(height: height(context)*0.01,),
        SizedBox(
          height: height(context)*0.04,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index)=> Padding(
                padding:   EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: height(context)*0.06,
                  width: width(context)*0.2,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10.r)
                  ),

                ),
              )),
        ),
        SizedBox(height: height(context)*0.01,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('other'.tr,style: AppTextStyles.bodyMedium(context),),
        ),
        SizedBox(height: height(context)*0.01,),
        SizedBox(
          height: height(context)*0.04,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 2,
              itemBuilder: (context, index)=> Padding(
                padding:   EdgeInsets.symmetric(horizontal: 5.w),
                child: Container(
                  height: height(context)*0.06,
                  width: width(context)*0.2,
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(10.r)
                  ),

                ),
              )),
        ),
        SizedBox(height: height(context)*0.03,),
        const Expanded(child: AdminTabBarWidget()),

        Container(),
        Container(),
        Container(),
      ],
    ),
  );
}
