import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddEvent extends StatefulWidget {
  @override
  _AddEventState createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  TextEditingController _nomController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _heureController = TextEditingController();
  TextEditingController _lieuController = TextEditingController();

  // Dropdown items for the 'Type' dropdown
  List<String> _typeOptions = [
    'Football',
    'Swimming',
    'Basketball',
    'Tennis',
    'Running'
  ];
  String _selectedType = 'Football';

  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un evenement'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Nom', _nomController),
            SizedBox(height: 16.0),
            _buildTypeDropdown(),
            SizedBox(height: 16.0),
            _buildDateField(),
            SizedBox(height: 16.0),
            _buildTextField('Heure', _heureController),
            SizedBox(height: 16.0),
            _buildTextField('Lieu', _lieuController),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _createEvent,
              child: Text('Ajouter un evenement'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Enter $label',
          ),
        ),
      ],
    );
  }

  Widget _buildTypeDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Type',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: DropdownButton<String>(
            value: _selectedType,
            items: _typeOptions.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedType = newValue ?? '';
              });
            },
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            underline: Container(),
            icon: Icon(Icons.arrow_drop_down),
            isExpanded: true,
          ),
        ),
      ],
    );
  }

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            'Date',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        TextField(
          controller: _dateController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Select Date',
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ),
          readOnly: true,
          onTap: () => _selectDate(context),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  void _createEvent() async {
    if (_validateFields()) {
      String nom = _nomController.text;
      String type = _selectedType;
      String date = _dateController.text;
      String heure = _heureController.text;
      String lieu = _lieuController.text;

      // Prepare the request body
      Map<String, dynamic> requestBody = {
        'nom': nom,
        'type': type,
        'date': date,
        'heure': heure,
        'lieu': lieu,
      };

      try {
        // Make a POST request to the API endpoint with proper headers
        final response = await http.post(
          Uri.parse('http://localhost:8080/events/add'),
          headers: {
            'Content-Type': 'application/json', // Set the content type to JSON
          },
          body: jsonEncode(requestBody), // Encode the body as JSON
        );

        if (response.statusCode == 200) {
          // Event added successfully
          print('Event added successfully');
          // Optionally, you can navigate to another screen or show a success message.

          // Redirect to UserPage.dart
          Navigator.pop(context);
        } else {
          // Handle the error, e.g., print the error message
          print('Error: ${response.statusCode} - ${response.body}');
          // Optionally, you can show an error message to the user.

          Navigator.pop(context);
        }
      } catch (e) {
        // Handle any exceptions that occur during the HTTP request
        print('Error: $e');
        // Optionally, you can show an error message to the user.
        _showErrorSnackBar('Error during the request');
      }
    }
  }

  bool _validateFields() {
    if (_nomController.text.isEmpty ||
        _dateController.text.isEmpty ||
        _heureController.text.isEmpty ||
        _lieuController.text.isEmpty) {
      _showErrorSnackBar('All fields are required');
      return false;
    }
    return true;
  }

  void _showErrorSnackBar(String message) {
    // Display a SnackBar with the provided error message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 3),
      ),
    );
  }
}
