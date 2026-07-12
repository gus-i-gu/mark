import 'package:flutter/material.dart';

import 'markei_composition.dart';
import 'pages/history_page.dart';
import 'pages/purchase_page.dart';

class MarkeiApp extends StatefulWidget {
  const MarkeiApp({required this.composition, super.key});

  final MarkeiComposition composition;

  @override
  State<MarkeiApp> createState() => _MarkeiAppState();
}

class _MarkeiAppState extends State<MarkeiApp> {
  int _selectedIndex = 0;
  int _refreshSignal = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markei',
      theme: ThemeData(colorSchemeSeed: const Color(0xff246b5a)),
      home: Scaffold(
        appBar: AppBar(title: const Text('Markei')),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            PurchasePage(
              accountId: widget.composition.accountId,
              deviceId: widget.composition.deviceId,
              registration: widget.composition.purchaseRegistration,
              catalogueQueries: widget.composition.catalogueQueries,
              onRegistered: () => setState(() => _refreshSignal++),
            ),
            HistoryPage(
              accountId: widget.composition.accountId,
              history: widget.composition.purchaseHistory,
              refreshSignal: _refreshSignal,
            ),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() => _selectedIndex = index);
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.add_shopping_cart),
              label: 'Purchase',
            ),
            NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          ],
        ),
      ),
    );
  }
}
