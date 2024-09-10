import 'package:flutter/material.dart';
import 'package:task_management_app/screens/registration_screen.dart';
import 'package:task_management_app/services/strapi_service.dart';
import 'package:task_management_app/widgets/bubble_painter.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  BorderRadius start = BorderRadius.circular(10);
  BorderRadius end = BorderRadius.circular(30);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final StrapiService _strapiService = StrapiService();
  String message = '';

  Future<void> _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        message = 'Please fill in both email and password';
      });
      return;
    }
    try {
      dynamic data = await _strapiService.loginUser(email, password);
      String? jwt = data?['jwt'];
      if (jwt != null) {
        setState(() {
          message = 'Login successful! Token: $jwt';
        });
      } else {
        setState(() {
          message = 'Login Failed! Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        message = 'Error during login: $e';
      });
    }
  }

  double t = 0.5;

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Stack(children: [
      Container(
        color: Colors.white,
      ),
      CustomPaint(painter: BubblePainter(), child: Container()),
      Center(
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 10))
                ]),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text("Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.purple)),
              const SizedBox(height: 30),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email),
                  labelText: 'Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password),
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 3.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(color: Colors.purple, width: 1.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Login'),
              ),
              TextButton(
                child: const Text("not Registered? click here"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()),
                  );
                },
              ),
              const SizedBox(height: 20),
              Text(message)
            ])),
      ),
    ])));
  }
}
