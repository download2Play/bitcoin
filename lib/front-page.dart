import 'package:bitcoin/login.dart';
import 'package:bitcoin/widget/bottom-nav.dart';
import 'package:bitcoin/widget/top-image.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatefulWidget {
  @override
  _FrontPageState createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  double _scale = 1.2;
  double _rotation = 0.2;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Color(0xFF002A59), // Background color
          child: Stack(
            children: [
              // Fullscreen background image
              TopImage(
                  imageUrl: "assets/images/crypto-3d.png",
                  scale: 1.25,
                  rotate: 0.2,
                  translateOne: -15,
                  translateTwo: -30),
              // Contents overlaying the image
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Empty expanded widget to push content to the bottom
                    // Expanded(child: SizedBox()),
                    const SizedBox(
                      height: 370,
                    ),
                    // Text
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'SEARCHING FOR LOST',
                          style: TextStyle(
                            fontFamily: "American",
                            fontSize: 24.0,
                            height:
                                0.9, // Adjust this value to change the line height
                            color: Color(
                                0xFFADD8E6), // Text color on top of the image
                          ),
                        ),
                        Text(
                          'BRUTE CRYPTO',
                          style: TextStyle(
                            fontFamily: "Strome",
                            fontSize: 34.0,
                            height:
                                0.8, // Adjust this value to change the line height
                            color: Color(
                                0xFFADD8E6), // Text color on top of the image
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    // Two Buttons
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Action for Buy the Program button
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF002A59),
                              backgroundColor: const Color.fromARGB(
                                  255, 51, 183, 228), // Dark blue text color
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              textStyle: const TextStyle(fontSize: 18.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'BUY THE PROGRAM',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // Action for Login button
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: const Color(0xFF002A59),
                              backgroundColor: const Color(
                                  0xFFADD8E6), // Dark blue text color
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              textStyle: const TextStyle(fontSize: 18.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Text(
                              'LOGIN',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 50.0), // Some additional space at the bottom
                    const Text(
                      'BRUTECRYPTO',
                      style: TextStyle(
                        fontFamily: "Strome",
                        fontSize: 12.0,
                        height:
                            0.8, // Adjust this value to change the line height
                        color:
                            Color(0xFFADD8E6), // Text color on top of the image
                      ),
                    ),
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
