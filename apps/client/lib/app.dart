import 'package:flutter/material.dart';

import 'theme/app_theme.dart';

class FermentumApp extends StatelessWidget {
  const FermentumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fermentum',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: buildFermentumTheme(),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fermentum', style: theme.textTheme.displaySmall),
              const SizedBox(height: 8),
              Text(
                'Mission-command fermentation for recipe design, brew-day execution, and process control.',
                style: theme.textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: const [
                  _MetricTile(label: 'Mode', value: 'Apprentice'),
                  _MetricTile(label: 'Target', value: 'Beer + Cider MVP'),
                  _MetricTile(label: 'Storage', value: 'Local-first'),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Row(
                  children: const [
                    Expanded(
                      flex: 2,
                      child: _CommandPanel(
                        title: 'Recipe Console',
                        body:
                            'Add fermentables, hops, yeast, equipment, and target water profiles.',
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: _CommandPanel(
                        title: 'Telemetry',
                        body:
                            'Fermentation graphs, brew-day timers, and AI-assisted diagnostics will surface here.',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131D2E),
        border: Border.all(color: const Color(0xFF2B4263)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: theme.textTheme.labelMedium),
          const SizedBox(height: 8),
          Text(value, style: theme.textTheme.headlineSmall),
        ],
      ),
    );
  }
}

class _CommandPanel extends StatelessWidget {
  const _CommandPanel({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF131D2E),
        border: Border.all(color: const Color(0xFF22324A)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.28),
            blurRadius: 30,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 3,
            width: 96,
            color: const Color(0xFF37D7FF),
          ),
          const SizedBox(height: 16),
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: 12),
          Text(body, style: theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}

