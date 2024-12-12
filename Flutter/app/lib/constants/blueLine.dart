import 'package:app/constants/theme.dart';
import 'package:flutter/material.dart';

class DecoratorHorizontal extends StatelessWidget {
  const DecoratorHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
          side: const BorderSide(color: AppTheme.mainBlue)),
      child: SizedBox(
        height: 2,
        width: MediaQuery.of(context).size.width / 1.30,
      ),
    );
  }
}
