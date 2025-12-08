import 'package:flutter/material.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

class TradingViewExample extends StatelessWidget {
  const TradingViewExample({super.key});

  @override
  Widget build(BuildContext context) {
    final tradingData = TradingViewData(
      id: 0,
      symbol: 'SZSE:002594',
      autosize: true,
      interval: TradingViewInterval.M,
      timezone: 'Asia/Shanghai',
      theme: TradingViewTheme.light,
      style: '1',
      locale: 'zh',
      hideTopToolbar: true,
      allowSymbolChange: false,
      saveImage: false,
      showCalendar: true,
      hideVolume: false,
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('TradingView Example')),
        body: Center(child: TradingViewWidget(data: tradingData)),
      ),
    );
  }
}
