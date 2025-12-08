import 'package:flutter/material.dart';
import 'package:trading_view_flutter/src/model/theme.dart';
import 'package:trading_view_flutter/src/model/trading_view_data.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewEmbedder {
  static TradingViewEmbedder get instance => TradingViewEmbedder.create();

  TradingViewEmbedder._();
  TradingViewEmbedder.create() : this._();

  late WebViewController controller;

  @mustCallSuper
  Future<void> onLoad({required TradingViewData tradingViewData}) async {
    assert(tradingViewData.toJson().isNotEmpty, 'TradingViewData 不可为空');

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        tradingViewData.theme == TradingViewTheme.dark
            ? Colors.black
            : Colors.white,
      )
      ..setNavigationDelegate(NavigationDelegate());
  }
}
