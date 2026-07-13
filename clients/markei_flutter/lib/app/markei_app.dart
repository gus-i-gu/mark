import 'package:flutter/material.dart';

import 'markei_composition.dart';
import 'pages/history_page.dart';
import 'pages/products_page.dart';
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

  static const _destinations = <_MarkeiDestination>[
    _MarkeiDestination(label: 'Purchase', icon: Icons.add_shopping_cart),
    _MarkeiDestination(icon: Icons.inventory_2, label: 'Products'),
    _MarkeiDestination(icon: Icons.history, label: 'History'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markei',
      theme: ThemeData(colorSchemeSeed: const Color(0xff246b5a)),
      home: LayoutBuilder(
        builder: (context, constraints) {
          final useRail = constraints.maxWidth >= 720;
          final pages = [
            PurchasePage(
              accountId: widget.composition.accountId,
              deviceId: widget.composition.deviceId,
              registration: widget.composition.purchaseRegistration,
              catalogueQueries: widget.composition.catalogueQueries,
              onRegistered: () => setState(() => _refreshSignal++),
            ),
            ProductsPage(
              accountId: widget.composition.accountId,
              catalogueQueries: widget.composition.catalogueQueries,
              refreshSignal: _refreshSignal,
              onChanged: () => setState(() => _refreshSignal++),
            ),
            HistoryPage(
              accountId: widget.composition.accountId,
              history: widget.composition.purchaseHistory,
              refreshSignal: _refreshSignal,
            ),
          ];

          final content = SafeArea(
            child: IndexedStack(index: _selectedIndex, children: pages),
          );

          return Scaffold(
            appBar: AppBar(title: const Text('Markei')),
            body: useRail
                ? Row(
                    children: [
                      NavigationRail(
                        key: const Key('markei.navigationRail'),
                        selectedIndex: _selectedIndex,
                        onDestinationSelected: _selectDestination,
                        labelType: NavigationRailLabelType.all,
                        destinations: [
                          for (final destination in _destinations)
                            NavigationRailDestination(
                              icon: Icon(destination.icon),
                              label: Text(destination.label),
                            ),
                        ],
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(child: content),
                    ],
                  )
                : content,
            bottomNavigationBar: useRail
                ? null
                : NavigationBar(
                    key: const Key('markei.navigationBar'),
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: _selectDestination,
                    destinations: [
                      for (final destination in _destinations)
                        NavigationDestination(
                          icon: Icon(destination.icon),
                          label: destination.label,
                        ),
                    ],
                  ),
          );
        },
      ),
    );
  }

  void _selectDestination(int index) {
    setState(() => _selectedIndex = index);
  }
}

final class _MarkeiDestination {
  const _MarkeiDestination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
