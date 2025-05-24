import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';
import 'base_state.dart';

abstract class BaseProvider<T> extends StateNotifier<BaseState> {
  BaseProvider() : super(const InitialState());

  Future<void> initialize() async {
    try {
      state = const LoadingState();
      await onInitialize();
      state = SuccessState<T>(await getData());
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  Future<void> refresh() async {
    try {
      state = const LoadingState();
      await onRefresh();
      state = SuccessState<T>(await getData());
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  Future<void> onInitialize() async {}
  Future<void> onRefresh() async {}
  Future<T> getData() async {
    throw UnimplementedError('getData() must be implemented');
  }
}

abstract class BaseNotifier<T> extends StateNotifier<BaseState> {
  BaseNotifier() : super(const InitialState());

  Future<void> initialize() async {
    try {
      state = const LoadingState();
      await onInitialize();
      state = SuccessState<T>(await getData());
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  Future<void> refresh() async {
    try {
      state = const LoadingState();
      await onRefresh();
      state = SuccessState<T>(await getData());
    } catch (e) {
      state = ErrorState(e.toString());
    }
  }

  Future<void> onInitialize() async {}
  Future<void> onRefresh() async {}
  Future<T> getData() async {
    throw UnimplementedError('getData() must be implemented');
  }
}

abstract class BaseChangeNotifier extends ChangeNotifier {
  BaseState _state = const InitialState();
  BaseState get state => _state;

  void setState(BaseState newState) {
    _state = newState;
    notifyListeners();
  }

  Future<void> initialize() async {
    try {
      setState(const LoadingState());
      await onInitialize();
      setState(SuccessState<dynamic>(await getData()));
    } catch (e) {
      setState(ErrorState(e.toString()));
    }
  }

  Future<void> refresh() async {
    try {
      setState(const LoadingState());
      await onRefresh();
      setState(SuccessState<dynamic>(await getData()));
    } catch (e) {
      setState(ErrorState(e.toString()));
    }
  }

  Future<void> onInitialize() async {}
  Future<void> onRefresh() async {}
  Future<dynamic> getData() async {
    throw UnimplementedError('getData() must be implemented');
  }
} 