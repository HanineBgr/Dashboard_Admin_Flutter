// dashboard_card.dart
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final int value;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  DashboardCard({
    required this.title,
    required this.value,
    this.titleStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // Définir la largeur souhaitée ici
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: titleStyle ?? Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 8.0),
              Text(
                '$value',
                style: valueStyle ??
                    Theme.of(context).textTheme.headline4!.copyWith(
                          color: Colors.black, // Couleur du texte par défaut
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

