import 'package:flutter/material.dart';

class IdolCardWidget extends StatelessWidget {
  final String name, avatar, hangul;
  const IdolCardWidget({
    super.key,
    required this.name,
    required this.avatar,
    required this.hangul,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        avatar,
        fit: BoxFit.cover,
        width: 50,
      ),
      title: Text(name),
      subtitle: Text(hangul),
    );
  }
}
