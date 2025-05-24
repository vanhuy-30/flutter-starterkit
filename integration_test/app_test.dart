import 'package:flutter_starter_kit/presentation/components/atoms/text_fields/app_text_field.dart';
import 'package:flutter_starter_kit/presentation/components/atoms/text_fields/password_text_field.dart';
import 'package:flutter_starter_kit/presentation/pages/login_page.dart';
import 'package:flutter_starter_kit/presentation/pages/splash_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_starter_kit/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end test', () {
    testWidgets('App should start and show splash screen',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify splash screen is shown
      expect(find.byType(SplashPage), findsOneWidget);
    });

    testWidgets('Should navigate to login screen after splash',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for splash screen to finish
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Verify login screen is shown
      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('Should show error on invalid login',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Wait for splash screen to finish
      await Future.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();

      // Enter invalid credentials
      await tester.enterText(find.byType(AppTextField), 'invalid@email.com');
      await tester.enterText(find.byType(PasswordTextField), 'wrongpassword');
      // await tester.tap(find.byType(LoginButton));
      await tester.pumpAndSettle();

      // Verify error message is shown
      expect(find.text('Invalid email or password'), findsOneWidget);
    });
  });
}
