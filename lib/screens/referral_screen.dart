import 'package:flutter/material.dart';

import '../widgets/clinical_scaffold.dart';

/// Screen 4 — Referral.
///
/// Referral summary: HIGH priority, reason, assignment to the Remote Medical
/// Officer, and "Waiting for review" status. Clinical screen: pinned
/// SIMULATED / DEMONSTRATION DATA banner.
class ReferralScreen extends StatelessWidget {
  const ReferralScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return ClinicalScreen(
      title: 'REFERRAL',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.errorContainer.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.assignment_late_outlined,
                  size: 26,
                  color: scheme.onErrorContainer,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Referral created',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: scheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SectionLabel('REFERRAL DETAILS'),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: <Widget>[
                  _ReferralRow(
                    label: 'Priority',
                    value: 'HIGH',
                    valueWidget: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: scheme.error,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: const Text(
                        'HIGH',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  _ReferralRow(
                    label: 'Reason',
                    value: 'Multiple screening indicators',
                  ),
                  _ReferralRow(
                    label: 'Assigned',
                    value: 'Remote Medical Officer',
                    valueIcon: Icons.local_hospital_outlined,
                  ),
                  _ReferralRow(
                    label: 'Status',
                    value: 'Waiting for review',
                    valueWidget: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: 9,
                          height: 9,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFFF2A93B),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Waiting for review',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    last: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ForwardButton(
            label: 'Continue to Offline Mode',
            onPressed: onContinue,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ReferralRow extends StatelessWidget {
  const _ReferralRow({
    required this.label,
    required this.value,
    this.valueWidget,
    this.valueIcon,
    this.last = false,
  });

  final String label;
  final String value;
  final Widget? valueWidget;
  final IconData? valueIcon;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      decoration: BoxDecoration(
        border: last
            ? null
            : Border(
                bottom: BorderSide(
                  color: scheme.outlineVariant.withValues(alpha: 0.5),
                ),
              ),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          const Spacer(),
          if (valueIcon != null) ...<Widget>[
            Icon(valueIcon, size: 16, color: scheme.primary),
            const SizedBox(width: 6),
          ],
          if (valueWidget != null)
            valueWidget!
          else
            Flexible(
              child: Text(
                value,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
