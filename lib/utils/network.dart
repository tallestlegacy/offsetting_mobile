import 'dart:convert';

import 'package:http/http.dart' as http;

const projectsUrl = "https://offsetting.vercel.app/api";

Future<dynamic> fetch(String url) async {
  final response = await http.get(Uri.parse(url));
  return jsonDecode(response.body);
}

Future<List> getProjects() async {
  final response = await fetch(projectsUrl);
  return response;
}
