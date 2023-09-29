import 'package:time_slot/ui/user/orders/data/repository/advertisement_repository.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

final getIt = GetIt.instance;

void setup() {
   FirebaseFirestore firebaseFirestore;
  getIt.registerLazySingleton(() => AuthorizationRepository());
  getIt.registerLazySingleton(() => AdvertisementRepository(FirebaseFirestore.instance));
}
