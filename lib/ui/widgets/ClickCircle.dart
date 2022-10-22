import 'package:flutter/material.dart';

class ClickCircle extends StatelessWidget {
  const ClickCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 8,
      height: 8,
      child: CircleAvatar(backgroundColor: Colors.red),
    );
  }
}

class SimpleCirsle extends StatelessWidget {
  const SimpleCirsle({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 8.0,
      height: 8.0,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 10.0,
      ),
    );
  }
}
