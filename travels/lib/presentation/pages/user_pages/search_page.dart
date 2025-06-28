import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travels/core/buttons.dart';
import 'package:travels/core/loaders.dart';
import 'package:travels/presentation/pages/user_pages/search_result_page.dart';
import 'package:travels/presentation/providers/app_data_provider.dart';
import 'package:travels/core/constants.dart';
import 'package:travels/core/helper_functions.dart';
import 'package:travels/presentation/widgets/admin_login_dialog.dart';
import 'package:travels/presentation/widgets/app_dialog.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? fromcity;
  String? tocity;
  DateTime? departureDate;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Center(
                  child: Loaders.busLoader(),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                  labelText: "From",
                  border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty) ? emptyFieldErrMessage : null,
                  onChanged: (value) => fromcity = value.trim(),
                ),
                const SizedBox(height: 25),
                TextFormField(
                  decoration: const InputDecoration(
                  labelText: "To",
                  border: OutlineInputBorder(),
                  ),
                  validator: (value) => (value == null || value.trim().isEmpty) ? emptyFieldErrMessage : null,
                  onChanged: (value) => tocity = value.trim(),
                  ),


                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: _selectDate,
                      child: const Text(" Select Departure date "),
                    ),
                    Text(departureDate == null
                        ? "No date chosen"
                        : formatDateForApi(departureDate!))
                  ],
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: _search,
                  style: AppButtonStyles.topButton,
                  child: const Text("SEARCH"),
                ),
                const SizedBox(height: 20),
                Center(child: Text("--- Login to add new buses and routes ---" , style: TextStyle(color: Colors.grey),)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _adminLogin,
                  style: AppButtonStyles.bottomButton,
                  child: const Text("ADMIN LOGIN"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100)
    );

    if (selectedDate != null) {
      setState(() {
        departureDate = selectedDate;
      });
    }
  }

  void _search() async {
    if (departureDate == null) {
      showMessage(context, emptyDateErrMessage);
      return;
    }

    if (_formKey.currentState!.validate()) {
      final routeName = "$fromcity to $tocity";
      //print("Searching for: $routeName");

      final provider = Provider.of<AppDataProvider>(context, listen: false);

      final schedules = await provider.getSchedulesByRouteName(routeName);

      if (schedules.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchResultPage(
              schedules: schedules,
              departureDate: formatDateForApi(departureDate!),
            ),
          ),
        );
      } else {
        showMessage(context, 'No buses found for this route');
      }
    }
  }


  void _adminLogin(){
    AppDialog.show(context, AdminLoginDialog());
    
  }
}
