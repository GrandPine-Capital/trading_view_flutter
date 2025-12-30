import 'dart:convert';

import 'package:trading_view_flutter/src/model/chart_indicator.dart';
import 'package:trading_view_flutter/src/model/chart_type.dart';
import 'package:trading_view_flutter/src/model/chart_region.dart';
import 'package:trading_view_flutter/src/config/constant.dart';
import 'package:trading_view_flutter/src/model/interval.dart';
import 'package:trading_view_flutter/src/model/theme.dart';
import 'package:trading_view_flutter/src/model/trading_view_chart_data.dart';

/// [TradingViewData]
///  TradingView 数据模型
///
///  K线数据模型
///   本模型遵循金融市场数据标准，用于表示标准化K线数据。
///
/// [id] 图表数据ID
/// [symbol] 股票代码符号
/// [autosize] 如果为true，TradingView将自动调整视图以适应父容器
/// [interval] 图表时间间隔，参考[TradingViewInterval]
/// [timezone] 图表时区（IANA时区标识符），默认"Asia/Shanghai"
/// [theme] 图表主题，参考[TradingViewTheme]
/// [style] 图表样式（例如："1"表示蜡烛图，"2"表示线图等）
/// [locale] 图表语言区域（例如："zh_CN"表示中文）ISO 639
/// [hideTopToolbar] 如果为true，隐藏顶部工具栏
/// [allowSymbolChange] 如果为true，允许更改股票代码
/// [saveImage] 如果为true，启用保存图片功能
/// [showCalendar] 如果为true，显示经济日历
/// [hideVolume] 如果为true，隐藏成交量指标
/// [showDrawingToolBar] 如果为true，显示绘图工具栏
/// [showComprehennsiveDetails] 如果为true，显示综合详细信息
/// [supportHost] 图表支持的主机URL
/// [isLightWeightChart] 如果为true，使用轻量级图表版本
/// [chartRegion] 图表区域（例如："CN"表示中国），参考[ChartRegion]
/// [tradingViewChartType] 图表类型（例如："advanced"高级版，"basic"基础版），参考[TradingViewChartType]
/// [chartValue] 图表数据点列表，参考[TradingViewChartData]

class TradingViewData {
  final int? id;
  final String symbol;
  final bool autosize;
  final String? interval;
  final String? timezone;
  final TradingViewTheme? theme;
  final String? style;
  final String? locale;
  final bool? hideTopToolbar;
  final bool? allowSymbolChange;
  final bool? saveImage;
  final bool? showCalendar;
  final bool? hideVolume;
  final bool? showDrawingToolBar;
  final bool? showComprehennsiveDetails;
  final String? supportHost;
  final bool? isLightWeightChart;
  final ChartRegion? chartRegion;
  final TradingViewChartType? tradingViewChartType;
  final List<TradingViewChartData>? chartValue;
  final List<ChartIndicator>? indicators;

  TradingViewData({
    this.id,
    required this.symbol,
    this.autosize = true,
    this.interval = TradingViewInterval.day,
    this.timezone = 'Asia/Shanghai',
    this.theme = TradingViewTheme.light,
    this.style = '1',
    this.locale = 'zh',
    this.hideTopToolbar = false,
    this.allowSymbolChange = true,
    this.saveImage = false,
    this.showCalendar = false,
    this.hideVolume = false,
    this.showDrawingToolBar = false,
    this.showComprehennsiveDetails = false,
    this.supportHost = Constant.tradingViewUrl,
    this.isLightWeightChart = false,
    this.chartRegion = ChartRegion.china,
    this.tradingViewChartType = TradingViewChartType.candlestick,
    this.chartValue,
    this.indicators = const [],
  }) : assert(symbol.isNotEmpty, 'symbol 不能为空');

  factory TradingViewData.fromJson(Map<String, dynamic> json) {
    if (json['isLightWeightChart'] == true && json['chartValue'] == null) {
      assert(
        json['chartValue'].isNotEmpty,
        'chartValue 不可为空，因为您将轻量级图表设置为 true',
      );
    }

    TradingViewData data = TradingViewData(
      id: json['id'],
      symbol: json['symbol'],
      autosize: json['autosize'],
      interval: json['interval'],
      timezone: json['timezone'],
      theme: json['theme'],
      style: json['style'],
      locale: json['locale'],
      hideTopToolbar: json['hide_top_toolbar'],
      allowSymbolChange: json['allow_symbol_change'],
      saveImage: json['save_image'],
      showComprehennsiveDetails: json['show_comprehensive_details'],
      showCalendar: json['show_calendar'],
      hideVolume: json['hide_volume'],
      supportHost: json['support_host'],
      isLightWeightChart: json['isLightWeightChart'],
      chartValue: json['chartValue'] != null
          ? (json['chartValue'] as List<dynamic>).map((item) {
              final Map<String, dynamic> decodedMap = jsonDecode(
                item as String,
              );
              return TradingViewChartData.fromJson(decodedMap);
            }).toList()
          : null,
      chartRegion: json['chartRegion'],
      showDrawingToolBar: json['showDrawingToolBar'],
      indicators: json['indicators'] != null
          ? (json['indicators'] as List<dynamic>).map((item) {
              if (item is String) {
                final Map<String, dynamic> decodedMap = jsonDecode(item);
                return ChartIndicator.fromJson(decodedMap);
              } else if (item is Map<String, dynamic>) {
                return ChartIndicator.fromJson(item);
              }
              throw FormatException('Invalid indicator format');
            }).toList()
          : null,
    );

    return data;
  }

  Map<String, Object> toJson() {
    Map<String, Object> data = {
      'id': id ?? 0,
      'symbol': symbol,
      'autosize': autosize,
      'interval': interval ?? TradingViewInterval.day,
      'timezone': timezone ?? 'Asia/Shanghai',
      'theme': theme?.name ?? TradingViewTheme.light.name,
      'style': style ?? '1',
      'locale': locale ?? 'zh',
      'hide_top_toolbar': hideTopToolbar ?? false,
      'allow_symbol_change': allowSymbolChange ?? true,
      'save_image': saveImage ?? false,
      'details': showComprehennsiveDetails ?? false,
      'show_calendar': showCalendar ?? false,
      'hide_volume': hideVolume ?? false,
      'support_host': supportHost ?? Constant.tradingViewUrl,
      'hide_side_toolbar': !showDrawingToolBar!,
    };

    return data;
  }

  @override
  String toString() {
    return 'TradingViewData{id: $id, symbol: $symbol, autosize: $autosize, interval: $interval, timezone: $timezone, theme: $theme, style: $style, locale: $locale, hideTopToolbar: $hideTopToolbar, allowSymbolChange: $allowSymbolChange, saveImage: $saveImage, showCalendar: $showCalendar, hideVolume: $hideVolume, supportHost: $supportHost}, indicators: $indicators';
  }
}
