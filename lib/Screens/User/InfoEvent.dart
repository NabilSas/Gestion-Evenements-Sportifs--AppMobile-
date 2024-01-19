import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'Promote.dart';

class InfoEvent extends StatefulWidget {
  final int? eventId;

  InfoEvent({this.eventId});

  @override
  _InfoEventState createState() => _InfoEventState();
}

class _InfoEventState extends State<InfoEvent> {
  Map<String, dynamic> eventData = {};
  bool isParticipateButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    fetchEventDetails();
  }

  Future<void> fetchEventDetails() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8080/events/${widget.eventId}'));
      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> eventDetails = jsonDecode(response.body);
        setState(() {
          eventData = eventDetails;
        });
      } else {
        log('Error: ${response.statusCode}');
        log('Response body: ${response.body}');
        throw Exception('Failed to load event details');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  Future<void> handleParticipateButton() async {
    if (isParticipateButtonDisabled) {
      return;
    }

    try {
      // Perform your participate action here
      // For example, you can show a confirmation dialog or send a request to the server

      // Add your logic after participating (e.g., show a confirmation dialog)

      setState(() {
        isParticipateButtonDisabled = true;
      });
    } catch (e) {
      // Handle errors if any
      setState(() {
        isParticipateButtonDisabled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.eventId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('Event ID is null.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Information événement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: eventData.isNotEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 3.0,
                      color: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Event Name: ${eventData['nom']}',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Type: ${eventData['type']}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Date: ${eventData['date']}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Heure: ${eventData['heure']}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Lieu: ${eventData['lieu']}',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),

                  ElevatedButton(
                    onPressed: isParticipateButtonDisabled
                        ? null
                        : handleParticipateButton,
                    child: Text(
                      'Participate',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),

                  SizedBox(height: 16.0),

                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Promote()),
                      );
                    },
                    child: Text(
                      'Promotion',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 0, 255, 64),
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}