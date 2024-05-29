import 'package:bitcoin/blockchain.dart';
import 'package:bitcoin/widget/bottom-nav.dart';
import 'package:bitcoin/widget/top-image.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF002A59),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              // Background Image or any background widget

              TopImage(
                imageUrl: "assets/images/ethereum.png",
                scale: 1.1,
                rotate: -0.20,
                translateOne: -25,
                translateTwo: -60,
              ),
              // Content
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF1A3B5D),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color(0xFFADD8E6)),
                        suffixIcon:
                            Icon(Icons.person, color: Color(0xFFADD8E6)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFADD8E6)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFADD8E6)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFF1A3B5D),
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Color(0xFFADD8E6)),
                        suffixIcon: Icon(Icons.lock, color: Color(0xFFADD8E6)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFADD8E6)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFADD8E6)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () {
                        // Action for Login button
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CButtomNav()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Color(0xFF002A59),
                        backgroundColor: Color(0xFFADD8E6),
                        padding: EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 50),
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 5,
                      ),
                      child: Text('LOG IN'),
                    ),
                    SizedBox(height: 50.0),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            '*To log in, enter the data in the input field',
                            style: TextStyle(
                              fontSize: 10.0,
                              height: 0.8,
                              color: Color(0xFFADD8E6),
                            ),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            'BRUTECRYPTO',
                            style: TextStyle(
                              fontFamily: "Strome",
                              fontSize: 12.0,
                              height: 0.8,
                              color: Color(0xFFADD8E6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
