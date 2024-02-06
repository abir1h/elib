import 'package:flutter/material.dart';

class ProgressInfoWidget extends StatelessWidget {
  const ProgressInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(),
        ],
      ),
    );
  }
}
