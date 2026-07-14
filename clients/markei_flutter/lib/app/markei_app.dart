import 'package:flutter/material.dart';

import 'markei_composition.dart';
import 'pages/home_page.dart';
import 'pages/history_page.dart';
import 'pages/lists_page.dart';
import 'pages/products_page.dart';
import 'pages/purchase_page.dart';
import 'pages/settings_page.dart';

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
    _MarkeiDestination(label: 'Home', icon: Icons.home),
    _MarkeiDestination(label: 'Lists', icon: Icons.checklist),
    _MarkeiDestination(label: 'Purchase', icon: Icons.add_shopping_cart),
    _MarkeiDestination(icon: Icons.inventory_2, label: 'Catalogue'),
    _MarkeiDestination(icon: Icons.history, label: 'History'),
    _MarkeiDestination(
      icon: Icons.analytics_outlined,
      label: 'Analytics (PIN)',
    ),
    _MarkeiDestination(icon: Icons.groups_outlined, label: 'Household (PIN)'),
    _MarkeiDestination(icon: Icons.help_outline, label: 'Guide'),
    _MarkeiDestination(
      icon: Icons.description_outlined,
      label: 'Documentation',
    ),
    _MarkeiDestination(icon: Icons.settings, label: 'Settings'),
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
            const HomePage(),
            ListsPage(
              accountId: widget.composition.accountId,
              projections: widget.composition.productLists,
              refreshSignal: _refreshSignal,
            ),
            PurchasePage(
              accountId: widget.composition.accountId,
              deviceId: widget.composition.deviceId,
              registration: widget.composition.purchaseRegistration,
              catalogueQueries: widget.composition.catalogueQueries,
              references: widget.composition.references,
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
              exports: widget.composition.purchaseExports,
              refreshSignal: _refreshSignal,
            ),
            const _PlannedPage(label: 'Analytics'),
            const _PlannedPage(label: 'Household'),
            const _StaticPage(
              title: 'Guide',
              body:
                  'Register purchases locally, then use Catalogue, History and Lists to inspect Products and estimates.',
            ),
            const _StaticPage(
              title: 'Documentation',
              body:
                  'This beta uses local offline-first storage. Synchronization and public distribution are unavailable.',
            ),
            SettingsPage(
              accountId: widget.composition.accountId,
              references: widget.composition.references,
              preferences: widget.composition.preferences,
              onChanged: () => setState(() => _refreshSignal++),
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

class _PlannedPage extends StatelessWidget {
  const _PlannedPage({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$label is planned and disabled.', key: Key('$label.pin')),
    );
  }
}

class _StaticPage extends StatelessWidget {
  const _StaticPage({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(title, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: 8),
        Text(body),
      ],
    );
  }
}

final class _MarkeiDestination {
  const _MarkeiDestination({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
