import 'package:flutter/services.dart';

class ScreenSecurityService {
  static const _channel = MethodChannel('com.fiore.cv_mobile_app/screen_security');

  /// Callback invoked when iOS detects a screenshot was taken while secure mode is active.
  static VoidCallback? onScreenshotDetected;

  static bool _listenerRegistered = false;

  static void _ensureListener() {
    if (_listenerRegistered) return;
    _listenerRegistered = true;
    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onScreenshotDetected') {
        onScreenshotDetected?.call();
      }
    });
  }

  static Future<void> enableSecure() async {
    _ensureListener();
    try {
      await _channel.invokeMethod('enableSecure');
    } on MissingPluginException {
      // Not implemented on this platform — ignore
    }
  }

  static Future<void> disableSecure() async {
    try {
      await _channel.invokeMethod('disableSecure');
    } on MissingPluginException {
      // Not implemented on this platform — ignore
    }
  }
}
