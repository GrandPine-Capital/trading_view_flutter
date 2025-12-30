import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:trading_view_flutter/src/model/theme.dart';
import 'package:trading_view_flutter/src/model/trading_view_data.dart';
import 'package:trading_view_flutter/src/trading_view_js_interopt.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewEmbedder {
  static TradingViewEmbedder get instance => TradingViewEmbedder.create();

  TradingViewEmbedder._();
  TradingViewEmbedder.create() : this._();

  WebViewController? _controller;
  WebViewController get controller {
    if (_controller == null) {
      throw StateError('TradingViewEmbedderController 尚未初始化，请先调用 onLoad()。');
    }
    return _controller!;
  }

  bool get isInitialized => _controller != null;

  @mustCallSuper
  Future<void> onLoad({
    required TradingViewData tradingViewData,
    void Function(int)? onProgress,
    void Function(String)? onPageFinished,
    void Function(HttpResponseError)? onHttpError,
    void Function(WebResourceError)? onWebResourceError,
    FutureOr<NavigationDecision> Function(NavigationRequest request)?
    onNavigationRequest,
  }) async {
    assert(tradingViewData.toJson().isNotEmpty, 'TradingViewData 不可为空');

    final tradingViewWCode = TradingViewJsInteropt.getTradingViewWCode(
      tradingViewData: tradingViewData,
    );

    if (kDebugMode) {
      debugPrint('TradingViewWCode: $tradingViewWCode');
    }

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        tradingViewData.theme == TradingViewTheme.dark
            ? Colors.black
            : Colors.white,
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: onProgress,
          onPageFinished: onPageFinished,
          onHttpError: onHttpError,
          onWebResourceError: onWebResourceError,
          onNavigationRequest: onNavigationRequest,
        ),
      )
      ..loadHtmlString(tradingViewWCode);
  }
}
