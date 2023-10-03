import '../../../../utils/tools/file_importers.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) =>  Scaffold(
    appBar: AppBar(
      title: const Text('Admin Panel'),
      backgroundColor: Colors.deepPurple,
      automaticallyImplyLeading: false
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height(context)*0.01,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text('Banners',style: AppTextStyles.bodyMedium(context),),
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
          child: Text('Prices',style: AppTextStyles.bodyMedium(context),),
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
          child: Text('Other',style: AppTextStyles.bodyMedium(context),),
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

        Container(),
        Container(),
        Container(),
      ],
    ),
  );
}
