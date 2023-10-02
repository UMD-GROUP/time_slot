import 'package:time_slot/utils/tools/file_importers.dart';
final getIt = GetIt.instance;

void setup() {
  getIt
    ..registerLazySingleton(AuthorizationRepository.new)
    ..registerLazySingleton(UserRepository.new)
    ..registerLazySingleton(() => AdvertisementRepository(FirebaseFirestore.instance))
    // ignore: avoid_single_cascade_in_expression_statements
    ..registerLazySingleton(() => OrdersRepository(FirebaseFirestore.instance))
    ..registerLazySingleton(() => PurchaseRepository(FirebaseFirestore.instance))
    ..registerLazySingleton(CreateOrderRepository.new);
}
