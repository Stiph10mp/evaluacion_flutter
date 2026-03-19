import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  final Map<String, dynamic> user;
  final String token;

  const HomePage({super.key, required this.user, required this.token});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> roles = [];
  bool isLoading = false;

  Future<void> _loadRoles() async {
    setState(() => isLoading = true);
    try {
      final api = ApiService();
      final result = await api.getRoles(widget.token);
      setState(() {
        roles = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error cargando roles: $e")),
      );
    }
  }

  Future<void> _deleteRole(int id) async {
    try {
      final api = ApiService();
      await api.deleteRole(id, widget.token);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Rol eliminado correctamente")),
      );
      _loadRoles(); // refrescar lista
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error eliminando rol: $e")),
      );
    }
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  void _goToRegisterRole() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterRolePage(token: widget.token),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Inicio"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: "Cerrar sesión",
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.indigo,
                  child: Text(
                    widget.user['username'][0].toUpperCase(),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                title: Text("Bienvenido, ${widget.user['username']}"),
                subtitle: const Text("Tu panel de administración"),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.visibility, color: Colors.white),
                    label: const Text(
                      "Ver Roles",
                      style: TextStyle(color: Colors.white)),
                    onPressed: _loadRoles,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text("Crear Rol"),
                    onPressed: _goToRegisterRole,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : roles.isEmpty
                      ? const Center(child: Text("No hay roles registrados"))
                      : ListView.separated(
                          itemCount: roles.length,
                          separatorBuilder: (_, __) => const Divider(),
                          itemBuilder: (context, index) {
                            final r = roles[index];
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.security),
                                title: Text(r['Roles_name']),
                                subtitle: Text("Descripción: ${r['Roles_description']}"),
                                trailing: IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  tooltip: "Eliminar rol",
                                  onPressed: () => _deleteRole(r['Roles_id']),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}