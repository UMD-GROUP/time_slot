import 'package:time_slot/utils/tools/file_importers.dart';

final getIt = GetIt.instance;

void setup() {
   FirebaseFirestore firebaseFirestore;
  getIt.registerLazySingleton(() => AuthorizationRepository());
  getIt.registerLazySingleton(() => AdvertisementRepository(FirebaseFirestore.instance));
}
