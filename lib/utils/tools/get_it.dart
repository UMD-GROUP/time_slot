import 'package:time_slot/service/storage_service/storage_service.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

final getIt = GetIt.instance;

void setup() {
  final FirebaseFirestore fireStoreInstance = FirebaseFirestore.instance;
  getIt
    ..registerLazySingleton(AuthorizationRepository.new)
    ..registerLazySingleton(UserRepository.new)
    ..registerLazySingleton(() => DataFromAdminRepository(fireStoreInstance))
    // ignore: avoid_single_cascade_in_expression_statements
    ..registerLazySingleton(() => PurchaseRepository(fireStoreInstance))
    ..registerLazySingleton(CreateOrderRepository.new)
    ..registerLazySingleton(() => OrdersRepository(fireStoreInstance))
    ..registerLazySingleton(() => UsersRepository(fireStoreInstance))
    ..registerLazySingleton(() => UserAccountRepository(fireStoreInstance))
    ..registerLazySingleton(() => AdminRepository(fireStoreInstance))
    ..registerLazySingleton(StorageService.new);
}
