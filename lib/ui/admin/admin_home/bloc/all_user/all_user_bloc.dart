import 'package:time_slot/utils/tools/file_importers.dart';

part 'all_user_event.dart';
part 'all_user_state.dart';

class AllUserBloc extends Bloc<AllUserEvent, AllUserState> {
  AllUserBloc() : super(AllUserState(status: ResponseStatus.pure, index: 0)) {
    on<AllUserEvent>((event, emit) {});
    on<GetAllUserEvent>(geAllUsers);
  }
  Future<void> geAllUsers(GetAllUserEvent event, Emitter emit) async {
    emit(state.copyWith(status: ResponseStatus.inProgress));
    final MyResponse myResponse = await getIt<UsersRepository>().getUsers();
    if (myResponse.statusCode! == 200) {
      emit(state.copyWith(
          users: myResponse.data, status: ResponseStatus.inSuccess));
    } else {
      emit(state.copyWith(status: ResponseStatus.inFail,));
    }
  }


}
