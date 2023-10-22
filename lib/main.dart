import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:time_slot/utils/tools/file_importers.dart';
import 'package:time_slot/utils/tools/init_firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('settings');
  setup();
  // Bloc.observer = AppBlocObserver();
  runApp(const App());
}
