import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_starter_kit/app/state/base_notifiers.dart';

/// Ví dụ sử dụng AsyncNotifier cho Home feature
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
    // Logic khởi tạo nếu cần
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<HomeData> getData() async {
    // Giả lập API call
    await Future.delayed(const Duration(seconds: 1));

    return const HomeData(
      title: 'Chào mừng đến với Flutter Starter Kit',
      description: 'Đây là một dự án Flutter được tối ưu hóa với Riverpod',
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
    // Logic refresh nếu cần
    await Future.delayed(const Duration(milliseconds: 300));
  }

  /// Thêm item mới
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

  /// Xóa item
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
