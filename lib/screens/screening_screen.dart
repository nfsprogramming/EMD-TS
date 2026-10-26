import 'package:flutter/material.dart';

import '../models/demo_data.dart';
import '../widgets/clinical_scaffold.dart';

/// Screen 3 — AI Screening result.
///
/// Review-required warning, the three triggers, and the verbatim disclaimer:
/// "AI does not provide a diagnosis." / "Human review required."
/// Clinical screen: pinned SIMULATED / DEMONSTRATION DATA banner.
class ScreeningScreen extends StatelessWidget {
  const ScreeningScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;

    return ClinicalScreen(
      title: 'SCREENING RESULT',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: scheme.errorContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.warning_amber_rounded,
                  size: 30,
                  color: scheme.onErrorContainer,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    '⚠ REVIEW REQUIRED',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: scheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SectionLabel('POSSIBLE TRIGGERS'),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: <Widget>[
                  for (final String trigger in screeningTriggers)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '•',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: scheme.error,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              trigger,
                              style: const TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          const SectionLabel('DISCLAIMER'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: scheme.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.info_outline,
                      size: 18,
                      color: scheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'AI does not provide a diagnosis.',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Icon(Icons.rule, size: 18, color: scheme.primary),
                    const SizedBox(width: 8),
                    const Text(
                      'Human review required.',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ForwardButton(label: 'Continue to Referral', onPressed: onContinue),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
