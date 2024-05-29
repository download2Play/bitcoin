import 'package:flutter/material.dart';

class TopImage extends StatelessWidget {
  String imageUrl;
  double? scale = 1;
  double? rotate = 1;
  double? translateOne = 1;
  double? translateTwo = 1;

  TopImage({
    super.key,
    required this.imageUrl,
    this.scale,
    this.rotate,
    this.translateOne,
    this.translateTwo,
  });

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      maxHeight: double.infinity,
      alignment: Alignment.topCenter,
      child: Transform.scale(
        scale: scale,
        child: Transform.rotate(
          angle: rotate!,
          child: Transform.translate(
            offset: Offset(translateOne!,
                translateTwo!), // Adjust this value to crop more or less from the top
            child: Image.asset(
              imageUrl, // Replace with your image path
              fit: BoxFit.cover, // Ensure the image covers the entire screen
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ),
      ),
    );
  }
}
