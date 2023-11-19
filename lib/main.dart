import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';
import 'package:stringvault/providers/data_provider.dart';
import 'package:stringvault/services/database_services.dart';
import 'package:stringvault/views/home_view.dart';

import 'const/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory = await getApplicationDocumentsDirectory();
  var databasePath = join(documentsDirectory.path, 'stringvault.db');

  var databaseService = DatabaseService(databasePath);
  await databaseService.initializeDatabase();

  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(databaseService),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: AppTheme.theme,
      home: const HomeView(),
    );
  }
}
