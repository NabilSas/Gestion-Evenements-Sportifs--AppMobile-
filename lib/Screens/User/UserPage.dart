import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'AddEvent.dart';
import 'UserInfo.dart';
import 'InfoEvent.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
          accentColor: Colors.deepPurpleAccent,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'YourFontFamily',
          ),
          bodyText2: TextStyle(
            fontFamily: 'YourFontFamily',
          ),
          headline6: TextStyle(
            fontFamily: 'YourFontFamily',
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: UserPage(),
    );
  }
}

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<Map<String, dynamic>> events = [];
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:8080/events'));
      log('Status Code: ${response.statusCode}');
      log('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> eventData = jsonDecode(response.body);
        setState(() {
          events = eventData.cast<Map<String, dynamic>>();
        });
      } else {
        log('Error: ${response.statusCode}');
        log('Response body: ${response.body}');
        throw Exception('Failed to load events');
      }
    } catch (e) {
      log('Error: $e');
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _selectedTabIndex = index;

      // Fetch all events
      fetchEvents().then((_) {
        // Filter events based on the selected type if it's not empty
        String selectedType = '';
        switch (index) {
          case 0:
            selectedType = 'Football';
            break;
          case 1:
            selectedType = 'Running';
            break;
          case 2:
            selectedType = 'Basketball';
            break;
          case 3:
            selectedType = 'Swimming';
            break;
          case 4:
            selectedType = 'Tennis';
            break;
          default:
            selectedType = '';
            break;
        }

        if (selectedType.isNotEmpty) {
          // Apply the filter
          events =
              events.where((event) => event['type'] == selectedType).toList();
          print(
              events.where((event) => event['type'] == selectedType).toList());
        } else {
          fetchEvents();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listes des evenements'),
        actions: [
          // User profile button
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Redirect to UserInfo.dart
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserInfo()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Card(
            elevation: 5.0,
            margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(color: Colors.blue, width: 2.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              title: Text(
                event['nom'],
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'YourFontFamily',
                  color: Colors.indigo,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8.0),
                  Text(
                    'Type: ${event['type']}',
                    style: TextStyle(
                      fontFamily: 'YourFontFamily',
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
              trailing: Container(
                width: 200.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _getEventLogo(event['type']),
                    SizedBox(width: 50.0),
                    IconButton(
                      icon: Icon(Icons.info, color: Colors.indigo),
                      onPressed: () {
                        // Redirect to InfoEvent.dart
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => InfoEvent(eventId: event['id'])),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Football',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Running',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_basketball),
            label: 'Basketball',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pool),
            label: 'Swimming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_tennis),
            label: 'Tennis',
          ),
        ],
        currentIndex: _selectedTabIndex,
        onTap: _onTabTapped,
        selectedItemColor: Color.fromARGB(255, 123, 215, 141),
        backgroundColor: Color.fromARGB(255, 30, 137, 224),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Redirect to AddEvent.dart
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEvent()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue[100],
      ),
    );
  }

  Widget _getEventLogo(String eventType) {
    String imagePath;
    switch (eventType) {
      case 'Football':
        imagePath = '../../assets/images/foot.jpeg';
        break;
      case 'Running':
        imagePath = '../../assets/images/run.webp';
        break;
      case 'Basketball':
        imagePath = '../../assets/images/basket.jpg';
        break;
      case 'Swimming':
        imagePath = '../../assets/images/swim.jpg';
        break;
      case 'Tennis':
        imagePath = '../../assets/images/tennis.webp';
        break;
      default:
        imagePath = '../../assets/images/tennis.webp';
        break;
    }

    return Image.asset(
      imagePath,
      width: 100.0,
      height: 100.0,
      fit: BoxFit.cover,
      colorBlendMode: BlendMode.overlay,

    );
  }
}
