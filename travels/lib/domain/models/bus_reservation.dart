class Reservation {
  final int? id;
  final String phone;
  final String departureDate;
  final String seatNumbers;
  final int totalSeats;
  final int scheduleId;
  final int? ticketPrice;

  Reservation({
    this.id,
    required this.phone,
    required this.departureDate,
    required this.seatNumbers,
    required this.totalSeats,
    required this.scheduleId,
    this.ticketPrice
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      departureDate: json['departureDate'] ?? '',
      seatNumbers: json['seatNumbers'] ?? '',
      totalSeats: json['totalSeats'] ?? 0,
      scheduleId: json['schedule']?['id'] ?? 0,
      ticketPrice: json['ticketPrice'] 
    );
  }

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'departureDate': departureDate,
        'seatNumbers': seatNumbers,
        'totalSeats': totalSeats,
        'schedule': {'id': scheduleId},
      };
}
