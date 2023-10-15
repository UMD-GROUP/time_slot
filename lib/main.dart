import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:time_slot/firebase_options.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  setup();
  // Bloc.observer = AppBlocObserver();
  runApp(const App());
}
