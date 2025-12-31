class ChartVolume {
  final int? volume;
  final int? time;
  final String? color;

  ChartVolume({required this.volume, required this.time, this.color});

  factory ChartVolume.fromJson(Map<String, dynamic> json) {
    return ChartVolume(
      volume: json['volume'],
      time: json['time'],
      color: json['color'],
    );
  }

  Map<String, dynamic> toJson() => {
    "volume": volume,
    "time": time,
    "color": color,
  };

  @override
  String toString() {
    return 'ChartVolume{volume: $volume, time: $time, color: $color}';
  }
}
