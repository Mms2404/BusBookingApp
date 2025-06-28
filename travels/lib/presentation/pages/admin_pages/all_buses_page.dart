import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travels/core/loaders.dart';
import 'package:travels/domain/models/bus_model.dart';
import 'package:travels/presentation/pages/admin_pages/add_bus_page.dart';
import 'package:travels/presentation/providers/app_data_provider.dart';

class AllBusesPage extends StatefulWidget {
  const AllBusesPage({super.key});

  @override
  State<AllBusesPage> createState() => _AllBusesPageState();
}

class _AllBusesPageState extends State<AllBusesPage> {
  late Future<List<BusModel>> allBuses ;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<AppDataProvider>(context, listen: false);
    allBuses = provider.getBuses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Buses')),
      body: FutureBuilder<List<BusModel>>(
        future: allBuses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Loaders.bigLoader());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No buses found'));
          }

          final buses = snapshot.data!;
          return ListView.separated(
            itemCount: buses.length,
            separatorBuilder: (_, __) => Divider(),
            itemBuilder: (context, index) {
              final bus = buses[index];
              return ListTile(
                title: Text(bus.busName),
                subtitle: Text('${bus.type} • ${bus.totalSeats} seats'),
                leading: CircleAvatar(child: Text(bus.type[0])),
                trailing: IconButton(
                  tooltip: "Schedules",
                  onPressed: (){

                  }, 
                  icon: Icon(Icons.edit)),
              );
            },
          );
        },
      ),
      floatingActionButton: IconButton(
        tooltip: "Add Buses" ,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddBusPage()));
        }, 
        icon: Icon(Icons.add)) ,
    );
  }
}
