import 'package:flutter/material.dart';

import '../../application/local_references.dart';
import '../../domain/references/local_reference.dart';
import '../../domain/shared/ids.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    required this.accountId,
    required this.references,
    required this.preferences,
    required this.onChanged,
    super.key,
  });

  final AccountId accountId;
  final LocalReferenceRepository references;
  final AccountPreferenceRepository preferences;
  final VoidCallback onChanged;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _personController = TextEditingController();
  final _paymentController = TextEditingController();
  final _thresholdController = TextEditingController(text: '5');
  int _refresh = 0;
  String? _message;

  @override
  void dispose() {
    _personController.dispose();
    _paymentController.dispose();
    _thresholdController.dispose();
    super.dispose();
  }

  Future<void> _saveReference(
    LocalReferenceKind kind,
    TextEditingController controller,
  ) async {
    await widget.references.saveReference(
      accountId: widget.accountId,
      kind: kind,
      nickname: controller.text,
    );
    controller.clear();
    setState(() {
      _refresh++;
      _message = kind == LocalReferenceKind.person
          ? 'Person saved locally.'
          : 'Payment Method saved locally.';
    });
    widget.onChanged();
  }

  Future<void> _saveThreshold() async {
    await widget.preferences.setShortageThresholdDays(
      widget.accountId,
      int.parse(_thresholdController.text.trim()),
    );
    setState(() => _message = 'Shortage threshold saved locally.');
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      key: const Key('settings.page'),
      padding: const EdgeInsets.all(16),
      children: [
        const Text('Settings', style: TextStyle(fontSize: 22)),
        const SizedBox(height: 8),
        const Text(
          'People and Payment Methods are optional labels stored locally on this device. A Payment Method stores no card number, bank detail or payment credential.',
        ),
        const Divider(height: 32),
        _ReferenceSection(
          key: ValueKey('people-$_refresh'),
          title: 'People',
          kind: LocalReferenceKind.person,
          accountId: widget.accountId,
          repository: widget.references,
          controller: _personController,
          saveLabel: 'Save Person',
          onSave: () =>
              _saveReference(LocalReferenceKind.person, _personController),
        ),
        const Divider(height: 32),
        _ReferenceSection(
          key: ValueKey('payments-$_refresh'),
          title: 'Payment Methods',
          kind: LocalReferenceKind.paymentMethod,
          accountId: widget.accountId,
          repository: widget.references,
          controller: _paymentController,
          saveLabel: 'Save Payment Method',
          onSave: () => _saveReference(
            LocalReferenceKind.paymentMethod,
            _paymentController,
          ),
        ),
        const Divider(height: 32),
        TextField(
          key: const Key('settings.shortageThreshold'),
          controller: _thresholdController,
          decoration: const InputDecoration(
            labelText: 'Shortage threshold days',
          ),
        ),
        const SizedBox(height: 8),
        FilledButton(
          key: const Key('settings.saveThreshold'),
          onPressed: _saveThreshold,
          child: const Text('Save threshold'),
        ),
        if (_message != null) ...[
          const SizedBox(height: 12),
          Text(_message!, key: const Key('settings.message')),
        ],
      ],
    );
  }
}

class _ReferenceSection extends StatelessWidget {
  const _ReferenceSection({
    super.key,
    required this.title,
    required this.kind,
    required this.accountId,
    required this.repository,
    required this.controller,
    required this.saveLabel,
    required this.onSave,
  });

  final String title;
  final LocalReferenceKind kind;
  final AccountId accountId;
  final LocalReferenceRepository repository;
  final TextEditingController controller;
  final String saveLabel;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LocalReference>>(
      future: repository.listReferences(accountId, kind, includeArchived: true),
      builder: (context, snapshot) {
        final references = snapshot.data ?? const <LocalReference>[];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18)),
            for (final reference in references)
              ListTile(
                title: Text(reference.historyLabel),
                subtitle: Text(reference.active ? 'Active' : 'Archived'),
                trailing: reference.active
                    ? TextButton(
                        onPressed: () => repository.archiveReference(
                          accountId: accountId,
                          kind: kind,
                          id: reference.id,
                        ),
                        child: const Text('Archive'),
                      )
                    : null,
              ),
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Nickname'),
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(onPressed: onSave, child: Text(saveLabel)),
          ],
        );
      },
    );
  }
}
