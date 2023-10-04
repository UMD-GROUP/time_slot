part of 'all_user_bloc.dart';

@immutable
class AllUserState  extends Equatable{
  AllUserState({
    required this.status,
    this.users,
    required this.index
  });
  ResponseStatus status;
  List? users;
  int index;

  AllUserState copyWith(
      {ResponseStatus? status,
        List? users,
        int? index
      }) =>
      AllUserState(
          index: index ?? this.index,
          users: users ?? this.users,
          status: status ?? this.status);

  @override
  // TODO: implement props
  List<Object?> get props => [status,users,index];
}
