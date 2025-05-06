import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animation Container
            SizedBox(
              height: 300,
              width: 300,
              child: Lottie.asset(
                'assets/animations/not_found_animation.json',
                repeat: true,
                animate: true,
              ),
            ),
            const SizedBox(height: 32),
            // Error Message
            const Text(
              'Oops! Trang không tồn tại',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Có vẻ như trang bạn đang tìm kiếm không tồn tại hoặc đã bị di chuyển.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Back to Home Button
            ElevatedButton.icon(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: const Icon(Icons.home),
              label: const Text(
                'Trở về trang chủ',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),
            // Back Button
            TextButton.icon(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Quay lại trang trước'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}