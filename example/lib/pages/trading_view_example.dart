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

  final ValueNotifier<ChartRegion> _chartRegionNotifier = ValueNotifier(
    ChartRegion.china,
  );

  @override
  void dispose() {
    _themeNotifier.dispose();
    _chartRegionNotifier.dispose();
    super.dispose();
  }

  /// 核心交易标记 - 关键转折点
  final indicators = <ChartIndicator>[
    ChartIndicator(
      id: 0,
      color: '#4CAF50',
      text: '支撑',
      timestamp: DateTime(2025, 12, 13).millisecondsSinceEpoch,
      displayPosition: 'belowBar',
    ),
    ChartIndicator(
      id: 1,
      color: '#F44336',
      text: '阻力',
      timestamp: DateTime(2025, 12, 18).millisecondsSinceEpoch,
      displayPosition: 'aboveBar',
    ),
    ChartIndicator(
      id: 2,
      color: '#FF9800',
      text: '突破',
      shape: 'arrowUp',
      timestamp: DateTime(2025, 12, 20).millisecondsSinceEpoch,
      displayPosition: 'aboveBar',
    ),
  ];

  /// 真实波动数据 - 模拟科技股高波动性走势
  final fakeChartData = <TradingViewChartData>[
    // 底部震荡 - 高波动吸筹
    TradingViewChartData(
      time: DateTime(2025, 12, 1),
      open: 45.2,
      high: 47.8,
      low: 43.1,
      close: 44.9,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 3),
      open: 46.3,
      high: 48.9,
      low: 44.1,
      close: 47.2,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 5),
      open: 47.1,
      high: 49.5,
      low: 45.2,
      close: 48.8,
    ),

    // 缓慢上升 - 震荡上行
    TradingViewChartData(
      time: DateTime(2025, 12, 7),
      open: 48.7,
      high: 51.8,
      low: 47.2,
      close: 50.1,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 9),
      open: 50.5,
      high: 53.4,
      low: 48.6,
      close: 52.7,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 11),
      open: 52.3,
      high: 56.2,
      low: 50.8,
      close: 54.9,
    ),

    // 突破关键位 - 放量突破
    TradingViewChartData(
      time: DateTime(2025, 12, 13),
      open: 55.9,
      high: 61.2,
      low: 54.4,
      close: 59.1,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 14),
      open: 58.0,
      high: 63.8,
      low: 56.5,
      close: 61.7,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 15),
      open: 60.3,
      high: 67.1,
      low: 58.8,
      close: 65.4,
    ),

    // 加速上涨 - 连续拉升
    TradingViewChartData(
      time: DateTime(2025, 12, 17),
      open: 66.0,
      high: 74.8,
      low: 63.5,
      close: 71.2,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 18),
      open: 69.5,
      high: 78.6,
      low: 66.9,
      close: 75.8,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 19),
      open: 73.3,
      high: 82.8,
      low: 70.7,
      close: 79.4,
    ),

    // 回调整理 - 深度回调
    TradingViewChartData(
      time: DateTime(2025, 12, 22),
      open: 79.8,
      high: 83.4,
      low: 71.1,
      close: 73.2,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 24),
      open: 76.2,
      high: 79.8,
      low: 68.5,
      close: 70.6,
    ),

    // 再次启动 - 爆发性上涨
    TradingViewChartData(
      time: DateTime(2025, 12, 28),
      open: 83.2,
      high: 95.9,
      low: 80.6,
      close: 92.4,
    ),
    TradingViewChartData(
      time: DateTime(2025, 12, 31),
      open: 101.0,
      high: 145.8,
      low: 97.4,
      close: 138.7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ValueListenableBuilder<TradingViewTheme>(
          valueListenable: _themeNotifier,
          builder: (context, theme, child) {
            return ValueListenableBuilder<ChartRegion>(
              valueListenable: _chartRegionNotifier,
              builder: (context, region, child) {
                return _buildContent(theme, fakeChartData, region);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(
    TradingViewTheme theme,
    List<TradingViewChartData> fakeChartData,
    ChartRegion region,
  ) {
    final tradingData = TradingViewData(
      id: 0,
      symbol: '1810',
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
      chartRegion: region,
    );

    final tradingDataLight = TradingViewData(
      id: 1,
      symbol: 'HKEX-1810',
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
      chartRegion: region,
      indicators: indicators,
    );

    final tradingDataBar = TradingViewData(
      id: 2,
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
      chartRegion: region,

      indicators: indicators,
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
        excludeHeaderSemantics: true,
        animateColor: true,
        scrolledUnderElevation: 0.0,
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: theme == TradingViewTheme.light
            ? Colors.white
            : Colors.black,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: DropdownButton<ChartRegion>(
              value: region,
              underline: const SizedBox(),
              dropdownColor: theme == TradingViewTheme.light
                  ? Colors.white
                  : Colors.grey[900],
              icon: Icon(Icons.arrow_drop_down, color: Colors.grey, size: 24),
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              onChanged: (ChartRegion? newValue) {
                if (newValue != null) {
                  _chartRegionNotifier.value = newValue;
                }
              },
              items: ChartRegion.values.map((ChartRegion region) {
                return DropdownMenuItem<ChartRegion>(
                  value: region,
                  child: Text(
                    region.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      color: theme == TradingViewTheme.light
                          ? Colors.black87
                          : Colors.white,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),

          const SizedBox(width: 8),

          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  theme == TradingViewTheme.dark
                      ? Icons.nightlight_round
                      : Icons.wb_sunny,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Switch(
                  value: theme == TradingViewTheme.dark,
                  onChanged: (value) {
                    _themeNotifier.value = value
                        ? TradingViewTheme.dark
                        : TradingViewTheme.light;
                  },
                  activeThumbColor: Colors.blueAccent,
                  inactiveThumbColor: Colors.amber,
                  inactiveTrackColor: Colors.amber.withValues(alpha: .3),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        child: ListView(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          addAutomaticKeepAlives: true,
          addRepaintBoundaries: true,
          addSemanticIndexes: true,
          clipBehavior: Clip.none,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Colors.grey.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.public, color: Colors.grey, size: 16),
                        const SizedBox(width: 6),
                        Text(
                          region.name,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Container(
              key: const ValueKey('default_chart_container'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      '默认TradingView图',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 300,
                      child: TradingViewWidget(
                        key: ValueKey(
                          'trading_view_${theme.name}_${region.name}',
                        ),
                        data: tradingData,
                        width: 600,
                        height: 300,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
            Container(
              key: const ValueKey('light_candle_container'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      'Lightweight级蜡烛图',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 300,
                      child: TradingViewWidget(
                        key: ValueKey(
                          'trading_view_light_${theme.name}_${region.name}',
                        ),
                        data: tradingDataLight,
                        width: 600,
                        height: 300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              key: const ValueKey('light_bar_container'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 8,
                      bottom: 8,
                    ),
                    child: Text(
                      'Lightweight柱状图',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 300,
                      child: TradingViewWidget(
                        key: ValueKey(
                          'trading_view_light_${theme.name}_${region.name}',
                        ),
                        data: tradingDataBar,
                        width: 600,
                        height: 300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
