import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

class MockUser extends Mock implements User {
  @override
  final String uid;
  @override
  final String? email;
  @override
  final String? displayName;
  @override
  final String? photoURL;

  MockUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoURL,
  });
}

// MockUserData 클래스 정의
abstract class MockUserData {
  static final User dummyUser = MockUser(
    uid: 'dummyUserId',
    email: 'johndoe@example.com',
    displayName: 'John Doe',
    photoURL: 'https://example.com/profile.jpg',
  );
}
