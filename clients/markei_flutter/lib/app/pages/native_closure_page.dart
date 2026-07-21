import 'package:flutter/material.dart';

import '../../application/closure_diagnostics.dart';
import '../native_auth_closure_runner.dart';

class NativeClosurePage extends StatefulWidget {
  const NativeClosurePage({required this.runner, super.key});

  final NativeAuthClosureRunner runner;

  @override
  State<NativeClosurePage> createState() => _NativeClosurePageState();
}

class _NativeClosurePageState extends State<NativeClosurePage> {
  String _state = 'closure-disabled';
  bool _running = false;
  ClosureDiagnosticsSnapshot? _snapshot;

  @override
  void initState() {
    super.initState();
    _refreshDiagnostics();
  }

  @override
  Widget build(BuildContext context) {
    final actions = [
      _Action('Status', widget.runner.status),
      _Action('Sign in', widget.runner.signIn),
      _Action('Enroll', widget.runner.enrollOrQueryDevice),
      _Action('Query', widget.runner.queryEnrollment),
      _Action('Sync', widget.runner.hostedSyncProbe),
      _Action('Logout', widget.runner.logout),
    ];
    final snapshot = _snapshot;
    return ListView(
      key: const Key('nativeClosure.page'),
      padding: const EdgeInsets.all(16),
      children: [
        Text('Native closure', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Text(
          _running ? 'action-running' : _state,
          key: const Key('nativeClosure.state'),
        ),
        const SizedBox(height: 16),
        if (snapshot == null)
          const _DiagnosticsCard(
            title: 'Sync overview',
            child: Text(
              'No locally recorded attempt history',
              key: Key('nativeClosure.diagnostics.empty'),
            ),
          )
        else ...[
          _SyncOverview(snapshot: snapshot),
          const SizedBox(height: 12),
          _LocalQueue(snapshot: snapshot),
          const SizedBox(height: 12),
          _Attempts(snapshot: snapshot),
          const SizedBox(height: 12),
          _Devices(snapshot: snapshot),
          const SizedBox(height: 12),
          _ActionableEvents(snapshot: snapshot),
        ],
        const SizedBox(height: 16),
        _DiagnosticsCard(
          title: 'Closure actions',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final action in actions)
                FilledButton(
                  key: Key('nativeClosure.${action.label}'),
                  onPressed: _running ? null : () => _run(action),
                  child: Text(action.label),
                ),
              OutlinedButton(
                key: const Key('nativeClosure.Refresh diagnostics'),
                onPressed: _running ? null : _refreshDiagnostics,
                child: const Text('Refresh diagnostics'),
              ),
              OutlinedButton(
                key: const Key('nativeClosure.Retry unresolved submission'),
                onPressed: _running ? null : _confirmRetryUnresolved,
                child: const Text('Retry unresolved submission'),
              ),
              OutlinedButton(
                key: const Key('nativeClosure.Clear diagnostic history'),
                onPressed: _running ? null : _confirmClearHistory,
                child: const Text('Clear diagnostic history'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _run(_Action action) async {
    setState(() => _running = true);
    final result = await action.run();
    final snapshot = await widget.runner.diagnostics();
    if (!mounted) return;
    setState(() {
      _state = result.state;
      _snapshot = snapshot;
      _running = false;
    });
  }

  Future<void> _refreshDiagnostics() async {
    final snapshot = await widget.runner.diagnostics();
    if (!mounted) return;
    setState(() => _snapshot = snapshot);
  }

  Future<void> _confirmRetryUnresolved() async {
    final preflight = await widget.runner.unknownRetryPreflight();
    if (!mounted) return;
    if (!preflight.eligible) {
      final snapshot = await widget.runner.diagnostics();
      if (!mounted) return;
      setState(() {
        _state = preflight.state;
        _snapshot = snapshot;
      });
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Retry unresolved submission'),
        content: Text(
          'This will retry the same unresolved submission without changing '
          'local events. Events ${preflight.firstDeviceSequence}-'
          '${preflight.lastDeviceSequence}; next local sequence '
          '${preflight.nextLocalDeviceSequence}; submission '
          '#${preflight.submissionFingerprint}. Hosted outcome is unresolved.',
          key: const Key('nativeClosure.retry.guidance'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('nativeClosure.retry.confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
    if (confirmed != true) {
      setState(() => _state = 'unknown-retry-cancelled');
      return;
    }
    setState(() => _running = true);
    final result = await widget.runner.retryUnresolvedSubmission();
    final snapshot = await widget.runner.diagnostics();
    if (!mounted) return;
    setState(() {
      _state = result.state;
      _snapshot = snapshot;
      _running = false;
    });
  }

  Future<void> _confirmClearHistory() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear diagnostic history'),
        content: const Text('Only local Sync attempt history will be cleared.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            key: const Key('nativeClosure.clear.confirm'),
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() => _running = true);
    await widget.runner.clearDiagnosticHistory();
    final snapshot = await widget.runner.diagnostics();
    if (!mounted) return;
    setState(() {
      _state = 'diagnostic-history-cleared';
      _snapshot = snapshot;
      _running = false;
    });
  }
}

final class _SyncOverview extends StatelessWidget {
  const _SyncOverview({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _DiagnosticsCard(
      title: 'Sync overview',
      child: _KeyValueGrid(
        children: [
          _DiagnosticValue('Authentication', snapshot.authenticationState),
          _DiagnosticValue('Enrollment', snapshot.enrollmentState),
          _DiagnosticValue('Readiness', snapshot.syncReadiness),
          _DiagnosticValue('Last result', snapshot.lastResult),
          _DiagnosticValue(
            'Last successful sync',
            _timeOrNotRecorded(snapshot.lastSuccessfulSyncAt),
          ),
          _DiagnosticValue('Recovery guidance', snapshot.recoveryGuidance),
        ],
      ),
    );
  }
}

final class _LocalQueue extends StatelessWidget {
  const _LocalQueue({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return _DiagnosticsCard(
      title: 'Local queue',
      child: _KeyValueGrid(
        children: [
          _DiagnosticValue('Pending', '${snapshot.queueCounts.pending}'),
          _DiagnosticValue('Uploading', '${snapshot.queueCounts.uploading}'),
          _DiagnosticValue('Failed', '${snapshot.queueCounts.failed}'),
          _DiagnosticValue('Unknown', '${snapshot.queueCounts.unknown}'),
          _DiagnosticValue(
            'Next Device sequence',
            snapshot.nextDeviceSequence?.toString() ?? 'Unavailable',
          ),
        ],
      ),
    );
  }
}

final class _Attempts extends StatelessWidget {
  const _Attempts({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final attempts = snapshot.recentAttempts;
    return _DiagnosticsCard(
      title: 'Recent sync attempts',
      child: attempts.isEmpty
          ? const Text(
              'No locally recorded attempt history',
              key: Key('nativeClosure.attempts.empty'),
            )
          : Column(
              key: const Key('nativeClosure.attempts'),
              children: [
                for (final attempt in attempts)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${attempt.resultCode} #${attempt.fingerprint}',
                    ),
                    subtitle: Text(
                      '${attempt.outcomeClass} / ${attempt.phase} / '
                      '${attempt.recoveryCode ?? 'no-recovery-code'} / '
                      '${_duration(attempt.duration)}',
                    ),
                  ),
              ],
            ),
    );
  }
}

final class _Devices extends StatelessWidget {
  const _Devices({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final devices = snapshot.devices;
    return _DiagnosticsCard(
      title: 'Devices',
      child: devices.isEmpty
          ? const Text('Unavailable', key: Key('nativeClosure.devices.empty'))
          : Column(
              key: const Key('nativeClosure.devices'),
              children: [
                for (final device in devices)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      '${device.isCurrent ? 'Current' : 'Device'} '
                      '#${device.fingerprint}',
                    ),
                    subtitle: Text(
                      '${device.enrollmentState} / next ${device.nextSequence}',
                    ),
                  ),
              ],
            ),
    );
  }
}

final class _ActionableEvents extends StatelessWidget {
  const _ActionableEvents({required this.snapshot});

  final ClosureDiagnosticsSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final events = snapshot.actionableEvents;
    return _DiagnosticsCard(
      title: 'Actionable events',
      child: events.isEmpty
          ? const Text(
              'No pending, failed or unknown events',
              key: Key('nativeClosure.events.empty'),
            )
          : Column(
              key: const Key('nativeClosure.events'),
              children: [
                for (final event in events)
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text('${event.eventType} #${event.fingerprint}'),
                    subtitle: Text(
                      '${event.state} / sequence ${event.deviceSequence}',
                    ),
                  ),
              ],
            ),
    );
  }
}

final class _DiagnosticsCard extends StatelessWidget {
  const _DiagnosticsCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            child,
          ],
        ),
      ),
    );
  }
}

final class _KeyValueGrid extends StatelessWidget {
  const _KeyValueGrid({required this.children});

  final List<_DiagnosticValue> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 720 ? 3 : 1;
        return GridView.count(
          crossAxisCount: columns,
          childAspectRatio: columns == 1 ? 5 : 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: children,
        );
      },
    );
  }
}

final class _DiagnosticValue extends StatelessWidget {
  const _DiagnosticValue(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(value, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}

String _timeOrNotRecorded(DateTime? value) {
  return value == null ? 'Not recorded' : value.toUtc().toIso8601String();
}

String _duration(Duration? value) {
  if (value == null) return 'duration-unavailable';
  return '${value.inMilliseconds}ms';
}

final class _Action {
  const _Action(this.label, this.run);

  final String label;
  final Future<NativeClosureStatus> Function() run;
}
