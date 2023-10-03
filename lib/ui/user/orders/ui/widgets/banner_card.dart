import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_bloc.dart';
import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_event.dart';
import 'package:time_slot/ui/user/orders/bloc/bloc/data_from_admin/data_from_admin_state.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class BannerCard extends StatelessWidget {
  BannerCard({super.key});
  late List images = ['', ''];

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<DataFromAdminBloc, DataFromAdminState>(
        builder: (context, state) {
          if (state.status == ResponseStatus.pure) {
            context.read<DataFromAdminBloc>().add(GetBannersEvent());
          }
          return BlocBuilder<DataFromAdminBloc, DataFromAdminState>(
            builder: (context, state) {
              if (state.status == ResponseStatus.inSuccess) {
                images = state.data!.banners;
                return CarouselSlider(
                  items: images
                      .map((imageUrl) => Builder(
                            builder: (context) => OnTap(
                              onTap: () {
                                // Navigator.pushNamed(context, RouteName.advertisement,
                                //     arguments: state.banners![state.index]);
                              },
                              child: CachedNetworkImage(
                                imageUrl: state.data!.banners[state.index],
                                placeholder: (context, url) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.h),
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
                                      EdgeInsets.symmetric(horizontal: 20.h),
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
                          ))
                      .toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      context
                          .read<DataFromAdminBloc>()
                          .add(ChangeIndexEvent(index));
                    },
                    height: height(context) * 0.2,
                    viewportFraction: 1,
                    enlargeCenterPage: true,
                    autoPlay: true,
                  ),
                );
              }

              return CustomShimmer(
                child: CarouselSlider(
                  items: images
                      .map((imageUrl) => Builder(
                            builder: (BuildContext context) => Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.h),
                              child: CustomShimmer(
                                  child: Container(
                                height: height(context),
                                width: width(context),
                                decoration: const BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              )),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      context
                          .read<DataFromAdminBloc>()
                          .add(ChangeIndexEvent(index));
                      // setState(() {
                      //   _currentImageIndex = index;
                      // });
                    },
                    height: height(context) * 0.2,
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
