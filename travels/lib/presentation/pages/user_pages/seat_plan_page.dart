import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travels/core/buttons.dart';
import 'package:travels/domain/models/bus_schedule.dart';
import 'package:travels/presentation/pages/user_pages/booking_confirmation_page.dart';
import 'package:travels/presentation/providers/app_data_provider.dart';
import 'package:travels/core/colors.dart';
import 'package:travels/core/constants.dart';
import 'package:travels/core/helper_functions.dart';
import 'package:travels/presentation/widgets/seat_plan_view.dart';

class SeatPlanPage extends StatefulWidget {
  final BusSchedule schedule;
  final String departuredate;
  final String departureTime;

  const SeatPlanPage({
    super.key,
    required this.schedule,
    required this.departuredate,
    required this.departureTime
  });

  @override
  State<SeatPlanPage> createState() => _SeatPlanPageState();
}

class _SeatPlanPageState extends State<SeatPlanPage> {
  int totalSeatsBooked = 0;
  String bookedSeatNumbers = '';
  List<String> selectedSeats = [];
  ValueNotifier<String> selectedStringNotifier = ValueNotifier("");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getData();
  }

  Future<void> getData() async {
    final resList = await Provider.of<AppDataProvider>(context, listen: false)
        .getReservationsByScheduleAndDepartureDate(widget.schedule.id, widget.departuredate);

    List<String> seats = [];
    for (final res in resList) {
      totalSeatsBooked += res.totalSeats;
      seats.addAll(res.seatNumbers.split(","));
    }

    setState(() {
      bookedSeatNumbers = seats.join(',');
    });

    print("🎯 Booked Seats for schedule: $bookedSeatNumbers");
  }

  @override
  Widget build(BuildContext context) {
    final bus = widget.schedule.bus;

    return Scaffold(
      appBar: AppBar(
        title: Text("Seat Plan"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Legend
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _seatLegend(seatBookedColor, "Booked"),
                    _seatLegend(seatAvailableColor, "Available"),
                  ],
                ),
              ),

              // Selected Seats Info
              ValueListenableBuilder<String>(
                valueListenable: selectedStringNotifier,
                builder: (context, value, _) => Text("Selected: $value"),
              ),

              const SizedBox(height: 10),

              // Seat Layout View
              Expanded(
                child: SingleChildScrollView(
                  child: SeatPlanView(
                    totalSeat: bus.totalSeats,
                    bookedSeatNumbers: bookedSeatNumbers,
                    totalSeatBooked: totalSeatsBooked,
                    isBusinessClass: bus.type == busTypeACBusiness,
                    onSeatSelected: (isSelected, seat) {
                      if (isSelected) {
                        selectedSeats.add(seat);
                      } else {
                        selectedSeats.remove(seat);
                      }
                      selectedStringNotifier.value = selectedSeats.join('|');
                    },
                  ),
                ),
              ),

              SizedBox(height: 20,),

              // Proceed Button
              ElevatedButton(
                style: AppButtonStyles.commonButton,
                onPressed: () {
                  if (selectedSeats.isEmpty) {
                    showMessage(context, "Please select a seat");
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingConfirmationPage(
                        departureDate: widget.departuredate,
                        departureTime:widget.departureTime,
                        seats: selectedSeats,
                        scheduleId: widget.schedule.id,
                        from: widget.schedule.from,
                        to: widget.schedule.to,
                        busName: widget.schedule.bus.busName,
                        ticketPrice :widget.schedule.ticketPrice
                      ),
                    ),
                  );
                },
                child: const Text("CONFIRM"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _seatLegend(Color color, String label) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(height: 20, width: 20, color: color),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
