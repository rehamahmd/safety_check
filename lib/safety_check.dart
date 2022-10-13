import 'safety_check_platform_interface.dart';

class SafetyCheck {
  Future<bool> checkSafety() {
    return SafetyCheckPlatform.instance.checkSafety();
  }

  Future<bool?> isTampred(String sha) {
    return SafetyCheckPlatform.instance.isTampred(sha);
  }

  Future<bool?> isDebuggable() {
    return SafetyCheckPlatform.instance.isDebuggable();
  }

  Future<bool?> isHooked() {
    return SafetyCheckPlatform.instance.isHooked();
  }

  Future<bool?> isEmulator() {
    return SafetyCheckPlatform.instance.isEmulator();
  }

  Future<bool?> isRooted() {
    return SafetyCheckPlatform.instance.isRooted();
  }
}
