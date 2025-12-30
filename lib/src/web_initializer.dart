import 'package:flutter/foundation.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_web/webview_flutter_web.dart';

class WebInitializer {
  static void initialize() {
    if (kIsWeb) {
      WebViewPlatform.instance = WebWebViewPlatform();
    }
  }
}
