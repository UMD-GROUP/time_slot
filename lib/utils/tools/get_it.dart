
import 'package:time_slot/ui/user/account/data/repositories/user_account_repository.dart';
import 'package:time_slot/ui/user/create_order/data/repository/create_order_repository.dart';
import 'package:time_slot/ui/user/orders/data/repository/orders_repository.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

final getIt = GetIt.instance;

void setup() {
  final FirebaseFirestore fireStoreInstance = FirebaseFirestore.instance;
  getIt
    ..registerLazySingleton(AuthorizationRepository.new)
    ..registerLazySingleton(UserRepository.new)
    ..registerLazySingleton(
        () => AdvertisementRepository(FirebaseFirestore.instance))
    // ignore: avoid_single_cascade_in_expression_statements
    ..registerLazySingleton(() => OrdersRepository(FirebaseFirestore.instance))
    ..registerLazySingleton(() => PurchaseRepository(FirebaseFirestore.instance))
    ..registerLazySingleton(CreateOrderRepository.new);
    ..registerLazySingleton(() => OrdersRepository(fireStoreInstance))
    ..registerLazySingleton(CreateOrderRepository.new)
    ..registerLazySingleton(() => UserAccountRepository(fireStoreInstance));
}
