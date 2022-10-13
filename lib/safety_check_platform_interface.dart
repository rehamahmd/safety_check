import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'safety_check_method_channel.dart';

abstract class SafetyCheckPlatform extends PlatformInterface {
  /// Constructs a SafetyCheckPlatform.
  SafetyCheckPlatform() : super(token: _token);

  static final Object _token = Object();

  static SafetyCheckPlatform _instance = MethodChannelSafetyCheck();

  /// The default instance of [SafetyCheckPlatform] to use.
  ///
  /// Defaults to [MethodChannelSafetyCheck].
  static SafetyCheckPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SafetyCheckPlatform] when
  /// they register themselves.
  static set instance(SafetyCheckPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> checkSafety() {
    throw UnimplementedError('checkSafety() has not been implemented.');
  }

  Future<bool?> isTampred(String sha) {
    throw UnimplementedError('isTampred() has not been implemented.');
  }

  Future<bool?> isDebuggable() {
    throw UnimplementedError('isTampred() has not been implemented.');
  }

  Future<bool?> isEmulator() {
    throw UnimplementedError('isEmulator() has not been implemented.');
  }

  Future<bool?> isHooked() {
    throw UnimplementedError('isHooked() has not been implemented.');
  }

  Future<bool?> isRooted() {
    throw UnimplementedError('isRooted() has not been implemented.');
  }
}
