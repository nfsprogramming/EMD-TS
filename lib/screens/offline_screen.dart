import 'dart:async';

import 'package:flutter/material.dart';

import '../models/demo_data.dart';
import '../widgets/clinical_scaffold.dart';

/// The stages of the reconnect-and-sync animation on the Offline screen.
enum _SyncStage { offline, reconnected, syncing, done }

/// Screen 5 — Offline Mode (the money screen).
///
/// Shows the offline state with three local-capability checkmarks, then
/// animates the reconnect sequence on demand: "✓ Connection restored" →
/// "Synchronizing..." → summary (24 / 3 / 7), with a way back to the
/// dashboard and a way to simulate going offline again.
///
/// All of this is simulated for the demo — the banner below is the proof.
class OfflineScreen extends StatefulWidget {
  const OfflineScreen({super.key, required this.onReturnToDashboard});

  final VoidCallback onReturnToDashboard;

  @override
  State<OfflineScreen> createState() => _OfflineScreenState();
}

class _OfflineScreenState extends State<OfflineScreen> {
  _SyncStage _stage = _SyncStage.offline;
  Timer? _connectionTimer;
  Timer? _syncTimer;

  @override
  void dispose() {
    _connectionTimer?.cancel();
    _syncTimer?.cancel();
    super.dispose();
  }

  void _startSync() {
    setState(() => _stage = _SyncStage.reconnected);
    _connectionTimer?.cancel();
    _syncTimer?.cancel();
    _connectionTimer = Timer(const Duration(milliseconds: 1400), () {
      if (!mounted) return;
      setState(() => _stage = _SyncStage.syncing);
    });
    _syncTimer = Timer(const Duration(milliseconds: 1400 + 2600), () {
      if (!mounted) return;
      setState(() => _stage = _SyncStage.done);
    });
  }

  void _simulateOfflineAgain() {
    _connectionTimer?.cancel();
    _syncTimer?.cancel();
    setState(() => _stage = _SyncStage.offline);
  }

  @override
  Widget build(BuildContext context) {
    return ClinicalScreen(
      title: 'OFFLINE MODE',
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 40,
              ),
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 350),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: _buildStage(context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildStage(BuildContext context) {
    switch (_stage) {
      case _SyncStage.offline:
        return _buildOfflineState(context);
      case _SyncStage.reconnected:
        return _buildReconnectedState(context);
      case _SyncStage.syncing:
        return _buildSyncingState(context);
      case _SyncStage.done:
        return _buildDoneState(context);
    }
  }

  Widget _buildOfflineState(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      key: const ValueKey<_SyncStage>(_SyncStage.offline),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: scheme.primaryContainer.withValues(alpha: 0.55),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.cloud_off,
            size: 46,
            color: scheme.onPrimaryContainer,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Internet connection unavailable',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        Text(
          'Everything you need keeps working offline.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.5, color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 22),
        _CapabilityList(items: offlineCapabilities, scheme: scheme),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _startSync,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              '[ SYNC WHEN ONLINE ]',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Simulated for the demo — nothing is sent anywhere.',
          style: TextStyle(
            fontSize: 11.5,
            color: scheme.onSurfaceVariant.withValues(alpha: 0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildReconnectedState(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      key: const ValueKey<_SyncStage>(_SyncStage.reconnected),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Icon(Icons.check_circle, size: 84, color: Color(0xFF2E9E44)),
        const SizedBox(height: 18),
        const Text(
          '✓ Connection restored',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Text(
          'Preparing to synchronize…',
          style: TextStyle(fontSize: 14, color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildSyncingState(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      key: const ValueKey<_SyncStage>(_SyncStage.syncing),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 72,
          height: 72,
          child: CircularProgressIndicator(
            strokeWidth: 6,
            color: scheme.primary,
            backgroundColor: scheme.primaryContainer,
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Synchronizing...',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Uploading pending records & referrals',
          style: TextStyle(fontSize: 13.5, color: scheme.onSurfaceVariant),
        ),
      ],
    );
  }

  Widget _buildDoneState(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Column(
      key: const ValueKey<_SyncStage>(_SyncStage.done),
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 92,
          height: 92,
          decoration: BoxDecoration(
            color: const Color(0xFF2E9E44).withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.cloud_done,
            size: 46,
            color: Color(0xFF2E9E44),
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Synchronization complete',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: scheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: scheme.outlineVariant.withValues(alpha: 0.6),
            ),
          ),
          child: Column(
            children: <Widget>[
              for (final String line in syncSummaryLines)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.check_circle,
                        size: 20,
                        color: Color(0xFF2E9E44),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          line,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: widget.onReturnToDashboard,
            icon: const Icon(Icons.dashboard_outlined, size: 18),
            label: const Text('Return to Dashboard'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        const SizedBox(height: 4),
        TextButton(
          onPressed: _simulateOfflineAgain,
          child: const Text('Simulate offline again'),
        ),
      ],
    );
  }
}

/// The three checkmark rows shown in the offline state.
class _CapabilityList extends StatelessWidget {
  const _CapabilityList({required this.items, required this.scheme});

  final List<String> items;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: scheme.outlineVariant.withValues(alpha: 0.6)),
      ),
      child: Column(
        children: <Widget>[
          for (final String item in items)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E9E44).withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 15,
                      color: Color(0xFF2E9E44),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
