import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'offline_screen.dart';
import 'patient_screen.dart';
import 'referral_screen.dart';
import 'screening_screen.dart';

/// Root shell: hosts the five workflow screens and the bottom navigation bar.
///
/// Tab order is the workflow order:
/// Dashboard → Patient → AI Screening → Referral → Offline Mode.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  void _goTo(int index) => setState(() => _index = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: <Widget>[
          DashboardScreen(onPatientTap: () => _goTo(1)),
          PatientScreen(onContinue: () => _goTo(2)),
          ScreeningScreen(onContinue: () => _goTo(3)),
          ReferralScreen(onContinue: () => _goTo(4)),
          OfflineScreen(onReturnToDashboard: () => _goTo(0)),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _goTo,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Patient',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_heart_outlined),
            selectedIcon: Icon(Icons.monitor_heart),
            label: 'Screening',
          ),
          NavigationDestination(
            icon: Icon(Icons.forward_to_inbox_outlined),
            selectedIcon: Icon(Icons.forward_to_inbox),
            label: 'Referral',
          ),
          NavigationDestination(
            icon: Icon(Icons.cloud_off_outlined),
            selectedIcon: Icon(Icons.cloud_off),
            label: 'Offline',
          ),
        ],
      ),
    );
  }
}
