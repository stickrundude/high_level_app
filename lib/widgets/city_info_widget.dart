import 'package:flutter/material.dart';

class CityInfoWidget extends StatelessWidget {
  final String? cityName;

  const CityInfoWidget({super.key, this.cityName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromARGB(255, 91, 91, 91), width: 1.5),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Text.rich(
          TextSpan(
            children: [
              const TextSpan(
                text: "Notes are being stored in: ",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
              TextSpan(
                text: cityName ?? "Fetching your city...",
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
