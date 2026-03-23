import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/state/base_notifiers.dart';

/// Example using AsyncNotifier for Home feature
class HomeData {
  final String title;
  final String description;
  final List<String> items;

  const HomeData({
    required this.title,
    required this.description,
    required this.items,
  });
}

class HomeNotifier extends BaseAsyncNotifier<HomeData> {
  @override
  Future<void> onInitialize() async {
    // Logic initialize if needed
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<HomeData> getData() async {
    // Mock API call
    await Future.delayed(const Duration(seconds: 1));

    return const HomeData(
      title: 'Welcome to Flutter Starter Kit',
      description: 'This is a Flutter project optimized with Riverpod',
      items: [
        'Clean Architecture',
        'Riverpod State Management',
        'Biometric Authentication',
        'Multi-language Support',
        'Theme Management',
      ],
    );
  }

  @override
  Future<void> onRefresh() async {
    // Logic refresh if needed
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Add new item
  Future<void> addItem(String item) async {
    final currentData = state.value;
    if (currentData != null) {
      final updatedItems = [...currentData.items, item];
      setData(HomeData(
        title: currentData.title,
        description: currentData.description,
        items: updatedItems,
      ));
    }
  }

  /// Remove item
  Future<void> removeItem(int index) async {
    final currentData = state.value;
    if (currentData != null && index < currentData.items.length) {
      final updatedItems = List<String>.from(currentData.items);
      updatedItems.removeAt(index);
      setData(HomeData(
        title: currentData.title,
        description: currentData.description,
        items: updatedItems,
      ));
    }
  }
}

// Provider cho HomeNotifier
final homeNotifierProvider = AsyncNotifierProvider<HomeNotifier, HomeData>(() {
  return HomeNotifier();
});
