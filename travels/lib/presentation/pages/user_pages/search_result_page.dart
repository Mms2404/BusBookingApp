import 'package:flutter/material.dart';
import 'package:travels/domain/models/bus_schedule.dart';
import 'package:travels/presentation/pages/user_pages/seat_plan_page.dart';
import 'package:travels/core/constants.dart';

class SearchResultPage extends StatefulWidget {
  final List<BusSchedule> schedules;
  final String departureDate;

  const SearchResultPage({
    Key? key,
    required this.schedules,
    required this.departureDate,
  }) : super(key: key);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Results"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child:ListView(
                children: [
                  Text(
                    "Buses from ${widget.schedules.first.from} to ${widget.schedules.first.to} on ${widget.departureDate}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Divider(thickness: 1),
                  ...widget.schedules
                      .map((schedule) => ScheduleItemView(
                            date: widget.departureDate,
                            schedule: schedule,
                            time: schedule.departureTime,
                          ))
                      .toList(),
                ],
              )
      ),
    );
  }
}

class ScheduleItemView extends StatelessWidget {
  final String date;
  final String time;
  final BusSchedule schedule;

  const ScheduleItemView({
    Key? key,
    required this.date,
    required this.time,
    required this.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeatPlanPage(
              schedule: schedule,
              departuredate: date,
              departureTime: time,
            ),
          ),
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('    ${schedule.from} - ${schedule.to} '),
              const Divider(thickness: 1 , color: Colors.amberAccent,),
              ListTile(
                title: Text(schedule.bus.busName),
                subtitle: Text(schedule.bus.type),
                trailing: Text("$currency ${schedule.ticketPrice}"),
              ),
              const Divider(thickness: 1,color: Colors.amberAccent),
              Text('    Departure date: ${schedule.departureDate}'),
              Text('    Departure time: ${schedule.departureTime}'),
              Text('    Total seats: ${schedule.bus.totalSeats}')
            ],
          ),
        ),
      ),
    );
  }
}
