import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travels/core/buttons.dart';
import 'package:travels/core/helper_functions.dart';
import 'package:travels/core/loaders.dart';
import 'package:travels/data/token_storage.dart';
import 'package:travels/domain/models/admin.dart';
import 'package:travels/presentation/pages/admin_pages/all_buses_page.dart';
import 'package:travels/presentation/providers/app_data_provider.dart';

class AdminLoginDialog extends StatefulWidget {
  const AdminLoginDialog({super.key});

  @override
  State<AdminLoginDialog> createState() => _AdminLoginDialogState();
}

class _AdminLoginDialogState extends State<AdminLoginDialog> {
   final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    bool isLoading = false;
    bool isValid = true;

    Future<void> handleLogin() async {

       if (usernameController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
        showMessage(context, "Please enter username and password");
        return;
        }

      setState(() {
        isLoading = true;
      });

      final admin = Admin(
        userName: usernameController.text.trim(), 
        password : passwordController.text.trim()
      );
      final provider = Provider.of<AppDataProvider>(context , listen : false);

     try {
      String token = await provider.loginAdmin(admin); 
      
      if (token.isNotEmpty) {
        await TokenStorage.saveToken(token);
        Navigator.of(context).pop(); // Close dialog
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => AllBusesPage()),
        );
      }
     } catch (e) {
      setState(() {
        isValid = false;
      });
     } finally {
      setState(() {
        isLoading = false;
      });
     }
   }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Admin Login",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(labelText: 'Username'),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          style: AppButtonStyles.commonButton,
          onPressed: () {
            isLoading 
                ? null
                :handleLogin();
          },
          child: isLoading 
                     ? Loaders.smallLoader()
                     : isValid ? Text("LOGIN") : Text("Invalid credentials")
        ),
      ],
    );
  }
}
