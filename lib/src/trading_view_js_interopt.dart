import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:trading_view_flutter/trading_view_flutter.dart';

class TradingViewJsInteropt {
  static String getTradingViewWCode({
    required TradingViewData tradingViewData,
    String? footer = '',
  }) {
    final logger = Logger();

    if (kDebugMode) {
      logger.d('TradingViewWCode: ${tradingViewData.toString()}');
    }

    final jsonString = jsonEncode(tradingViewData.toJson());

    if (tradingViewData.isLightWeightChart!) {
      final chartDataJson = jsonEncode(
        tradingViewData.chartValue?.map((item) => item.toJson()).toList() ?? [],
      );

      final indicatorJson = jsonEncode(
        tradingViewData.indicators?.map((item) => item.toJson()).toList() ?? [],
      );

      final volumeDataJson = jsonEncode(
        tradingViewData.volume?.map((item) => item.toJson()).toList() ?? [],
      );

      final indicatorImagesJson = jsonEncode(
        tradingViewData.indicatorImages
                ?.map((item) => item.toJson())
                .toList() ??
            [],
      );

      if (kDebugMode) {
        logger.d('chartValue: $chartDataJson');
        logger.d('indicators: $indicatorJson');
        logger.d('volume: $volumeDataJson');
        logger.d('indicatorImages: $indicatorImagesJson');
      }

      if (tradingViewData.tradingViewChartType == TradingViewChartType.bar) {
        return '''
          <div class="tradingview-widget-container__widget" 
            style="
              border: 1px solid #888;  
              box-shadow: 0 2px 6px rgba(0,0,0,0.1);
              background: ${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'};
            ">
            <div id="symbol" style="font-size:16px; font-weight:bold; margin-bottom:5px; margin-top:10px; margin-left:10px; color: ${tradingViewData.theme == TradingViewTheme.light ? 'black' : 'white'};">
              ${tradingViewData.symbol}
            </div>

            <div id="container" style="width:100%; height:250px;"></div>

            <script src="${Constant.tradingLightChartWidgetUrl}"></script>
            <script>
              (function initFixedTopChart() {
                const container = document.getElementById('container');
                
                const chartOptions = {
                  layout: {
                    textColor: '${(tradingViewData.theme == TradingViewTheme.light ? 'black' : 'white')}',
                    background: { type: 'solid', color: '${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'}' }
                  },
                  grid: { 
                    vertLines: { visible: false }, 
                    horzLines: { visible: false } 
                  },
                  timeScale: {
                    shiftVisibleRangeOnNewBar: true,
                    barSpacing: 12, 
                    minBarSpacing: 5,
                    fixLeftEdge: false,
                    fixRightEdge: true,
                    uniformDistribution: true, 
                  },
                  rightPriceScale: {
                    autoScale: true,
                    alignLabels: true,
                    scaleMargins: {
                      top: 0.1,
                      bottom: 0.3,
                    },
                  },
                  handleScroll: {
                    mouseWheel: true,
                    pressedMouseMove: true,
                    horzTouchDrag: true,
                    vertTouchDrag: true,
                  },
                  handleScale: {
                    axisPressedMouseMove: true,
                    mouseWheel: true,
                    pinch: true,
                  },
                };

                const chart = LightweightCharts.createChart(container, chartOptions);

                const mainSeries = chart.addBarSeries({
                  upColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#ef5350' : '#26a69a'}',
                  downColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#26a69a' : '#ef5350'}',
                  thinBars: false
                });

                const volumeSeries = chart.addHistogramSeries({
                  priceScaleId: 'volume',
                  priceFormat: { type: 'volume' },
                });

                chart.priceScale('volume').applyOptions({
                  scaleMargins: { top: 0.8, bottom: 0 },
                  visible: false,
                });

                const highlightSeries = chart.addHistogramSeries({
                  priceScaleId: 'overlay',
                  lastValueVisible: false,
                  priceLineVisible: false,
                });

                chart.priceScale('overlay').applyOptions({
                  scaleMargins: { top: 0, bottom: 0 }, 
                  visible: false,
                });

                const data = $chartDataJson;
                const volumeRaw = $volumeDataJson;
                const rawIndicators = $indicatorJson;

                const indicators = rawIndicators.map(ind => {
                  const d = new Date(ind.time);
                  return {
                    ...ind,
                    time: d.toISOString().split('T')[0]
                  };
                });

                const volumeData = volumeRaw.map(item => ({
                  time: new Date(item.time).toISOString().split('T')[0],
                  value: item.volume,
                  color: item.color || 'rgba(38, 166, 154, 0.5)',
                }));

                const highlightData = [];
                const quarterMarkers = [];

                mainSeries.setData(data);
                volumeSeries.setData(volumeData);

                data.forEach((item, index) => {
                  const date = new Date(item.time); 
                  const month = date.getUTCMonth();
                  const q = Math.floor(month / 3) + 1;
                  
                  const colors = [
                    'rgba(33, 150, 243, 0.05)', 
                    'rgba(76, 175, 80, 0.05)', 
                    'rgba(255, 152, 0, 0.05)', 
                    'rgba(156, 39, 176, 0.05)'
                  ];
                  
                  highlightData.push({ time: item.time, value: 1, color: colors[q-1] });

                  const prevDateStr = index > 0 ? data[index-1].time : null;
                  const prevQ = prevDateStr ? Math.floor(new Date(prevDateStr).getUTCMonth() / 3) + 1 : -1;

                  if (q !== prevQ) {
                    quarterMarkers.push({
                      time: item.time,
                      position: 'aboveBar', 
                      color: '${tradingViewData.theme == TradingViewTheme.light ? '#666' : '#ccc'}',
                      shape: 'text',
                      text: '${tradingViewData.locale == 'zh' ? '季度 ' : 'Q '}' + q,
                      backgroundColor: '${tradingViewData.theme == TradingViewTheme.light ? 'rgba(0,0,0,0.1)' : 'rgba(255,255,255,0.1)'}',
                    });
                  }
                });

                highlightSeries.setData(highlightData);

                const allMarkers = [...indicators, ...quarterMarkers].sort((a, b) => {
                  return new Date(a.time).getTime() - new Date(b.time).getTime();
                });

                mainSeries.setMarkers(allMarkers); 

                setTimeout(() => {
                  chart.timeScale().fitContent();
                }, 150);

                window.addEventListener('resize', () => {
                  chart.applyOptions({ width: container.clientWidth });
                  chart.timeScale().fitContent();
                });
              })();
            </script>
          </div>
        ''';
      } else if (tradingViewData.tradingViewChartType ==
          TradingViewChartType.candlestick) {
        return '''
          <div class="tradingview-widget-container__widget" 
            style="
              border: 1px solid #888;  
              box-shadow: 0 2px 6px rgba(0,0,0,0.1);
              background: ${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'};
            ">
            <div id="symbol" style="font-size:16px; font-weight:bold; margin-bottom:5px; margin-top:10px; margin-left:10px; color: ${tradingViewData.theme == TradingViewTheme.light ? 'black' : 'white'};">
              ${tradingViewData.symbol}
            </div>

            <div id="container" style="width:100%; height:250px;"></div>

            <script src="${Constant.tradingLightChartWidgetUrl}"></script>
            <script>
              (function initFixedTopChart() {
                const container = document.getElementById('container');
                
                const chartOptions = {
                  layout: {
                      textColor: '${(tradingViewData.theme == TradingViewTheme.light ? 'black' : 'white')}',
                      background: { type: 'solid', color: '${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'}' }
                  },
                  grid: { 
                      vertLines: { visible: false }, 
                      horzLines: { visible: false } 
                  },
                  timeScale: {
                    shiftVisibleRangeOnNewBar: true,
                    barSpacing: 12, 
                    minBarSpacing: 5,
                    fixLeftEdge: false,
                    fixRightEdge: true,
                    uniformDistribution: true, 
                  },
                  rightPriceScale: {
                      autoScale: true,
                      alignLabels: true,
                  },
                  handleScroll: {
                    mouseWheel: true,
                    pressedMouseMove: true,
                    horzTouchDrag: true,
                    vertTouchDrag: true,
                  },
                  handleScale: {
                    axisPressedMouseMove: true,
                    mouseWheel: true,
                    pinch: true,
                  },
                };

                const chart = LightweightCharts.createChart(container, chartOptions);

                ${(() {
          if (indicatorImagesJson.isNotEmpty) {
            return '''
            let noteElemetns = [];
            
            
            ''';
          }
        }())}

                const mainSeries = chart.addCandlestickSeries({
                  upColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#ef5350' : '#26a69a'}',
                  downColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#26a69a' : '#ef5350'}',
                  borderVisible: false,
                  wickUpColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#ef5350' : '#26a69a'}',
                  wickDownColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#26a69a' : '#ef5350'}'
                });

                const highlightSeries = chart.addHistogramSeries({
                  priceScaleId: 'overlay',
                  lastValueVisible: false,
                  priceLineVisible: false,
                });

                const volumeSeries = chart.addHistogramSeries({
                  priceScaleId: 'volume',
                  priceFormat: { type: 'volume' },
                });

                chart.priceScale('volume').applyOptions({
                  scaleMargins: { top: 0.7, bottom: 0 },
                  visible: false,
                });

                chart.priceScale('overlay').applyOptions({
                  scaleMargins: { top: 0.1, bottom: 0 }, 
                  visible: false,
                });

                const data = $chartDataJson;
                const volumeRaw = $volumeDataJson;
                const rawIndicators = $indicatorJson;
                const indicators = rawIndicators.map(ind => {
                  const d = new Date(ind.time);
                  const dateStr = d.toISOString().split('T')[0];
                  return {
                    ...ind,
                    time: dateStr
                  };
                });
                const volumeData = volumeRaw.map(item => ({
                  time: new Date(item.time).toISOString().split('T')[0],
                  value: item.volume,
                  color: item.color,
                }));

                const highlightData = [];
                const quarterMarkers = [];

                mainSeries.setData(data);
                volumeSeries.setData(volumeData);

                data.forEach((item, index) => {
                  const date = new Date(item.time); 
                  const month = date.getUTCMonth();
                  const q = Math.floor(month / 3) + 1;
                  
                  const colors = [
                    'rgba(33, 150, 243, 0.05)', 
                    'rgba(76, 175, 80, 0.05)', 
                    'rgba(255, 152, 0, 0.05)', 
                    'rgba(156, 39, 176, 0.05)'
                  ];
                  
                  highlightData.push({ time: item.time, value: 1, color: colors[q-1] });

                  const prevDateStr = index > 0 ? data[index-1].time : null;
                  const prevQ = prevDateStr ? Math.floor(new Date(prevDateStr).getUTCMonth() / 3) + 1 : -1;

                  if (q !== prevQ) {
                    quarterMarkers.push({
                      time: item.time,
                      position: 'aboveBar', 
                      color: '${tradingViewData.theme == TradingViewTheme.light ? '#666' : '#ccc'}',
                      shape: 'text',
                      text: '${tradingViewData.locale == 'zh' ? '季度 ' : 'Q '}' + q,
                      backgroundColor: '${tradingViewData.theme == TradingViewTheme.light ? 'rgba(0,0,0,0.1)' : 'rgba(255,255,255,0.1)'}',
                    });
                  }
                });

                highlightSeries.setData(highlightData);

                const allMarkers = [...indicators, ...quarterMarkers].sort((a, b) => {
                  return new Date(a.time).getTime() - new Date(b.time).getTime();
                });

                mainSeries.setMarkers(allMarkers); 

                setTimeout(() => {
                  chart.timeScale().fitContent();
                }, 100);

                window.addEventListener('resize', () => {
                  chart.applyOptions({ width: container.clientWidth });
                  if (chart.timeScale().options().barSpacing > 15) {
                    chart.timeScale().applyOptions({ barSpacing: 10 });
                  }
                  chart.timeScale().fitContent();
                });
              })();
            </script>
          </div>
        ''';
      }

      return '''
          <div style="
            display:flex; 
            align-items:center; 
            justify-content:center; 
            height:250px; 
            font-size:18px; 
            color:#999; 
            background:#f7f7f7; 
            border-radius:8px;">
            <span>🌈 图表类型暂不支持，敬请期待</span>
          </div>
      ''';
    } else {
      return '''
      <div>
        <div class="tradingview-widget-container__widget" ></div>
        <div class="tradingview-widget-copyright">
          <a href="https://www.tradingview.com/" rel="noopener nofollow" target="_blank">
            <span class="blue-text">$footer</span>
          </a>
        </div>
        <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js" async>
          $jsonString
        </script>
      </div>
    ''';
    }
  }
}
