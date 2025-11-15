/// Settings feature state model
class SettingsState {
  final bool isLoading;
  final String? error;
  final bool isInitialized;

  const SettingsState({
    this.isLoading = false,
    this.error,
    this.isInitialized = false,
  });

  SettingsState copyWith({
    bool? isLoading,
    String? error,
    bool? isInitialized,
    bool clearError = false,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}
