class ChartValue {
  final String time;
  final double value;

  ChartValue({required this.time, required this.value});

  factory ChartValue.fromJson(Map<String, dynamic> json) {
    return ChartValue(time: json['time'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {'time': time, 'value': value};
  }

  @override
  String toString() {
    return 'ChartValue{time: $time, value: $value}';
  }
}
