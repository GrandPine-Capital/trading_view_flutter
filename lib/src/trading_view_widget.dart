import 'package:flutter/material.dart';
import 'package:trading_view_flutter/src/model/trading_view_data.dart';
import 'package:trading_view_flutter/src/trading_view_embedder.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'model/theme.dart';

class TradingViewWidget extends StatefulWidget {
  final double width;
  final double height;
  final TradingViewData data;

  TradingViewWidget({
    super.key,
    this.width = 1200,
    this.height = 600,
    required this.data,
  }) : assert(data.toJson().isNotEmpty, 'TradingViewData 不可为空');

  @override
  State<TradingViewWidget> createState() => _TradingViewWidgetState();
}

class _TradingViewWidgetState extends State<TradingViewWidget> {
  final tradingViewEmbedder = TradingViewEmbedder.instance;

  @override
  void initState() {
    super.initState();

    tradingViewEmbedder.onLoad(tradingViewData: widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.data.theme == TradingViewTheme.dark
          ? Colors.black
          : Colors.white,
      body: SizedBox(
        height: widget.height,
        width: widget.width,
        child: WebViewWidget(
          key: widget.key,
          controller: tradingViewEmbedder.controller,
        ),
      ),
    );
  }
}
