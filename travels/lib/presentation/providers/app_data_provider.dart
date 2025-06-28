import 'package:flutter/material.dart';
import 'package:travels/data/token_storage.dart';
import 'package:travels/datasource/data_source.dart';
import 'package:travels/datasource/remote_data_source.dart';
import 'package:travels/domain/models/addBus_model.dart';
import 'package:travels/domain/models/admin.dart';
import 'package:travels/domain/models/bus_model.dart';
import 'package:travels/domain/models/bus_schedule.dart';
import 'package:travels/domain/models/bus_reservation.dart';
class AppDataProvider extends ChangeNotifier {
  final DataSource dataSource = RemoteDataSource();

  List<BusSchedule> _scheduleList = [];
  List<BusSchedule> get scheduleList => _scheduleList;

  /// Get schedules by route name (used in search result)
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
    try {
      List<BusSchedule> schedules = await dataSource.getSchedulesByRouteName(routeName);
      _scheduleList = schedules;
      return schedules;
    } catch (e) {
      print("Error fetching schedules: $e");
      return [];
    }
  }

  /// Make a reservation 
  Future<Reservation> bookReservation(Reservation reservation) async {
    try {
      return await dataSource.addReservation(reservation);
    } catch (e) {
      print("Error booking reservation: $e");
      rethrow;  // rethrows the original exception
    }
  }

  // get reservations by scheduleId and departureDate
  Future<List<Reservation>> getReservationsByScheduleAndDepartureDate(
    int scheduleId, String departureDate) {
  return dataSource.getReservationsByScheduleAndDepartureDate(
      scheduleId, departureDate);
  }


  Future<String> loginAdmin(Admin admin) async {
    final token = await dataSource.loginAdmin(admin);
    await TokenStorage.saveToken(token); // save token
    return token;
  }

  Future<List<BusModel>> getBuses(){
    // token handles in ApiService
    return dataSource.getAllBuses();
  }

  Future<AddBusModel> addBus(AddBusModel bus) async {
    return await dataSource.addBus(bus);
  }

}



