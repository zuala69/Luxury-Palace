import 'package:flutter/material.dart';

class SubDivider extends StatelessWidget {
  const SubDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 60),
      child: Divider(
        height: 1,
      ),
    );
  }
}
