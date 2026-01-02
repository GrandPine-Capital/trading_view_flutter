class ChartIndicatorImage {
  final String time;
  final double price;
  final String imageSource; // can be based64 or cdn_url

  ChartIndicatorImage({
    required this.time,
    required this.price,
    required this.imageSource,
  });

  factory ChartIndicatorImage.fromJson(Map<String, dynamic> json) {
    return ChartIndicatorImage(
      time: json['time'],
      price: json['price'],
      imageSource: json['imageSource'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'time': time, 'price': price, 'imageSource': imageSource};
  }

  @override
  String toString() {
    return 'ChartIndicatorImage(time: $time, price: $price, imageSource: $imageSource)';
  }
}
