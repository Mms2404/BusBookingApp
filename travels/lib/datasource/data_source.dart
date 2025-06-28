import 'package:travels/domain/models/addBus_model.dart';
import 'package:travels/domain/models/admin.dart';
import 'package:travels/domain/models/bus_reservation.dart';
import '../domain/models/bus_model.dart';
import '../domain/models/bus_schedule.dart';
import '../domain/models/response_model.dart';

abstract class DataSource {
  Future<String> loginAdmin(Admin admin);
  Future<AddBusModel> addBus(AddBusModel addbus);
  Future<List<BusModel>> getAllBuses();
  Future<ResponseModel> addSchedule(BusSchedule busSchedule);
  Future<List<BusSchedule>> getAllSchedules();
  Future<List<BusSchedule>> getSchedulesByRouteName(String routeName);
  Future<Reservation>addReservation(Reservation reservation);
  Future<List<Reservation>> getReservationsByScheduleAndDepartureDate(int scheduleId, String departureDate);
} 