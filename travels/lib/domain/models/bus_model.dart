class BusModel {
  final int id;
  final String busName;
  final int totalSeats;
  final String type;

  BusModel({
    required this.id,
    required this.busName,
    required this.totalSeats,
    required this.type,
  });

  factory BusModel.fromJson(Map<String, dynamic> json) {
    return BusModel(
      id: json['id'],
      busName: json['busName'] ?? '',
      totalSeats: json['totalSeats'] ?? 0,
      type: json['type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'busName': busName,
        'totalSeats': totalSeats,
        'type': type,
      };
}
