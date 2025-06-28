import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travels/data/token_storage.dart';
import 'package:travels/domain/models/addBus_model.dart';
import 'package:travels/domain/models/admin.dart';
import 'package:travels/domain/models/bus_model.dart';
import 'package:travels/domain/models/bus_reservation.dart';
import 'package:travels/domain/models/bus_schedule.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.40.18:8080/api';
  static const String adminUrl = 'http://192.168.40.18:8080/api/admin';
  static const String loginUrl = 'http://192.168.40.18:8080';
  // get all bus schedules
  static Future<List<BusSchedule>> getSchedules() async {
    final response = await http.get(Uri.parse('$baseUrl/showSchedules'));

    // print("Raw schedule JSON: ${response.body}");

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((schedule) => BusSchedule.fromJson(schedule)).toList();
    } else {
      throw Exception('Failed to load the bus schedules');
    }
  }

  // book a  bus schedule
  static Future<Reservation> addReservation(Reservation reservation) async {
    final response = await http.post(
      Uri.parse('$baseUrl/book'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(reservation.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return Reservation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to book reservation');
    }
  }

  // get all the booked bus schedules
  static Future<List<Reservation>> getAllReservations() async {
    final response = await http.get(Uri.parse('$baseUrl/all-reservations'));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Reservation.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch reservations');
    }
  }

  // get the booked bus schedules by scheduleId and departureDate
  static Future<List<Reservation>> getReservationsByScheduleAndDepartureDate(
    int scheduleId, String departureDate) async {
  try {
    final url = Uri.parse(
        "$baseUrl/reservations?scheduleId=$scheduleId&departureDate=$departureDate");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList
          .map((json) => Reservation.fromJson(json))
          .toList();
    } else {
      throw Exception("Failed to fetch reservations");
    }
  } catch (e) {
    print("❌ API Error: $e");
    return [];
   }
  }

  // admin login
  static Future<String> loginAdmin(Admin admin) async {
  final url = Uri.parse('$loginUrl/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(admin.toJson()),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['token'];
  } else {
    throw Exception("Invalid login");
  }
}

  // get all buses
  static Future<List<BusModel>> getAllBuses() async {
  final token = await TokenStorage.getToken();
  final response = await http.get(
    Uri.parse('$adminUrl/showBuses'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((json) => BusModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load buses');
  }
}

 static Future<AddBusModel> addBus(AddBusModel addbus) async {
  final token = await TokenStorage.getToken();
  final response = await http.post(
    Uri.parse('$adminUrl/addBus'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    },
    body: jsonEncode(addbus.toJson()),
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    return AddBusModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to add bus');
  }
}



 

}
