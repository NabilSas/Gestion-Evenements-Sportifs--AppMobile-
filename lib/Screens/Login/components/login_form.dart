import 'package:flutter/material.dart';
import '../../Admin/AdminPage.dart';
import '../../User/UserPage.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  Future<void> login(
      String username, String password, BuildContext context) async {
    if (username.isEmpty || password.isEmpty) {
      // Show error message for empty fields
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both username and password.'),
          duration: const Duration(seconds: 1),
        ),
      );
      return;
    }

    final Uri apiUrl = Uri.parse('http://localhost:8080/api/auth/signin');
    try {
      final response = await http.post(
        apiUrl,
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      final responseData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Successful login
        final responseData = jsonDecode(response.body);
        final token =
            responseData['token']; // Assuming token key in the response
        final roles =
            responseData['roles']; // Assuming roles key in the response

        if (roles.contains('ROLE_ADMIN')) {
          // Redirect to admin page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AdminPage(), // Replace with your admin page widget
            ),
          );
        } else {
          // Redirect to user page
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  UserPage(), // Replace with your user page widget
            ),
          );
        }
      } else {
        final errorMessage = responseData[
            'message']; // Assuming error message key in the response
        if (errorMessage.contains('Invalid Password')) {
          // Show error message for incorrect password
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Invalid password. Please try again.'),
            ),
          );
        } else {
          // Show general login failed message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed. Please try again.'),
              duration: const Duration(seconds: 1),
            ),
          );
        }
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during login: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception during login. Please check your network.'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Form(
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            controller: usernameController,
            decoration: const InputDecoration(
              hintText: "Enter your Username",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: PasswordField(controller: passwordController),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: () {
              final String username = usernameController.text;
              final String password = passwordController.text;

              login(username, password, context); // Call the login function
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      cursorColor: kPrimaryColor,
      decoration: InputDecoration(
        hintText: "Enter your password",
        prefixIcon: Padding(
          padding: EdgeInsets.all(defaultPadding),
          child: Icon(Icons.lock),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
