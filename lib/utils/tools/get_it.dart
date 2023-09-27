import 'package:time_slot/utils/tools/file_importers.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton(() => AuthorizationRepository());
}
