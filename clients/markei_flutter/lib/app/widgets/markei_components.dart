import 'package:flutter/material.dart';

class MarkeiCard extends StatelessWidget {
  const MarkeiCard({required this.child, super.key, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(16),
        child: child,
      ),
    );
  }
}

class MarkeiStatePanel extends StatelessWidget {
  const MarkeiStatePanel({
    required this.message,
    super.key,
    this.icon = Icons.info_outline,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MarkeiCard(
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    );
  }
}

class MarkeiStatusChip extends StatelessWidget {
  const MarkeiStatusChip({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      side: BorderSide(color: Theme.of(context).colorScheme.secondary),
    );
  }
}
