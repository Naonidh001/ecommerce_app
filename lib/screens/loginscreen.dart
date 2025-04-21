import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify/data/authprovider.dart';
import 'package:shopify/repository/loginuser.dart';
import 'package:shopify/screens/productscreen.dart';
import 'package:shopify/utils/custom.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  String username = "";
  String password = "";
  bool _isLoading = false; // <-- Loader state

  Future<void> _handleLogin() async {
    if (username.isNotEmpty && password.isNotEmpty) {
      setState(() {
        _isLoading = true; // Show loader
      });

      try {
        final user = await registerUser(username: username, password: password);

        Provider.of<Authprovider>(context, listen: false).login(
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          image: user.image,
          gender: user.gender,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProductScreen()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${e.toString()}")),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loader
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Customcomponents.getCustomText(
              text: "Login",
              clr: Colors.black,
              weight: FontWeight.w600,
              size: 45.0,
            ),
            Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  // Username Field
                  TextField(
                    onChanged: (newval) => username = newval,
                    decoration: _inputDecoration('Enter Username'),
                  ),
                  const SizedBox(height: 15.0),

                  // Password Field
                  TextField(
                    onChanged: (newval) => password = newval,
                    obscureText: true,
                    decoration: _inputDecoration('Enter Password'),
                  ),
                  const SizedBox(height: 20.0),

                  // Login Button or Loader
                  SizedBox(
                    width: double.infinity,
                    child:
                        _isLoading
                            ? const Center(child: CircularProgressIndicator())
                            : TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                side: const BorderSide(color: Colors.blue),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: _handleLogin,
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color.fromARGB(255, 240, 239, 239),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
      ),
    );
  }
}
