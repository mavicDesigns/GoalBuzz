import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:truck/src/models/api_response_model.dart';

const String baseUrl =
    'http://localhost:8080'; // Replace with your API base URL
const String apiKey = 'a8e6601de9f0bd5fe6d357fee40c138b'; // Replace with your actual API key

Future<ApiResponse> fetchFixturesFromNetwork(DateTime date) async {
  final response = await http.get(
    Uri.parse('$baseUrl/fixtures?date=${ DateFormat('yyyy-MM-dd').format(date)}'),
    headers: {
      'x-apisports-key': apiKey,
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    // Use ApiResponse.fromJson to parse the Map
    


    final ApiResponse data = ApiResponse.fromJson(responseBody);
   
    return data;
  } else {
    print(response.statusCode);
    throw Exception('Failed to load matches');
  }
}


Future<ApiResponse> fetchFixture(int fixtureId) async {
  final response = await http.get(
    Uri.parse('$baseUrl/fixture?id=$fixtureId'),
    headers: {
      'x-apisports-key': apiKey,
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    // Use ApiResponse.fromJson to parse the Map
    


    final ApiResponse data = ApiResponse.fromJson(responseBody);
   
    return data;
  } else {
    print(response.statusCode);
    throw Exception('Failed to load matches');
  }
}
