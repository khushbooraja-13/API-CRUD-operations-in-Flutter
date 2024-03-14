import "dart:convert";

import "package:http/http.dart" as http;

class ApiUrl{
  Future<List> getAll() async {
    var response = await http.get(Uri.parse("https://64e5f07509e64530d17f4a2a.mockapi.io/student"));
    return jsonDecode(response.body);
  }

  Future<void> deleteUser(id) async {
    await http.delete(Uri.parse("https://64e5f07509e64530d17f4a2a.mockapi.io/student/"+id));
  }

  Future<void> insertUser(Map<String, dynamic> map) async {
    await http.post(Uri.parse("https://64e5f07509e64530d17f4a2a.mockapi.io/student"),body: map);
  }

  Future<void> updateUser(Map<String, dynamic> map, String id) async {
    await http.put(Uri.parse("https://64e5f07509e64530d17f4a2a.mockapi.io/student/"+id),body: map);
  }
}