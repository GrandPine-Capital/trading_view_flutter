enum TradingLocale { chinese, english }

extension TradingLocaleExtension on TradingLocale {
  String toLocaleString() {
    switch (this) {
      case TradingLocale.chinese:
        return "zh_CN";
      case TradingLocale.english:
        return "en_US";
    }
  }
}
