import 'package:flutter_starter_kit/app/bootstrap/app_bootstrap.dart';

Future<void> main() async {
  await AppBootstrap.run(
    envFile: 'assets/env/.env.prod',
  );
}
