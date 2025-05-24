import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/presentation/shared/widgets/custom_button.dart';

void main() {
  testWidgets('CustomButton golden test', (WidgetTester tester) async {
    // Chuẩn bị widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: 'Normal Button',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Loading Button',
                isLoading: true,
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Disabled Button',
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );

    // Chụp ảnh và so sánh với golden file
    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/custom_button_states.png'),
    );
  });

  testWidgets('CustomButton with different themes',
      (WidgetTester tester) async {
    // Test với theme sáng
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.light(),
        home: Scaffold(
          body: Center(
            child: CustomButton(
              text: 'Light Theme Button',
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/custom_button_light_theme.png'),
    );

    // Test với theme tối
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Center(
            child: CustomButton(
              text: 'Dark Theme Button',
              onPressed: () {},
            ),
          ),
        ),
      ),
    );

    await expectLater(
      find.byType(Scaffold),
      matchesGoldenFile('goldens/custom_button_dark_theme.png'),
    );
  });
}
