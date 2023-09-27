import 'package:time_slot/firebase_options.dart';
import 'package:time_slot/utils/tools/file_importers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setup();
  Bloc.observer = AppBlocObserver();
  runApp(const App());
}
