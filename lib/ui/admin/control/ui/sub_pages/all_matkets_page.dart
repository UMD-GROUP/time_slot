// ignore_for_file: cascade_invocations

import 'package:time_slot/ui/admin/control/ui/sub_pages/widgets/stores_view.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

class AllMarketsPage extends StatelessWidget {
  const AllMarketsPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AdaptiveTheme.of(context).theme.backgroundColor,
          title: Text('markets'.tr, style: AppTextStyles.labelLarge(context)),
        ),
        body: BlocBuilder<StoresBloc, StoresState>(
          builder: (context, state) {
            if (state.gettingStatus == ResponseStatus.pure) {
              context.read<StoresBloc>().add(GetAllStoresEvent());
            } else if (state.gettingStatus == ResponseStatus.inSuccess) {
              final List<StoreModel> curData = state.stores!.cast();
              curData.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
              return SizedBox(
                height: height(context),
                width: width(context),
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelColor: AdaptiveTheme.of(context).theme.hintColor,
                        indicatorColor: Colors.deepPurple,
                        tabs: [
                          Tab(text: 'unconfirmed'.tr),
                          Tab(text: 'confirmed'.tr),
                        ],
                      ),
                      SizedBox(height: height(context) * 0.02),
                      Expanded(
                        child: TabBarView(children: [
                          StoresView(splitStores(curData, false)),
                          StoresView(splitStores(curData, true)),
                        ]),
                      )
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: Text('error'),
            );
          },
        ),
      );
}
