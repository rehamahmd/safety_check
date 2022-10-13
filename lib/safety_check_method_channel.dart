import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'safety_check_platform_interface.dart';

/// An implementation of [SafetyCheckPlatform] that uses method channels.
class MethodChannelSafetyCheck extends SafetyCheckPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('safety_check');

  @override
  Future<bool> checkSafety() async {
    final isSafe = await methodChannel.invokeMethod<bool?>('checkSafety');
    return isSafe ?? true; // TODO
  }

  @override
  Future<bool?> isTampred(String sha) async {
    final isTampred = await methodChannel.invokeMethod<bool?>('isTampered', {'sha': sha});
    return isTampred;
  }

  @override
  Future<bool?> isDebuggable() async {
    final isDebuggable = await methodChannel.invokeMethod<bool?>('isDebuggable');
    return isDebuggable;
  }

  @override
  Future<bool?> isEmulator() async {
    final isEmulator = await methodChannel.invokeMethod<bool?>('isEmulator');
    return isEmulator;
  }

  @override
  Future<bool?> isHooked() async {
    final isHooked = await methodChannel.invokeMethod<bool?>('isHooked');
    return isHooked;
  }

  @override
  Future<bool?> isRooted() async {
    final isRooted = await methodChannel.invokeMethod<bool?>('isRooted');
    return isRooted;
  }
}
