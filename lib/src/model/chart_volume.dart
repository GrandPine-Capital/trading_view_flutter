class ChartVolume {
  final int? volume;
  final int? time;

  ChartVolume({required this.volume, required this.time});

  factory ChartVolume.fromJson(Map<String, dynamic> json) {
    return ChartVolume(volume: json['volume'], time: json['time']);
  }

  Map<String, dynamic> toJson() => {"volume": volume, "time": time};

  @override
  String toString() {
    return 'ChartVolume{volume: $volume, time: $time}';
  }
}
