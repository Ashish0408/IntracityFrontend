import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(home: BusTestPage());
//   }
// }

class BusTestPage extends StatefulWidget {
  const BusTestPage({super.key});

  @override
  State<BusTestPage> createState() => _BusTestPageState();
}

class _BusTestPageState extends State<BusTestPage> {
  final baseUrl = "http://192.168.29.134:8080";
  String? authToken;
  String output = "Not logged in.";
  final TextEditingController deleteIdController = TextEditingController();
  final TextEditingController singleBusIdController = TextEditingController();

  /// ✅ PRINT HELPER
  void log(String message) {
    debugPrint("📍 $message");
  }

  /// ✅ LOGIN
  Future<void> login() async {
    final url = Uri.parse("$baseUrl/api/users/login");
    final body = jsonEncode({"email": "b@b.b", "password": "b@b.b"});

    setState(() => output = "Logging in...");

    log("LOGIN → $url");
    log("Body → $body");

    try {
      final res = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      log("Response Code → ${res.statusCode}");
      log("Response Body → ${res.body}");

      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        authToken = data["data"]["token"];

        log("✅ TOKEN STORED: $authToken");

        setState(() => output = "Login Successful");
      } else {
        setState(() => output = "Login failed\n${res.body}");
      }
    } catch (e, st) {
      log("❌ LOGIN ERROR: $e");
      log("STACK:\n$st");
      setState(() => output = "ERROR: $e");
    }
  }

  /// ✅ GET BUS LIST
  Future<void> getBuses() async {
    if (authToken == null) {
      setState(() => output = "⚠️ Please login first");
      return;
    }

    final url = Uri.parse("$baseUrl/api/buses/all");

    log("GET BUSES → $url");
    log("Headers → Authorization: Bearer $authToken");

    setState(() => output = "Fetching buses...");

    try {
      final res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      log("Response Code → ${res.statusCode}");
      log("Response Body → ${res.body}");

      setState(() => output = "Status: ${res.statusCode}\n\n${res.body}");
    } catch (e, st) {
      log("❌ GET BUSES ERROR: $e");
      log("STACK:\n$st");

      setState(() => output = "ERROR: $e");
    }
  }

  /// ✅ ADD BUS
  Future<void> addBus() async {
    if (authToken == null) {
      setState(() => output = "⚠️ Please login first");
      return;
    }

    final url = Uri.parse("$baseUrl/api/buses/register");

    final busData = {
      "name": "sakshi bus",
      "operator": "test1",
      "fromCity": "Bhopal",
      "toCity": "indore",
      "departureTime": "11:27:00",
      "arrivalTime": "01:12:00",
      "price": 10,
      "totalSeats": 10,
      "availableSeats": 10,
      "stoppages": [
        {
          "cityName": "lalghati",
          "arrivalTime": "10:00:00",
          "departureTime": "10:00:00",
          "cumulativePrice": 20,
        },
      ],
    };

    log("ADD BUS → $url");
    log("Headers → Authorization: Bearer $authToken");
    log("Body → ${jsonEncode(busData)}");

    setState(() => output = "Adding bus...");

    try {
      final res = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
        body: jsonEncode(busData),
      );

      log("Response Code → ${res.statusCode}");
      log("Response Body → ${res.body}");

      setState(() => output = "Status: ${res.statusCode}\n${res.body}");
    } catch (e, st) {
      log("❌ ADD BUS ERROR: $e");
      log("STACK:\n$st");

      setState(() => output = "ERROR: $e");
    }
  }

  /// ✅ DELETE BUS
  Future<void> deleteBus() async {
    if (authToken == null) {
      setState(() => output = "⚠️ Please login first");
      return;
    }

    final id = deleteIdController.text.trim();

    if (id.isEmpty) {
      setState(() => output = "⚠️ Enter Bus ID");
      return;
    }

    final url = Uri.parse("$baseUrl/api/buses/$id");

    log("DELETE BUS → $url");
    log("Headers → Authorization: Bearer $authToken");

    setState(() => output = "Deleting bus $id...");

    try {
      final res = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      log("Response Code → ${res.statusCode}");
      log("Response Body → ${res.body}");

      setState(() => output = "Status: ${res.statusCode}\n${res.body}");
    } catch (e, st) {
      log("❌ DELETE BUS ERROR: $e");
      log("STACK:\n$st");

      setState(() => output = "ERROR: $e");
    }
  }

  /// ✅ GET SINGLE BUS
  Future<void> getSingleBus() async {
    if (authToken == null) {
      setState(() => output = "⚠️ Please login first");
      return;
    }

    final id = singleBusIdController.text.trim();
    if (id.isEmpty) {
      setState(() => output = "⚠️ Enter Bus ID");
      return;
    }

    final url = Uri.parse("$baseUrl/api/buses/$id");

    print("📍 GET SINGLE BUS → $url");
    print("📍 Headers → Authorization: Bearer $authToken");

    setState(() => output = "Fetching bus $id...");

    try {
      final res = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $authToken",
        },
      );

      print("📍 Response Code → ${res.statusCode}");
      print("📍 Response Body → ${res.body}");

      setState(() {
        output = "Status: ${res.statusCode}\n\n${res.body}";
      });
    } catch (e) {
      setState(() => output = "ERROR: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bus API Test")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(onPressed: login, child: const Text("Login")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: getBuses, child: const Text("Get Buses")),
            const SizedBox(height: 10),
            ElevatedButton(onPressed: addBus, child: const Text("Add Bus")),
            const SizedBox(height: 10),

            TextField(
              controller: deleteIdController,
              decoration: const InputDecoration(
                labelText: "Enter Bus ID to Delete",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: deleteBus,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Delete Bus"),
            ),
            const SizedBox(height: 10),

            /// ENTER BUS ID TO FETCH
            TextField(
              controller: singleBusIdController,
              decoration: const InputDecoration(
                labelText: "Enter Bus ID to Fetch",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: getSingleBus,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Get Bus"),
            ),

            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  output,
                  style: const TextStyle(fontFamily: "Courier"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
