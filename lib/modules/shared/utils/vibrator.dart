import 'package:vibration/vibration.dart';

class Vibrator {
  static Future<void> vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }
  }
}
