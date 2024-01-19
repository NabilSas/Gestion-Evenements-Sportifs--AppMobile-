import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

Future<void> sendInvitationEmail({String? friendEmail}) async {
  final serviceId = 'service_pfa5';
  final templateId = 'template_4elaasf';
  final userId = 'RUux4-FOkvsdQqdqZ';
  var url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

  try {
    var response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'to_email': friendEmail,
          'message': 'You are invited to join the event!',
          'subject': 'Invitation to Event',
        },
      }),
    );

    print('[INVITATION EMAIL SENT]');
    print(response.body);
  } catch (error) {
    print('[SEND INVITATION EMAIL ERROR]');
    print(error.toString());
    throw error;
  }
}

class Promote extends StatefulWidget {
  @override
  _PromoteState createState() => _PromoteState();
}

class _PromoteState extends State<Promote> {
  final TextEditingController _emailController = TextEditingController();
  final _emailRegex = RegExp(
    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$', // Basic email pattern
  );

  bool _isEmailValid = true;

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Invitation email sent successfully!'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promote Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Email text field
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                errorText: _isEmailValid ? null : 'Invalid email format',
              ),
            ),

            SizedBox(height: 16.0), // Add spacing

            // Send button
            ElevatedButton(
              onPressed: () async {
                // Validate email format
                final isValid = _emailRegex.hasMatch(_emailController.text);

                // Update the state to reflect the email validity
                setState(() {
                  _isEmailValid = isValid;
                });

                // If the email is valid, send an invitation email
                if (isValid) {
                  try {
                    await sendInvitationEmail(friendEmail: _emailController.text);
                    _showSuccessSnackBar();
                  } catch (error) {
                    // Handle the error if the email sending fails
                    print('Error sending invitation email: $error');
                    // Optionally, you can show an error message using SnackBar
                  }
                }
              },
              child: Text(
                'Send',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blue, // Button background color
                onPrimary: Colors.white, // Text color
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // Button padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Button border radius
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
