import 'dart:math';

class Utils {
  static String generateRideRefrence() {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    int random = Random().nextInt(9000) + 1000;
    String ref = 'SN$timestamp$random';

    return ref;
  }
}
