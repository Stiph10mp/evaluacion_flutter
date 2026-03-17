import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = "http://localhost:3000/api_v1"; // Para Flutter Web

  // LOGIN
  Future<Map<String, dynamic>> login(String user, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/apiUserLogin"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "api_user": user,
        "api_password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // aquí viene el token
    } else {
      throw Exception("Error en login: ${response.body}");
    }
  }

  // REGISTRO DE USUARIO API
  Future<void> registerApiUser(
      String user, String password, String status, String role, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/apiUser"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode({
        "user": user,
        "password": password,
        "status": status,
        "role": role,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception("Error al registrar usuario: ${response.body}");
    }
  }

  // LISTAR USUARIOS API
  Future<List<dynamic>> getApiUsers(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/apiUser"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error al obtener usuarios: ${response.body}");
    }
  }

  // ELIMINAR USUARIO API
  Future<void> deleteApiUser(int id, String token) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/apiUser/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Error al eliminar usuario: ${response.body}");
    }
  }
}