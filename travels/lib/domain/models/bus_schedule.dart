import 'bus_model.dart';

class BusSchedule {
  final int id;
  final String from;
  final String to;
  final String departureTime;
  final String departureDate;
  final int ticketPrice;
  final BusModel bus;

  BusSchedule({
    required this.id,
    required this.from,
    required this.to,
    required this.departureTime,
    required this.departureDate,
    required this.ticketPrice,
    required this.bus,
  });

  factory BusSchedule.fromJson(Map<String, dynamic> json) {
    return BusSchedule(
      id: json['id']  ?? 0,
      from: json['fromLocation'] ?? '',
      to: json['toLocation'] ?? '',
      departureTime: json['departureTime'] ?? '',
      departureDate: json['departureDate'] ?? '',
      ticketPrice: json['fare'] ?? 0,
      bus: BusModel.fromJson(json['bus'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'from': from,
        'to': to,
        'departureTime': departureTime,
        'departureDate': departureDate,
        'ticketPrice':ticketPrice,
        'bus': bus.toJson(),
      };
}
