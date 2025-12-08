import 'package:flutter/material.dart';
import 'package:trading_view_flutter/src/model/trading_view_data.dart';
import 'package:trading_view_flutter/src/trading_view_embedder.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TradingViewWidget extends StatefulWidget {
  final double width;
  final double height;
  final TradingViewData data;

  const TradingViewWidget({
    super.key,
    this.width = 500,
    this.height = 100,
    required this.data,
  });

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
