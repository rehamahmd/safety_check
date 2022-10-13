import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:safety_check/safety_check_method_channel.dart';

void main() {
  MethodChannelSafetyCheck platform = MethodChannelSafetyCheck();
  const MethodChannel channel = MethodChannel('safety_check');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('checkSafety', () async {
    expect(await platform.checkSafety(), '42');
  });
}
