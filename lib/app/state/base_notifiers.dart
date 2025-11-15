import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'base_state.dart';

/// Base class for StateNotifier with BaseState
/// Use for complex state management with custom state classes
abstract class BaseNotifier<T> extends StateNotifier<BaseState> {
  BaseNotifier() : super(const InitialState());

  /// Initialize data - call this to start loading data
  /// Automatically handles loading, success, and error states
  Future<void> initialize() async {
    try {
      state = const LoadingState();
      await onInitialize();
      state = SuccessState<T>(await getData());
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  /// Refresh data - call this to reload data
  /// Automatically handles loading, success, and error states
  Future<void> refresh() async {
    try {
      state = const LoadingState();
      await onRefresh();
      state = SuccessState<T>(await getData());
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  /// Override this method to add custom initialization logic
  /// Called before getData() in initialize()
  Future<void> onInitialize() async {}

  /// Override this method to add custom refresh logic
  /// Called before getData() in refresh()
  Future<void> onRefresh() async {}

  /// Override this method to implement data fetching logic
  /// This is the main method you need to implement
  Future<T> getData() async {
    throw UnimplementedError('getData() must be implemented');
  }

  /// Manually set loading state
  void setLoading() {
    state = const LoadingState();
  }

  /// Manually set error state
  void setError(String error) {
    state = ErrorState(error);
  }

  /// Manually set success state with data
  void setSuccess(T data) {
    state = SuccessState<T>(data);
  }
}

/// Base class for AsyncNotifier - more modern approach
/// Use for simple async operations with built-in AsyncValue handling
abstract class BaseAsyncNotifier<T> extends AsyncNotifier<T> {
  @override
  Future<T> build() async {
    try {
      await onInitialize();
      return await getData();
    } catch (e) {
      rethrow;
    }
  }

  /// Refresh data - call this to reload data
  /// Automatically handles AsyncValue.loading, AsyncValue.data, and AsyncValue.error
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      await onRefresh();
      state = AsyncValue.data(await getData());
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// Override this method to add custom initialization logic
  /// Called before getData() in build()
  Future<void> onInitialize() async {}

  /// Override this method to add custom refresh logic
  /// Called before getData() in refresh()
  Future<void> onRefresh() async {}

  /// Override this method to implement data fetching logic
  /// This is the main method you need to implement
  Future<T> getData() async {
    throw UnimplementedError('getData() must be implemented');
  }

  /// Manually set loading state
  void setLoading() {
    state = const AsyncValue.loading();
  }

  /// Manually set error state
  void setError(Object error, [StackTrace? stackTrace]) {
    state = AsyncValue.error(error, stackTrace ?? StackTrace.current);
  }

  /// Manually set success state with data
  void setData(T data) {
    state = AsyncValue.data(data);
  }
}

/// Base class for FutureProvider with error handling
/// Use for simple future-based data fetching
class BaseFutureProvider<T> {
  static FutureProvider<T> create<T>(
    Future<T> Function() future, {
    String? name,
  }) {
    return FutureProvider<T>((ref) async {
      return future();
    });
  }
}

/// Base class for StreamProvider with error handling
/// Use for stream-based data listening
class BaseStreamProvider<T> {
  static StreamProvider<T> create<T>(
    Stream<T> Function() stream, {
    String? name,
  }) {
    return StreamProvider<T>((ref) => stream());
  }
}
