import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Gunakan api kecil
  static const String baseUrl = 'http://localhost:8080/api';

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      // Memanggil http://localhost:8080/api/login
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {
          'email': email,
          'password': password,
        },
      );

      // Debugging: Muncul di terminal VS Code jika error
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        return {'status': 'error', 'message': 'Email atau Password Salah'};
      } else {
        return {
          'status': 'error', 
          'message': 'Error ${response.statusCode}: Alamat tidak ditemukan atau Server mati'
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Koneksi bermasalah: $e'};
    }
  }

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {
    try {
      final url = Uri.parse('$baseUrl/api/register'); 
      final response = await http.post(
        url,
        body: {
          'name': name,
          'email': email,
          'password': password,
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {'status': 'error', 'message': 'Gagal terhubung ke server'};
    }
  }
}