// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnboardingState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  Set<String> get selectedInterests => throw _privateConstructorUsedError;
  Set<String> get selectedGoals => throw _privateConstructorUsedError;
  bool get isCompleting => throw _privateConstructorUsedError;
  OnboardingError? get error => throw _privateConstructorUsedError;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OnboardingStateCopyWith<OnboardingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) then) =
      _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isCompleted,
      Set<String> selectedInterests,
      Set<String> selectedGoals,
      bool isCompleting,
      OnboardingError? error});
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isCompleted = null,
    Object? selectedInterests = null,
    Object? selectedGoals = null,
    Object? isCompleting = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedInterests: null == selectedInterests
          ? _value.selectedInterests
          : selectedInterests // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      selectedGoals: null == selectedGoals
          ? _value.selectedGoals
          : selectedGoals // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      isCompleting: null == isCompleting
          ? _value.isCompleting
          : isCompleting // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as OnboardingError?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnboardingStateImplCopyWith<$Res>
    implements $OnboardingStateCopyWith<$Res> {
  factory _$$OnboardingStateImplCopyWith(_$OnboardingStateImpl value,
          $Res Function(_$OnboardingStateImpl) then) =
      __$$OnboardingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isCompleted,
      Set<String> selectedInterests,
      Set<String> selectedGoals,
      bool isCompleting,
      OnboardingError? error});
}

/// @nodoc
class __$$OnboardingStateImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingStateImpl>
    implements _$$OnboardingStateImplCopyWith<$Res> {
  __$$OnboardingStateImplCopyWithImpl(
      _$OnboardingStateImpl _value, $Res Function(_$OnboardingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isCompleted = null,
    Object? selectedInterests = null,
    Object? selectedGoals = null,
    Object? isCompleting = null,
    Object? error = freezed,
  }) {
    return _then(_$OnboardingStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedInterests: null == selectedInterests
          ? _value._selectedInterests
          : selectedInterests // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      selectedGoals: null == selectedGoals
          ? _value._selectedGoals
          : selectedGoals // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      isCompleting: null == isCompleting
          ? _value.isCompleting
          : isCompleting // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as OnboardingError?,
    ));
  }
}

/// @nodoc

class _$OnboardingStateImpl implements _OnboardingState {
  const _$OnboardingStateImpl(
      {this.isLoading = false,
      this.isCompleted = false,
      final Set<String> selectedInterests = const <String>{},
      final Set<String> selectedGoals = const <String>{},
      this.isCompleting = false,
      this.error})
      : _selectedInterests = selectedInterests,
        _selectedGoals = selectedGoals;

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isCompleted;
  final Set<String> _selectedInterests;
  @override
  @JsonKey()
  Set<String> get selectedInterests {
    if (_selectedInterests is EqualUnmodifiableSetView)
      return _selectedInterests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedInterests);
  }

  final Set<String> _selectedGoals;
  @override
  @JsonKey()
  Set<String> get selectedGoals {
    if (_selectedGoals is EqualUnmodifiableSetView) return _selectedGoals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedGoals);
  }

  @override
  @JsonKey()
  final bool isCompleting;
  @override
  final OnboardingError? error;

  @override
  String toString() {
    return 'OnboardingState(isLoading: $isLoading, isCompleted: $isCompleted, selectedInterests: $selectedInterests, selectedGoals: $selectedGoals, isCompleting: $isCompleting, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            const DeepCollectionEquality()
                .equals(other._selectedInterests, _selectedInterests) &&
            const DeepCollectionEquality()
                .equals(other._selectedGoals, _selectedGoals) &&
            (identical(other.isCompleting, isCompleting) ||
                other.isCompleting == isCompleting) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      isCompleted,
      const DeepCollectionEquality().hash(_selectedInterests),
      const DeepCollectionEquality().hash(_selectedGoals),
      isCompleting,
      error);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      __$$OnboardingStateImplCopyWithImpl<_$OnboardingStateImpl>(
          this, _$identity);
}

abstract class _OnboardingState implements OnboardingState {
  const factory _OnboardingState(
      {final bool isLoading,
      final bool isCompleted,
      final Set<String> selectedInterests,
      final Set<String> selectedGoals,
      final bool isCompleting,
      final OnboardingError? error}) = _$OnboardingStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isCompleted;
  @override
  Set<String> get selectedInterests;
  @override
  Set<String> get selectedGoals;
  @override
  bool get isCompleting;
  @override
  OnboardingError? get error;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingStateImplCopyWith<_$OnboardingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
