import 'package:time_slot/utils/tools/file_importers.dart';

part 'page_controller_event.dart';
part 'page_controller_state.dart';

class PageControllerBloc
    extends Bloc<PageControllerEvent, PageControllerState> {
  PageControllerBloc() : super(PageControllerState(0)) {
    on<ChangeCurrentPageEvent>(changeIndex);
  }

  void changeIndex(ChangeCurrentPageEvent event, Emitter emit) {
    emit(state.copyWith(event.index));
  }
}
