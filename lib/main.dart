import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mc_application/app_data.dart';
import 'package:mc_application/core/helpers/logger_helper.dart';
import 'package:mc_application/modules/authentication/login/login_page_model.dart';
import 'package:mc_application/modules/authentication/signup/signup_page_model.dart';
import 'package:mc_application/modules/init/initial_page.dart';
import 'package:mc_application/routes/router.dart' as main_router;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  sqfliteFfiInit();
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    final appDirectory = await getApplicationDocumentsDirectory();
    print("Đường dẫn thư mục ứng dụng: ${appDirectory.path}");
    // await dotenv.load();
    runApp(MultiProvider(providers: [
      ChangeNotifierProvider<LoginPageModel>.value(value: LoginPageModel()),
      ChangeNotifierProvider<SignUpPageModel>.value(value: SignUpPageModel())
    ], child: MyApp()));
  }, (error, stack) {
    logger.log(error);
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Chat Social",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'WorkSans',
          visualDensity: VisualDensity.adaptivePlatformDensity),
      navigatorKey: appData.navigatorKey,
      // initialRoute: RouteNames.login,
      onGenerateRoute: main_router.Router.generateRoute,
      home: InitialPage(),
    );
  }
}
