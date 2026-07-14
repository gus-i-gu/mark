import 'package:flutter/material.dart';

import '../../application/home_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('home.page'),
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Markei', style: TextStyle(fontSize: 26)),
        const SizedBox(height: 12),
        for (final card in homeCards)
          Card(
            child: ListTile(title: Text(card.title), subtitle: Text(card.body)),
          ),
      ],
    );
  }
}
