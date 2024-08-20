import 'package:mockito/annotations.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing_scenarios/models/auth_service.dart';
import 'package:unit_testing_scenarios/models/auth_api_client.dart';
import 'package:unit_testing_scenarios/models/secure_storage.dart';
import 'auth_service_test.mocks.dart';

@GenerateMocks([AuthApiClient, SecureStorage])
void main() {
  late AuthService authService;
  late MockAuthApiClient mockApiClient;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockApiClient = MockAuthApiClient();
    mockSecureStorage = MockSecureStorage();
    authService = AuthService(apiClient: mockApiClient, secureStorage: mockSecureStorage);
  });

  group('AuthService', () {
    test('successfully logs in and saves the token', () async {
      when(mockApiClient.login('test', 'password')).thenAnswer((_) async => 'dummy_token');
      when(mockSecureStorage.saveToken(any)).thenAnswer((_) async {});

      await authService.login('test', 'password');

      verify(mockApiClient.login('test', 'password')).called(1);
      verify(mockSecureStorage.saveToken('dummy_token')).called(1);
    });

    test('throws exception on invalid credentials', () async {
      when(mockApiClient.login('wrong_user', 'wrong_password')).thenThrow(Exception('Invalid credentials'));

      expect(
            () async => await authService.login('wrong_user', 'wrong_password'),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Invalid credentials'))),
      );
    });

    test('returns true if the user is authenticated', () async {
      when(mockSecureStorage.getToken()).thenAnswer((_) async => 'dummy_token');

      final isAuthenticated = await authService.isAuthenticated();

      expect(isAuthenticated, true);
      verify(mockSecureStorage.getToken()).called(1);
    });

    test('returns false if the user is not authenticated', () async {
      when(mockSecureStorage.getToken()).thenAnswer((_) async => null);

      final isAuthenticated = await authService.isAuthenticated();

      expect(isAuthenticated, false);
      verify(mockSecureStorage.getToken()).called(1);
    });

    test('successfully logs out and deletes the token', () async {
      when(mockSecureStorage.getToken()).thenAnswer((_) async => 'dummy_token');
      when(mockApiClient.logout('dummy_token')).thenAnswer((_) async {});
      when(mockSecureStorage.deleteToken()).thenAnswer((_) async {});

      await authService.logout();

      verify(mockSecureStorage.getToken()).called(1);
      verify(mockApiClient.logout('dummy_token')).called(1);
      verify(mockSecureStorage.deleteToken()).called(1);
    });

    test('throws exception on logout if no token is found', () async {
      when(mockSecureStorage.getToken()).thenAnswer((_) async => null);

      expect(
            () async => await authService.logout(),
        throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('No token found'))),
      );
    });
  });
}
