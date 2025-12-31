class TradingViewCalculation {
  static TradingViewCalculation get instance => TradingViewCalculation.create();

  TradingViewCalculation._();
  TradingViewCalculation.create() : this._();

  int getVolume(int open, int close) {
    return close - open;
  }
}
