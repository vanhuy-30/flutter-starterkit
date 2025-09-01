// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:flutter_starter_kit/domain/repositories/auth_repository.dart';
// import 'package:flutter_starter_kit/presentation/auth/viewmodels/auth_view_model.dart';

// class MockAuthRepository extends Mock implements AuthRepository {}

// void main() {
//   late AuthViewModel authViewModel;
//   late MockAuthRepository mockAuthRepository;

//   setUp(() {
//     mockAuthRepository = MockAuthRepository();
//     authViewModel = AuthViewModel(mockAuthRepository);
//   });

//   group('AuthViewModel Tests', () {
//     test('should emit loading state when login is called', () async {
//       // Arrange
//       when(() => mockAuthRepository.login(any(), any()))
//           .thenAnswer((_) async => true);

//       // Act
//       await authViewModel.login('test@example.com', 'password');

//       // Assert
//       expect(authViewModel.isLoading, true);
//     });

//     test('should emit error state when login fails', () async {
//       // Arrange
//       when(() => mockAuthRepository.login(any(), any()))
//           .thenThrow(Exception('Login failed'));

//       // Act
//       await authViewModel.login('test@example.com', 'password');

//       // Assert
//       expect(authViewModel.error, isNotNull);
//       expect(authViewModel.isLoading, false);
//     });
//   });
// }
