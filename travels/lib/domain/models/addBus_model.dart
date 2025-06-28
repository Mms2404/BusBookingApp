class AddBusModel {
  final String busName;
  final int totalSeats;
  final String type;

  AddBusModel({
    required this.busName,
    required this.totalSeats,
    required this.type,
  });

  factory AddBusModel.fromJson(Map<String, dynamic> json) {
    return AddBusModel(
      busName: json['busName'] ?? '',
      totalSeats: json['totalSeats'] ?? 0,
      type: json['type'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'busName': busName,
        'totalSeats': totalSeats,
        'type': type,
      };
}
