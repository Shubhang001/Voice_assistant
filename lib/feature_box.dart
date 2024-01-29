import 'package:chat_bot/pallete.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  const FeatureBox(
      {super.key,
      required this.color,
      required this.headerText,
      required this.descriptionText});
  final Color color;
  final String headerText;
  final String descriptionText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, bottom: 20, left: 15, right: 5),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style: const TextStyle(
                    color: Pallete.blackColor,
                    fontSize: 18,
                    fontFamily: "Cera Pro",
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 3),
            Text(
              descriptionText,
              style: const TextStyle(
                color: Pallete.blackColor,
                // fontSize: 18,
                fontFamily: "Cera Pro",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
