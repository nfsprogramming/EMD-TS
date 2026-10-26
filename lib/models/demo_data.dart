/// Demo data for the EMD-TS screening demonstration.
///
/// Every value in this file is SIMULATED. The app performs no real medical
/// measurement and the AI screening is mocked — it never infers anything
/// from real patient data.
library;

/// A patient record used in the demo workflow.
class DemoPatient {
  const DemoPatient({required this.name, required this.age, required this.sex});

  final String name;
  final String age;
  final String sex;
}

/// The demo patient shown on the Dashboard and Patient screens.
const DemoPatient demoPatient = DemoPatient(
  name: 'Anita Sharma',
  age: '54',
  sex: 'Female',
);

/// One vitals row on the Patient screen.
class VitalReading {
  const VitalReading({
    required this.label,
    required this.value,
    this.isCapturedWaveform = false,
  });

  final String label;

  /// Display value, e.g. "94%" or "108 BPM".
  final String value;

  /// True when the reading is a captured signal (ECG / lung sounds) rather
  /// than a numeric measurement.
  final bool isCapturedWaveform;
}

/// The vitals list on the Patient screen (verbatim copy from the spec).
const List<VitalReading> demoVitals = <VitalReading>[
  VitalReading(label: 'ECG', value: '✓ Captured', isCapturedWaveform: true),
  VitalReading(label: 'SpO₂', value: '94%'),
  VitalReading(label: 'Heart Rate', value: '108 BPM'),
  VitalReading(label: 'Temperature', value: '37.4°C'),
  VitalReading(
    label: 'Lung Sounds',
    value: '✓ Captured',
    isCapturedWaveform: true,
  ),
];

/// Trigger bullets shown on the AI Screening screen (verbatim copy).
const List<String> screeningTriggers = <String>[
  'Elevated heart rate',
  'SpO₂ below configured threshold',
  'ECG requires verification',
];

/// Offline capabilities shown on the Offline Mode screen (verbatim copy).
const List<String> offlineCapabilities = <String>[
  'Patient data saved locally',
  'Screening available',
  'Records accessible',
];

/// Sync summary lines shown after reconnecting (verbatim copy).
const List<String> syncSummaryLines = <String>[
  '24 records synchronized',
  '3 referrals uploaded',
  '7 follow-ups updated',
];
