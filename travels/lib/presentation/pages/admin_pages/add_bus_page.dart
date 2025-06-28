import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travels/core/helper_functions.dart';
import 'package:travels/core/loaders.dart';
import 'package:travels/domain/models/addBus_model.dart';
import 'package:travels/presentation/providers/app_data_provider.dart';

class AddBusPage extends StatefulWidget {
  const AddBusPage({super.key});

  @override
  State<AddBusPage> createState() => _AddBusPageState();
}

class _AddBusPageState extends State<AddBusPage> {
  final nameController = TextEditingController();
  final seatController = TextEditingController();
  final typeController = TextEditingController();
  bool isLoading = false;

  void _submit() async {
    if (nameController.text.isEmpty || seatController.text.isEmpty || typeController.text.isEmpty) {
      showMessage(context, "All fields required");
      return;
    }

    final bus = AddBusModel(
      busName: nameController.text.trim(),
      totalSeats: int.tryParse(seatController.text.trim()) ?? 0,
      type: typeController.text.trim(),
    );

    setState(() => isLoading = true);

    try {
      final provider = Provider.of<AppDataProvider>(context, listen: false);
      final addedBus = await provider.addBus(bus);
      showMessage(context, "Bus added: ${addedBus.busName}");
    } catch (e) {
      showMessage(context, "Failed to add bus");
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Bus")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Bus Name"),
            ),
            TextField(
              controller: seatController,
              decoration: const InputDecoration(labelText: "Total Seats"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: typeController,
              decoration: const InputDecoration(labelText: "Type (e.g., AC, Sleeper)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _submit,
              child: isLoading ? Loaders.smallLoader() : const Text("Add Bus"),
            ),
          ],
        ),
      ),
    );
  }
}
