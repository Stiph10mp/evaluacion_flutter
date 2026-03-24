import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Ajusta la URL según tu backend
  final String baseUrl = "http://localhost:3000/api_v1";

  /// LOGIN
  Future<Map<String, dynamic>> login(String user, String password) async {
    final response = await http.post(
      Uri.parse("$baseUrl/apiUserLogin"), // ruta correcta
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "api_user": user,        // tu modelo espera estos nombres
        "api_password": password,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // {"token": "..."}
    } else {
      throw Exception("Error al iniciar sesión: ${response.body}");
    }
  }

  /// REGISTRAR ROL
  Future <void> registerRole(String name, String description, String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/role"), // coincide con tu role.routes.js
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "name": name,
        "description": description,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception("Error al crear rol: ${response.body}");
    }
  }

  /// OBTENER ROLES
  Future<List<dynamic>> getRoles(String token) async {
    final response = await http.get(
      Uri.parse("$baseUrl/role"), // GET /role
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // lista de roles
    } else {
      throw Exception("Error al obtener roles: ${response.body}");
    }
  }

  /// ELIMINAR ROLES
  Future<void> deleteRole(int id, String token) async {
  final response = await http.delete(
    Uri.parse("$baseUrl/role/$id"),
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    },
  );

  if (response.statusCode != 200) {
    throw Exception("Error al eliminar rol: ${response.body}");
  }
}

  /// OPCIONAL: Verificar token
  Future<Map<String, dynamic>> verifyToken(String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/apiUserVerifyToken"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"token": token}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // {"message":"Token is valid", "user": {...}}
    } else {
      throw Exception("Token inválido: ${response.body}");
    }
  }

  
}

