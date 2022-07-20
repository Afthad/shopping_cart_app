import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:konnect_app/pages/checked_in_screen.dart';
import 'package:konnect_app/pages/login_screen.dart';
import 'package:konnect_app/pages/retailers_list_page.dart';
import 'package:konnect_app/prefs/prefs.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appDocDir = await getApplicationDocumentsDirectory();
  Hive.init('${appDocDir.path}/db');
  await Hive.openBox('prefs');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            backgroundColor: Colors.white,
            primaryColor: Colors.black,
            primarySwatch: Colors.grey),
        home: screenSeletion(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

Widget screenSeletion() {
  if (PrefsDb.getlogin) {
    if (PrefsDb.getcheckIn != null) {
      return const CheckedInPage();
    } else {
      return const RetailerListPage();
    }
  }
  return const LoginScreen();
}
