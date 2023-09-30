import 'package:time_slot/ui/user/create_order/data/repository/create_order_repository.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

final getIt = GetIt.instance;

void setup() {
  getIt
    ..registerLazySingleton(AuthorizationRepository.new)
    ..registerLazySingleton(UserRepository.new)
    ..registerLazySingleton(
        () => AdvertisementRepository(FirebaseFirestore.instance))
    ..registerLazySingleton(CreateOrderRepository.new);
}
