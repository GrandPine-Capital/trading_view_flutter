import 'package:trading_view_flutter/trading_view_flutter.dart';

extension TradingViewThemeParse on TradingViewTheme {
  String get name => toString().split('.').last;

  static TradingViewTheme fromString(String value) {
    return TradingViewTheme.values.firstWhere(
      (element) => element.name == value.toLowerCase(),
      orElse: () => TradingViewTheme.light,
    );
  }
}
