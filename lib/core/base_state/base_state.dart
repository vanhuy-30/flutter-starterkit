abstract class BaseState {
  final bool isLoading;
  final String? error;
  final bool isInitialized;

  const BaseState({
    this.isLoading = false,
    this.error,
    this.isInitialized = false,
  });

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
  int get hashCode => isLoading.hashCode ^ error.hashCode ^ isInitialized.hashCode;
}

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

class SuccessState<T> extends BaseState {
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