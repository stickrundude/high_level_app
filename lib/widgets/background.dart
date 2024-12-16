import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final String imagePath;

  const BackgroundWidget({
    required this.child,
    this.imagePath = 'assets/images/image.jpg',
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.white.withOpacity(0.5),
            BlendMode.lighten,
          ),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
        child,
      ],
    );
  }
}
