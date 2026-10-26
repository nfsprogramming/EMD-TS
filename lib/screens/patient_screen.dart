import 'package:flutter/material.dart';

import '../models/demo_data.dart';
import '../widgets/clinical_scaffold.dart';

/// Screen 2 — Patient.
///
/// Patient details plus the five vitals rows. Clinical screen: pinned
/// SIMULATED / DEMONSTRATION DATA banner.
class PatientScreen extends StatelessWidget {
  const PatientScreen({super.key, required this.onContinue});

  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    final DemoPatient patient = demoPatient;

    return ClinicalScreen(
      title: 'PATIENT',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          const SectionLabel('PATIENT DETAILS'),
          Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: <Widget>[
                  _DetailRow(label: 'Name', value: patient.name),
                  _DetailRow(label: 'Age', value: patient.age),
                  _DetailRow(label: 'Sex', value: patient.sex, last: true),
                ],
              ),
            ),
          ),
          const SectionLabel('VITALS'),
          Card(
            child: Column(
              children: <Widget>[
                for (int i = 0; i < demoVitals.length; i++)
                  _VitalRow(
                    reading: demoVitals[i],
                    scheme: scheme,
                    last: i == demoVitals.length - 1,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ForwardButton(
            label: 'Continue to AI Screening',
            onPressed: onContinue,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.last = false,
  });

  final String label;
  final String value;
  final bool last;

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _VitalRow extends StatelessWidget {
  const _VitalRow({
    required this.reading,
    required this.scheme,
    required this.last,
  });

  final VitalReading reading;
  final ColorScheme scheme;
  final bool last;

  IconData get _icon {
    switch (reading.label) {
      case 'ECG':
        return Icons.monitor_heart_outlined;
      case 'SpO₂':
        return Icons.water_drop_outlined;
      case 'Heart Rate':
        return Icons.favorite_outline;
      case 'Temperature':
        return Icons.device_thermostat_outlined;
      case 'Lung Sounds':
        return Icons.graphic_eq;
      default:
        return Icons.monitor_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool captured = reading.isCapturedWaveform;
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
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: scheme.primaryContainer.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(_icon, size: 18, color: scheme.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              reading.label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
          ),
          if (captured)
            Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Icon(
                Icons.check_circle,
                size: 18,
                color: const Color(0xFF2E9E44),
              ),
            ),
          Text(
            reading.value,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: captured ? const Color(0xFF2E9E44) : scheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
