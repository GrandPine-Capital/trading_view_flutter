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

      if (kDebugMode) {
        logger.d('chartValue: $chartDataJson');
        logger.d('indicators: $indicatorJson');
      }

      if (tradingViewData.tradingViewChartType == TradingViewChartType.bar) {
        return '''
            <div
            class="tradingview-widget-container__widget" 
              style="
                border:  1px solid #888;  
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                background: ${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'};
              ">
              <div id="symbol" style="font-size:16px; font-weight:bold; margin-bottom:5px; margin-top:10px; margin-left:10px;">
                ${tradingViewData.symbol}
              </div>

              <div id="container" style="width:100%; height:250px;"></div>

              <script src="${Constant.tradingLightChartWidgetUrl}"> </script>
              <script>
                (function initFixedTopChart() {
                    const container = document.getElementById('container');
                    
                    const chartOptions = {
                      layout: {
                        textColor: '${(tradingViewData.theme == TradingViewTheme.light ? 'black' : 'white')}',
                        background: { type: 'solid', color: '${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'}' }
                      }
                    };

                    const chart = LightweightCharts.createChart(
                      document.getElementById('container'),
                      chartOptions
                    );

                    const mainSeries = chart.addBarSeries({
                      upColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#ef5350' : '#26a69a'}',
                      downColor: '${tradingViewData.chartRegion == ChartRegion.china ? '#26a69a' : '#ef5350'}',
                      thinBars: true
                    });

                    const highlightSeries = chart.addHistogramSeries({
                        priceScaleId: 'overlay',
                        lastValueVisible: false,
                        priceLineVisible: false,
                    });

                    chart.priceScale('overlay').applyOptions({
                        scaleMargins: { 
                          top: 0, 
                          bottom: 0 
                        }, 
                        visible: false,
                    });

                    const data = $chartDataJson;
                    const indicators = ${jsonEncode(tradingViewData.indicators?.map((e) => e.toJson()).toList() ?? [])};

                    mainSeries.setData(data);

                    const highlightData = [];
                    const quarterMarkers = [];

                    data.forEach((item, index) => {
                        const date = new Date(item.time * 1000);
                        const month = date.getUTCMonth();
                        const q = Math.floor(month / 3) + 1;
                        
                        const colors = [
                            'rgba(33, 150, 243, 0.08)', 
                            'rgba(76, 175, 80, 0.08)', 
                            'rgba(255, 152, 0, 0.08)', 
                            'rgba(156, 39, 176, 0.08)'
                        ];
                        
                        highlightData.push({ time: item.time, value: 1, color: colors[q-1] });

                        const prevMonth = index > 0 ? new Date(data[index-1].time * 1000).getUTCMonth() : -1;
                        if (q !== (Math.floor(prevMonth / 3) + 1)) {
                            quarterMarkers.push({
                                time: item.time,
                                position: 'aboveBar',
                                color: '#ffffff',
                                shape: 'text',
                                text: '${tradingViewData.locale == 'zh' ? '季度 ' : 'Quater '}' + q
                            });
                        }
                    });

                    mainSeries.setMarkers(indicators);
                    // highlightSeries.setData(highlightData);
                    highlightSeries.setMarkers(quarterMarkers);

                    chart.timeScale().fitContent();

                    window.addEventListener('resize', () => {
                        chart.applyOptions({ width: container.clientWidth });
                    });
                })();
              </script>
            </div>
        ''';
      } else if (tradingViewData.tradingViewChartType ==
          TradingViewChartType.candlestick) {
        return '''
            <div
            class="tradingview-widget-container__widget" 
              style="
                border:  1px solid #888;  
                box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                background: ${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'};
              ">
              <div id="symbol" style="font-size:16px; font-weight:bold; margin-bottom:5px; margin-top:10px; margin-left:10px;">
                ${tradingViewData.symbol}
              </div>

              <div id="container" style="width:100%; height:250px;"></div>

              <script src="${Constant.tradingLightChartWidgetUrl}"> </script>
              <script>

                (function initFixedTopChart() {
                    const container = document.getElementById('container');
                    
                    const chartOptions = {
                      layout: {
                        textColor: '${(tradingViewData.theme == TradingViewTheme.light ? 'black' : 'white')}',
                        background: { type: 'solid', color: ' ${tradingViewData.theme == TradingViewTheme.light ? 'white' : 'black'}' }
                      }
                    };

                    const chart = LightweightCharts.createChart(
                      document.getElementById('container'),
                      chartOptions
                    );

                    const mainSeries =  chart.addCandlestickSeries({
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

                    chart.priceScale('overlay').applyOptions({
                        scaleMargins: { 
                          top: 0, 
                          bottom: 0 
                        }, 
                        visible: false,
                    });

                    const data = $chartDataJson;

                    mainSeries.setData(data);

                    const highlightData = [];
                    const quarterMarkers = [];
                    const indicators = ${jsonEncode(tradingViewData.indicators?.map((e) => e.toJson()).toList() ?? [])};

                    data.forEach((item, index) => {
                        const date = new Date(item.time * 1000);
                        const month = date.getUTCMonth();
                        const q = Math.floor(month / 3) + 1;
                        
                        const colors = [
                            'rgba(33, 150, 243, 0.08)', 
                            'rgba(76, 175, 80, 0.08)', 
                            'rgba(255, 152, 0, 0.08)', 
                            'rgba(156, 39, 176, 0.08)'
                        ];
                        
                        // 每一根K线对应的背景色块，value=1 配合 overlay 轴实现顶格
                        highlightData.push({ time: item.time, value: 1, color: colors[q-1] });

                        // 季度切换检测逻辑
                        const prevMonth = index > 0 ? new Date(data[index-1].time * 1000).getUTCMonth() : -1;
                        if (q !== (Math.floor(prevMonth / 3) + 1)) {
                            quarterMarkers.push({
                                time: item.time,
                                position: 'aboveBar', // 标记在柱体上方，即屏幕最顶端
                                color: '#ffffff',
                                shape: 'text',
                                text: 'Fucking Quater ' + q 
                            });
                        }
                    });

                
                    mainSeries.setMarkers(indicators); 
                    
                    // highlightSeries.setData(highlightData);
                    highlightSeries.setMarkers(quarterMarkers);

                    chart.timeScale().fitContent();
 
                    window.addEventListener('resize', () => {
                        chart.applyOptions({ width: container.clientWidth });
                    });
                })();
              </script>
            </div>
            
          ''';
      }

      return '''
          <p>unknown</p>
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
