import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/buttons/custom_button.dart';

void main() {
  testWidgets('CustomButton displays text correctly',
      (WidgetTester tester) async {
    // Arrange
    const buttonText = 'Test Button';
    var onPressedCalled = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: buttonText,
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    // Assert
    expect(find.text(buttonText), findsOneWidget);
    expect(onPressedCalled, false);

    // Test button press
    await tester.tap(find.byType(CustomButton));
    await tester.pump();
    expect(onPressedCalled, true);
  });

  testWidgets('CustomButton is disabled when isLoading is true',
      (WidgetTester tester) async {
    // Arrange
    const buttonText = 'Test Button';
    var onPressedCalled = false;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: buttonText,
            isLoading: true,
            onPressed: () {
              onPressedCalled = true;
            },
          ),
        ),
      ),
    );

    // Assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(onPressedCalled, false);

    // Test button press when disabled
    await tester.tap(find.byType(CustomButton));
    await tester.pump();
    expect(onPressedCalled, false);
  });
}
