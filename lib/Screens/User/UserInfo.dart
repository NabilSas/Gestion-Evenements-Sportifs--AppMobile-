import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';// Import the file where your WelcomeScreen is defined

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information Utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfilePicture(),
                SizedBox(height: 16.0),
                _buildInfoLabel('Username'),
                _buildInfoValue('test123'), // Replace with the actual username
                SizedBox(height: 16.0),
                _buildInfoLabel('Email'),
                _buildInfoValue('test123@example.com'), // Replace with the actual email
                SizedBox(height: 24.0),
                _buildLogoutButton(context), // Add the logout button
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.indigo,
      ),
    );
  }

  Widget _buildInfoValue(String value) {
    return Text(
      value,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: CircleAvatar(
        radius: 60.0,
        backgroundColor: Colors.indigo,
        child: CircleAvatar(
          radius: 55.0,
          backgroundImage: AssetImage('assets/images/pic.jpg'), // Replace with your image asset
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle the logout logic here
        print('User logged out');

        // Navigate to the WelcomeScreen after logout
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen()),
          (route) => false,
        );

        // You can add your actual logout logic here, such as clearing user session, navigating to the login screen, etc.
      },
      child: Text(
        'Se Déconnecter',
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.red, // Use your desired color for the button
      ),
    );
  }
}
