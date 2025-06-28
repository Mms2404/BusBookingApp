import 'package:travels/data/api_service.dart';
import 'package:travels/datasource/data_source.dart';
import 'package:travels/domain/models/addBus_model.dart';
import 'package:travels/domain/models/admin.dart';
import 'package:travels/domain/models/bus_model.dart';
import 'package:travels/domain/models/bus_reservation.dart';
import 'package:travels/domain/models/bus_schedule.dart';

class RemoteDataSource implements DataSource {

  // bus schedules by searched place names 
  @override
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName) async {
  try {
    List<BusSchedule> allSchedules = await ApiService.getSchedules();

    final parts = routeName.split(' to '); 
    if (parts.length != 2) return [];

    final from = parts[0].trim().toLowerCase();
    final to = parts[1].trim().toLowerCase();


    // print("Searching for: from=$from to=$to");
    //     for (var s in allSchedules) {
    //       print("Available: ${s.from} to ${s.to}");
    // }
    
    return allSchedules.where((schedule) =>
      schedule.from.toLowerCase().trim() == from &&
      schedule.to.toLowerCase().trim() == to).toList();

  } catch (e, stack) {
    print('Error fetching schedules by route: $e');
    print(stack);
    return [];
  }
}


  // making reservation to a schedule
  @override
  Future<Reservation> addReservation(Reservation reservation) async {
    return await ApiService.addReservation(reservation);
  }

  

  @override
  Future<List<Reservation>> getReservationsByScheduleAndDepartureDate(
    int scheduleId, String departureDate) async {
  try {
    return await ApiService.getReservationsByScheduleAndDepartureDate(
        scheduleId, departureDate);
  } catch (e) {
    print('Error fetching reservations: $e');
    return [];
  }
}

@override
  Future<String> loginAdmin(Admin admin) async {
    return await ApiService.loginAdmin(admin);
  }

@override
  Future<List<BusModel>> getAllBuses () async {
    return await ApiService.getAllBuses();
  }

@override
  Future<AddBusModel> addBus(AddBusModel addbus) async {
    return await ApiService.addBus(addbus);
  }
  // Admin methods (not yet implemented)
  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
