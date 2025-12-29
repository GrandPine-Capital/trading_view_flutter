import 'package:flutter/material.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

class TradingViewExample extends StatefulWidget {
  const TradingViewExample({super.key});

  @override
  State<TradingViewExample> createState() => _TradingViewExampleState();
}

class _TradingViewExampleState extends State<TradingViewExample> {
  final ValueNotifier<TradingViewTheme> _themeNotifier = ValueNotifier(
    TradingViewTheme.light,
  );

  @override
  void dispose() {
    _themeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fakeChartData = <TradingViewChartData>[
      TradingViewChartData(
        time: DateTime(2025, 12, 10),
        open: 40.50,
        high: 45.20,
        low: 38.10,
        close: 42.80,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 11),
        open: 43.00,
        high: 47.50,
        low: 41.80,
        close: 46.20,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 12),
        open: 46.50,
        high: 50.30,
        low: 44.90,
        close: 49.10,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 13),
        open: 49.50,
        high: 53.80,
        low: 48.20,
        close: 52.40,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 14),
        open: 52.80,
        high: 57.20,
        low: 51.50,
        close: 56.00,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 15),
        open: 56.40,
        high: 60.90,
        low: 55.20,
        close: 59.80,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 16),
        open: 60.20,
        high: 64.70,
        low: 59.00,
        close: 63.50,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 17),
        open: 63.90,
        high: 68.40,
        low: 62.80,
        close: 67.20,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 18),
        open: 67.60,
        high: 72.10,
        low: 66.40,
        close: 70.90,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 19),
        open: 71.30,
        high: 75.80,
        low: 70.10,
        close: 74.60,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 20),
        open: 74.90,
        high: 79.40,
        low: 73.70,
        close: 78.20,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 21),
        open: 78.50,
        high: 83.00,
        low: 77.30,
        close: 81.80,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 22),
        open: 75.16,
        high: 82.84,
        low: 36.16,
        close: 45.72,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 23),
        open: 45.12,
        high: 53.90,
        low: 45.12,
        close: 48.09,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 24),
        open: 60.71,
        high: 60.71,
        low: 53.39,
        close: 59.29,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 25),
        open: 68.26,
        high: 68.26,
        low: 59.04,
        close: 60.50,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 26),
        open: 67.71,
        high: 105.85,
        low: 66.67,
        close: 91.04,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 27),
        open: 91.04,
        high: 121.40,
        low: 82.70,
        close: 111.40,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 28),
        open: 111.51,
        high: 142.83,
        low: 103.34,
        close: 131.25,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 29),
        open: 131.33,
        high: 151.17,
        low: 77.68,
        close: 96.43,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 30),
        open: 106.33,
        high: 110.20,
        low: 90.39,
        close: 98.10,
      ),
      TradingViewChartData(
        time: DateTime(2025, 12, 31),
        open: 50.87,
        high: 114.69,
        low: 30.66,
        close: 111.26,
      ),
    ];

    return MaterialApp(
      home: Scaffold(
        body: ValueListenableBuilder<TradingViewTheme>(
          valueListenable: _themeNotifier,
          builder: (context, theme, child) {
            return _buildContent(theme, fakeChartData);
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    TradingViewTheme theme,
    List<TradingViewChartData> fakeChartData,
  ) {
    final tradingData = TradingViewData(
      id: 0,
      symbol: 'SZSE:002594',
      autosize: true,
      interval: TradingViewInterval.month,
      timezone: 'Asia/Shanghai',
      theme: theme,
      style: '1',
      locale: TradingLocale.chinese.toLocaleString(),
      hideTopToolbar: true,
      allowSymbolChange: false,
      saveImage: false,
      showCalendar: true,
      hideVolume: false,
      isLightWeightChart: false,
      tradingViewChartType: TradingViewChartType.candlestick,
    );

    final tradingDataLight = TradingViewData(
      id: 0,
      symbol: 'SZSE:002594',
      autosize: true,
      interval: TradingViewInterval.month,
      timezone: 'Asia/Shanghai',
      theme: theme,
      style: '1',
      locale: 'zh',
      hideTopToolbar: true,
      allowSymbolChange: false,
      saveImage: false,
      showCalendar: true,
      hideVolume: false,
      isLightWeightChart: true,
      tradingViewChartType: TradingViewChartType.candlestick,
      chartValue: fakeChartData,
    );

    final tradingDataBar = TradingViewData(
      id: 0,
      symbol: 'SZSE:002594',
      autosize: true,
      interval: TradingViewInterval.month,
      timezone: 'Asia/Shanghai',
      theme: theme,
      style: '1',
      locale: 'zh',
      hideTopToolbar: true,
      allowSymbolChange: false,
      saveImage: false,
      showCalendar: true,
      hideVolume: false,
      isLightWeightChart: true,
      tradingViewChartType: TradingViewChartType.bar,
      chartValue: fakeChartData,
    );

    return Scaffold(
      backgroundColor: theme == TradingViewTheme.light
          ? Colors.white
          : Colors.black,
      appBar: AppBar(
        title: const Text(
          'TradingView 示例',
          style: TextStyle(color: Colors.grey),
        ),
        backgroundColor: theme == TradingViewTheme.light
            ? Colors.white
            : Colors.black,
        actions: [
          Switch(
            value: theme == TradingViewTheme.dark,
            onChanged: (value) {
              _themeNotifier.value = value
                  ? TradingViewTheme.dark
                  : TradingViewTheme.light;
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Text(
            '默认TradingView图',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300,
              child: TradingViewWidget(
                key: ValueKey('trading_view_${theme.name}'),
                data: tradingData,
                width: 600,
                height: 300,
              ),
            ),
          ),

          SizedBox(height: 30),
          Text(
            'Lightweight级蜡烛图',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300,
              child: TradingViewWidget(
                key: ValueKey('trading_view_light_${theme.name}'),
                data: tradingDataLight,
                width: 600,
                height: 300,
              ),
            ),
          ),
          SizedBox(height: 30),
          Text(
            'Lightweight柱状图',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 300,
              child: TradingViewWidget(
                key: ValueKey('trading_view_light_${theme.name}'),
                data: tradingDataBar,
                width: 600,
                height: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
