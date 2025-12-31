/// 图表指标数据模型
///
/// 用于在TradingView图表上显示自定义指标和标记。
/// 支持位置、颜色、文本等属性的配置。
///
/// 使用示例：
/// ```dart
/// ChartIndicator(
///   id: 1,
///   text: "买入信号",
///   displayPosition: "top: 10px; left: 20px;",
///   color: "#FF5733",
///   timestamp: 1640995200,
/// )
/// ```
class ChartIndicator {
  final int? id;
  final String? text;
  final String? displayPosition;
  final String? color;
  final String? shape;
  final int? timestamp;
  final Map<String, Object?> metadata;

  ChartIndicator({
    this.id,
    this.text,
    this.displayPosition = 'belowBar',
    this.shape = 'circle',
    this.color,
    this.timestamp,
    this.metadata = const {},
  });

  factory ChartIndicator.fromJson(Map<String, dynamic> json) {
    return ChartIndicator(
      id: json['id'] as int?,
      text: json['text'] as String?,
      displayPosition: json['displayPosition'] as String?,
      color: json['color'] as String?,
      shape: json['shape'] as String?,
      timestamp: json['time'] as int?,
      metadata: json['metadata'] as Map<String, Object?>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'position': displayPosition,
      'color': color,
      'shape': shape,
      'time': timestamp,
    };
  }

  @override
  String toString() {
    return 'ChartIndicator(id: $id, text: $text, displayPosition: $displayPosition, color: $color, timestamp: $timestamp, metadata: $metadata)';
  }
}
