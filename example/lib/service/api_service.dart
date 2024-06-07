import 'dart:convert';
import 'package:http/http.dart';

class ApiService {
  Future postData(String name, String job, String email, String mobile,
      String address) async {
    var data;
    try {
      Response response = await post(
        Uri.parse("https://reqres.in/api/users"),
        body: {
          "name": name,
          "job": job,
          "email": email,
          "mobile": mobile,
          "address": address
        },
      );
      data = jsonDecode(response.body.toString());
      if (response.statusCode == 201) {
        print("post_service : data : $data");
        return data;
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Error in postData: $e");

    }
  }
}
