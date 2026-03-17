import 'package:flutter/material.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  final String token;
  RegisterPage({required this.token});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController roleController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  bool isLoading = false;

  Future<void> _register() async {
    setState(() => isLoading = true);
    try {
      final api = ApiService();
      await api.registerApiUser(
        userController.text.trim(),
        passwordController.text.trim(),
        statusController.text.trim(),
        roleController.text.trim(),
        widget.token,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Usuario registrado con éxito")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Registrar Usuario API")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(controller: userController, decoration: InputDecoration(labelText: "Usuario")),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: "Contraseña"), obscureText: true),
            TextField(controller: roleController, decoration: InputDecoration(labelText: "Rol")),
            TextField(controller: statusController, decoration: InputDecoration(labelText: "Estado")),
            SizedBox(height: 20),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : ElevatedButton(onPressed: _register, child: Text("Registrar")),
          ],
        ),
      ),
    );
  }
}