import 'package:hive/hive.dart';

class PrefsBoxKeys {
  static const loggedIn = 'loggedIn';
  static const checkIn = 'checkIn';
  static const checkOut = 'checkOut';
}

class PrefsDb {
  static var prefsBox = Hive.box('prefs');
  static bool get getlogin =>
      prefsBox.get(PrefsBoxKeys.loggedIn, defaultValue: false);

  static Box get box => prefsBox;
  static String? get getcheckIn => prefsBox.get(PrefsBoxKeys.checkIn);
  static String? get getcheckOut => prefsBox.get(PrefsBoxKeys.checkOut);
  static void saveLogin(bool login) => prefsBox.put(
        PrefsBoxKeys.loggedIn,
        login,
      );
  static void saveCheckIn(String? checkIn) =>
      prefsBox.put(PrefsBoxKeys.checkIn, checkIn);
  static void checkOut(String? checkOut) =>
      prefsBox.put(PrefsBoxKeys.checkOut, checkOut);
}
