import 'package:flutter/material.dart';

import 'design/markei_theme.dart';
import 'markei_composition.dart';
import 'pages/home_page.dart';
import 'pages/history_page.dart';
import 'pages/lists_page.dart';
import 'pages/native_closure_page.dart';
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

  static const _compactIndexes = [0, 1, 2, 4];

  List<_MarkeiDestination> get _destinations => [
    const _MarkeiDestination(label: 'Home', icon: Icons.home),
    const _MarkeiDestination(label: 'Lists', icon: Icons.checklist),
    const _MarkeiDestination(label: 'Purchase', icon: Icons.add_shopping_cart),
    const _MarkeiDestination(icon: Icons.inventory_2, label: 'Catalogue'),
    const _MarkeiDestination(icon: Icons.history, label: 'History'),
    const _MarkeiDestination(
      icon: Icons.analytics_outlined,
      label: 'Analytics (PIN)',
    ),
    const _MarkeiDestination(
      icon: Icons.groups_outlined,
      label: 'Household (PIN)',
    ),
    const _MarkeiDestination(icon: Icons.help_outline, label: 'Guide'),
    const _MarkeiDestination(
      icon: Icons.description_outlined,
      label: 'Documentation',
    ),
    const _MarkeiDestination(icon: Icons.settings, label: 'Settings'),
    if (widget.composition.nativeClosureSurfaceEnabled)
      const _MarkeiDestination(icon: Icons.vpn_key_outlined, label: 'Closure'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Markei',
      theme: markeiTheme(),
      home: LayoutBuilder(
        builder: (context, constraints) {
          final useRail = constraints.maxWidth >= 600;
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
              refreshSignal: _refreshSignal,
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
            if (widget.composition.nativeClosureSurfaceEnabled)
              NativeClosurePage(runner: widget.composition.nativeClosureRunner),
          ];
          final destinations = _destinations;

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
                        scrollable: true,
                        destinations: [
                          for (final destination in destinations)
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
                : Builder(
                    builder: (barContext) => NavigationBar(
                      key: const Key('markei.navigationBar'),
                      selectedIndex: _compactSelectedIndex,
                      onDestinationSelected: (index) =>
                          _selectCompactDestination(index, barContext),
                      destinations: const [
                        NavigationDestination(
                          icon: Icon(Icons.home),
                          label: 'Home',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.checklist),
                          label: 'Lists',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.add_shopping_cart),
                          label: 'Purchase',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.history),
                          label: 'History',
                        ),
                        NavigationDestination(
                          icon: Icon(Icons.more_horiz),
                          label: 'More',
                        ),
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }

  void _selectDestination(int index) {
    setState(() => _selectedIndex = index);
  }

  int get _compactSelectedIndex {
    final compactIndex = _compactIndexes.indexOf(_selectedIndex);
    return compactIndex == -1 ? 4 : compactIndex;
  }

  void _selectCompactDestination(int index, BuildContext sheetContext) {
    if (index < _compactIndexes.length) {
      _selectDestination(_compactIndexes[index]);
      return;
    }
    showModalBottomSheet<void>(
      context: sheetContext,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            for (
              var destinationIndex = 0;
              destinationIndex < _destinations.length;
              destinationIndex++
            )
              if (!_compactIndexes.contains(destinationIndex))
                ListTile(
                  leading: Icon(_destinations[destinationIndex].icon),
                  title: Text(_destinations[destinationIndex].label),
                  onTap: () {
                    Navigator.of(context).pop();
                    _selectDestination(destinationIndex);
                  },
                ),
          ],
        ),
      ),
    );
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
