import '../../../../../utils/tools/file_importers.dart';

class BannerCard extends StatelessWidget {
  BannerCard({super.key});
  late List images = ['', ''];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdvertisementBloc, AdvertisementState>(
      builder: (context, state) {
        if (state.status == ResponseStatus.pure) {
          context.read<AdvertisementBloc>().add(GetBannersEvent());
        }
        return BlocBuilder<AdvertisementBloc, AdvertisementState>(
          builder: (context, state) {
            if (state.status == ResponseStatus.inSuccess) {
              images = state.banners![0].carusels!;
              return CarouselSlider(
                items: images.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return OnTap(
                        onTap: () {
                          // Navigator.pushNamed(context, RouteName.advertisement,
                          //     arguments: state.banners![state.index]);
                        },
                        child: CachedNetworkImage(
                          imageUrl: state.banners![0].carusels[state.index],
                          placeholder: (context, url) => Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: CustomShimmer(
                              child: Container(
                                height: height(context),
                                width: width(context),
                                decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                              )
                            )
                          ),
                          imageBuilder: (context, imageProvider) => Container(
                            width: width(context),
                            margin: EdgeInsets.symmetric(horizontal: 20.h),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.h),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill)),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  onPageChanged: ((index, reason) {
                    context.read<AdvertisementBloc>().add(ChangeIndexEvent(index));
                  }),
                  height: height(context) * 0.2,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
              );
            }

            return CustomShimmer(
              child: CarouselSlider(
                items: images.map((imageUrl) {
                  return Builder(
                    builder: (BuildContext context) {
                      return  Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.h),
                        child: CustomShimmer(
                            child: Container(
                              height: height(context),
                              width: width(context),
                              decoration: const BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                            )
                        ),
                      );
                    },
                  );
                }).toList(),
                options: CarouselOptions(
                  onPageChanged: ((index, reason) {
                    context
                        .read<AdvertisementBloc>()
                        .add(ChangeIndexEvent(index));
                    // setState(() {
                    //   _currentImageIndex = index;
                    // });
                  }),
                  height: height(context) * 0.2,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  enlargeCenterPage: true,
                  autoPlay: true,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
