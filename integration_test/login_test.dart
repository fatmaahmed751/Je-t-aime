import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import "package:je_t_aime/Models/user_model.dart";
import "package:je_t_aime/core/API/generic_request.dart";
import "package:je_t_aime/core/API/request_method.dart";

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Login API returns a valid user on success', (tester) async {
    final request = RequestApi.post(
      url: "https://jetaime.petraright.com/api/user/login",
      body: {"email": "test@example.com", "password": "password123"},
    );

    final genericRequest = GenericRequest<UserModel>(
      fromMap: (json) => UserModel.fromJson(json),
      method: request,
    );

    final user = await genericRequest.getObject();

    expect(user, isA<UserModel>());
    expect(user.user?.email, "test@example.com");
  });

  testWidgets('Login API fails with incorrect credentials', (tester) async {
    final request = RequestApi.post(
      url: "https://yourapi.com/login",
      body: {"email": "wrong@example.com", "password": "wrongpass"},
    );

    final genericRequest = GenericRequest<UserModel>(
      fromMap: (json) => UserModel.fromJson(json),
      method: request,
    );

    expect(() async => await genericRequest.getObject(), throwsException);
  });
}
