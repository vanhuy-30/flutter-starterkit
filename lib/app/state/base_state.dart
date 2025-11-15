/// Base state class for all state management
/// Provides common properties: loading, error, and initialization status
///
/// This is the foundation for all state classes in the app.
/// Use with BaseNotifier for complex state management.
abstract class BaseState {
  /// Whether the state is currently loading
  final bool isLoading;

  /// Error message if any error occurred
  final String? error;

  /// Whether the state has been initialized
  final bool isInitialized;

  const BaseState({
    this.isLoading = false,
    this.error,
    this.isInitialized = false,
  });

  /// Create a copy of this state with updated values
  BaseState copyWith({
    bool? isLoading,
    String? error,
    bool? isInitialized,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BaseState &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.isInitialized == isInitialized;
  }

  @override
  int get hashCode =>
      isLoading.hashCode ^ error.hashCode ^ isInitialized.hashCode;
}

/// Initial state - when the notifier is first created
class InitialState extends BaseState {
  const InitialState() : super(isInitialized: false);

  @override
  InitialState copyWith({
    bool? isLoading,
    String? error,
    bool? isInitialized,
  }) {
    return const InitialState();
  }
}

/// Loading state - when data is being fetched
class LoadingState extends BaseState {
  const LoadingState() : super(isLoading: true, isInitialized: true);

  @override
  LoadingState copyWith({
    bool? isLoading,
    String? error,
    bool? isInitialized,
  }) {
    return const LoadingState();
  }
}

/// Error state - when an error occurred during data fetching
class ErrorState extends BaseState {
  const ErrorState(String error) : super(error: error, isInitialized: true);

  @override
  ErrorState copyWith({
    bool? isLoading,
    String? error,
    bool? isInitialized,
  }) {
    return ErrorState(error ?? this.error ?? 'Unknown error');
  }
}

/// Success state - when data is successfully loaded
class SuccessState<T> extends BaseState {
  /// The actual data payload
  final T data;

  const SuccessState(this.data) : super(isInitialized: true);

  @override
  SuccessState<T> copyWith({
    bool? isLoading,
    String? error,
    bool? isInitialized,
    T? data,
  }) {
    return SuccessState(data ?? this.data);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SuccessState<T> &&
        other.isLoading == isLoading &&
        other.error == error &&
        other.isInitialized == isInitialized &&
        other.data == data;
  }

  @override
  int get hashCode => super.hashCode ^ data.hashCode;
}
