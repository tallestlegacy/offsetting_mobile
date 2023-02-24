import 'package:flutter/material.dart';

class SanityText extends StatelessWidget {
  final json;
  const SanityText({super.key, required this.json});

  TextSpan span(var obj) {
    switch (obj["_type"]) {
      case "span":
        return TextSpan(
          text: obj["text"],
          style: TextStyle(
              fontWeight:
                  obj["style"].contains("strong") ? FontWeight.bold : null),
        );
      case "block":
        return TextSpan(
          style: TextStyle(
            fontSize: obj["style"] == "h3" ? 20 : null,
            fontWeight: obj["style"] == "h3" ? FontWeight.bold : null,
          ),
          children: [
            ...obj["children"].map((child) {
              return TextSpan(
                text: child["text"].toString(),
                style: TextStyle(
                  fontWeight: child["marks"].contains("strong")
                      ? FontWeight.bold
                      : null,
                  fontStyle:
                      child["marks"].contains("em") ? FontStyle.italic : null,
                ),
              );
            }),
          ],
        );
    }
    return const TextSpan(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 16,
      children: [
        ...json.map((section) {
          if (section["_type"] == "block") {
            return Text.rich(span(section));
          }
          return Text(
            section.toString(),
          );
        })
      ],
    );
  }
}
