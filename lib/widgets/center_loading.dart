import 'package:flutter/cupertino.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(),
    );
  }
}
