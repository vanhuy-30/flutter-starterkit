import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/features/settings/presentation/widgets/settings_card.dart';

void main() {
  group('SettingsCard Widget Test', () {
    testWidgets('renders title/subtitle and triggers onTap when enabled',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsCard(
              title: 'Theme',
              subtitle: 'Light mode',
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      expect(find.text('Theme'), findsOneWidget);
      expect(find.text('Light mode'), findsOneWidget);

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, isTrue);
    });

    testWidgets('does not trigger onTap when disabled',
        (WidgetTester tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SettingsCard(
              title: 'Language',
              subtitle: 'English',
              enabled: false,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pump();

      expect(tapped, isFalse);
    });
  });
}
