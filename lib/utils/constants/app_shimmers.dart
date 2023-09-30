import 'package:shimmer/shimmer.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class CustomShimmer extends StatelessWidget {
  CustomShimmer({this.color, required this.child, super.key});
  Widget child;
  Color? color;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: color ??
            AdaptiveTheme.of(context).theme.dividerColor.withOpacity(0.2),
        highlightColor:
            AdaptiveTheme.of(context).theme.dividerColor.withOpacity(0.5),
        child: child,
      );
}

class TextShimmer extends StatelessWidget {
  TextShimmer({this.width1, this.borderRadius, this.height1, super.key});
  double? height1;
  double? width1;
  double? borderRadius;

  @override
  Widget build(BuildContext context) => CustomShimmer(
        child: Container(
          height: height1 ?? height(context) * 0.02,
          width: width1 ?? width(context) * 0.4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.h),
              color: AdaptiveTheme.of(context).theme.backgroundColor),
        ),
      );
}

class HomePageCategoryShimmer extends StatelessWidget {
  const HomePageCategoryShimmer({super.key});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: height(context) * 0.62,
        width: width(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: height(context) * 0.2,
              width: width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryShimmer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CategoryShimmer(height1: height(context) * 0.095),
                      CategoryShimmer(height1: height(context) * 0.095),
                    ],
                  )
                ],
              ),
            ),
            CategoryShimmer(width1: width(context)),
            SizedBox(
              height: height(context) * 0.2,
              width: width(context),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CategoryShimmer(),
                  CategoryShimmer(),
                ],
              ),
            ),
          ],
        ),
      );
}

class CategoryShimmer extends StatelessWidget {
  CategoryShimmer({this.height1, this.width1, super.key});
  double? height1;
  double? width1;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.white,
        child: DecoratedBox(
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.cD3D3D3),
              borderRadius: BorderRadius.circular(10.h)),
          child: SizedBox(
            height: height1 ?? height(context) * 0.2,
            width: width1 ?? width(context) * 0.44,
            child: Padding(
                padding: EdgeInsets.all(16.h),
                child:
                    Image.asset(AppImages.umdLogo, color: AppColors.cD3D3D3)),
          ),
        ),
      );
}

class CustomCachedImage extends StatelessWidget {
  CustomCachedImage(this.imageUrl,
      {required this.width1, required this.height1, super.key});
  String imageUrl;
  double height1;
  double width1;

  @override
  Widget build(BuildContext context) => CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => CategoryShimmer(
          width1: width1,
          height1: height1,
        ),
        imageBuilder: (context, imageProvider) => SizedBox(
          width: width1,
          height: height1,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.h),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
        ),
      );
}
