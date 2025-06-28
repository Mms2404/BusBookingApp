import 'package:flutter/material.dart';
import 'package:travels/core/buttons.dart';
import 'package:travels/core/loaders.dart';
import 'package:travels/data/api_service.dart';
import 'package:travels/domain/models/bus_reservation.dart';

class BookingConfirmationPage extends StatefulWidget {
  final String departureDate;
  final String departureTime;
  final List<String> seats;
  final int scheduleId;
  final String from;
  final String to;
  final String busName;
  final int ticketPrice;

  const BookingConfirmationPage({
    super.key,
    required this.departureDate,
    required this.departureTime,
    required this.seats,
    required this.scheduleId,
    required this.from,
    required this.to,
    required this.busName,
    required this.ticketPrice
  });

  @override
  State<BookingConfirmationPage> createState() => _BookingConfirmationPageState();
}

class _BookingConfirmationPageState extends State<BookingConfirmationPage> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController(); // only for greeting
  bool isLoading = false;

  Future<void> bookTicket() async {
    if (phoneController.text.isEmpty || nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    final reservation = Reservation(
      phone: phoneController.text,
      departureDate: widget.departureDate,
      seatNumbers: widget.seats.join(','),
      totalSeats: widget.seats.length,
      scheduleId: widget.scheduleId, // only sending schedule ID
      ticketPrice: widget.ticketPrice
    );

    setState(() => isLoading = true);

    try {
      final bookedReservation = await ApiService.addReservation(reservation);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => TicketSuccessPage(
            name: nameController.text,
            phone: phoneController.text,
            from: widget.from,
            to: widget.to,
            seats: widget.seats,
            date: widget.departureDate,
            bus: widget.busName,
            totalPrice: bookedReservation.ticketPrice ?? 0
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Booking failed. Try again.")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Confirm Booking")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bus: ${widget.busName}"),
            Text("From: ${widget.from}"),
            Text("To: ${widget.to}"),
            Text("Departure Date: ${widget.departureDate}"),
            Text("Departure Time: ${widget.departureTime}"),
            Text("Selected Seats: ${widget.seats.join(', ')}"),
            Text("Total Seats: ${widget.seats.length}"),

            const SizedBox(height: 20),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Your Name"),
            ),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: "Phone Number"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: AppButtonStyles.commonButton,
              onPressed: isLoading ? null : bookTicket,
              child: isLoading
                  ? Center(child:Loaders.smallLoader())
                  : const Text("Confirm Booking"),
            ),
          ],
        ),
      ),
    );
  }
}

class TicketSuccessPage extends StatelessWidget {
  final String name, phone, from, to, date, bus;
  final int totalPrice;
  final List<String> seats;

  const TicketSuccessPage({
    super.key,
    required this.name,
    required this.phone,
    required this.from,
    required this.to,
    required this.date,
    required this.seats,
    required this.bus,
    required this.totalPrice
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Confirmed")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thank you, $name!"),
            Text("Phone: $phone"),
            Text("Bus: $bus"),
            Text("From: $from"),
            Text("To: $to"),
            Text("Date: $date"),
            Text("Selected Seats: ${seats.join(', ')}"),
            Text("Total Seats: ${seats.length}"),

            const SizedBox(height: 20),
            Text("Total Price: ₹$totalPrice", style: TextStyle(fontSize: 20),),
            const SizedBox(height: 20),
            const Text("Your ticket has been booked successfully.",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
