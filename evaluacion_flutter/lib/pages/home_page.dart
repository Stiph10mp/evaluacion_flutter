import 'package:flutter/material.dart';
import 'register_page.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> user;
  final String token;

  const HomePage({super.key, required this.user, required this.token});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];
  bool isLoading = false;

  Future<void> _loadUsers() async {
    setState(() => isLoading = true);
    try {
      final api = ApiService();
      final result = await api.getApiUsers(widget.token);
      setState(() => users = result);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al cargar usuarios: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _deleteUser(int id) async {
    try {
      final api = ApiService();
      await api.deleteApiUser(id, widget.token);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuario eliminado")),
      );
      _loadUsers();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error al eliminar usuario: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Panel de Usuarios"),
          centerTitle: true,
          elevation: 4,
          backgroundColor: Colors.indigo,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Tarjeta de bienvenida
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.indigo,
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text("Bienvenido: ${widget.user['User_user']}"),
                  subtitle: const Text("Gestión de usuarios y roles"),
                ),
              ),
              const SizedBox(height: 20),

              // Botones de acción
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: _loadUsers,
                    icon: const Icon(
                    Icons.list,
                    color: Colors.white),
                    label: const Text(
                      "Ver usuarios",
                      style: TextStyle(color: Colors.white),
                      ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => RegisterPage(token: widget.token)),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Registrar"),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      side: const BorderSide(color: Colors.indigo),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Lista de usuarios
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : users.isEmpty
                        ? const Center(child: Text("No hay usuarios registrados"))
                        : ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final u = users[index];
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                child: ListTile(
                                  leading: const Icon(Icons.person, color: Colors.indigo),
                                  title: Text(u['Api_user']),
                                  subtitle: Text("Rol: ${u['Api_role']} - Estado: ${u['Api_status']}"),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteUser(u['Api_user_id']),
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}