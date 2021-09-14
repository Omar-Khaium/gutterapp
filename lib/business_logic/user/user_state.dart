part of 'user_cubit.dart';

class UserState {
  final String? token;
  final int? expiresIn;
  final User? user;

  UserState({
    this.token,
    this.expiresIn,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return {
      'token': this.token,
      'expiresIn': this.expiresIn,
      'user': this.user?.toMap(),
    };
  }

  factory UserState.fromMap(Map<String, dynamic> map) {
    return UserState(
      token: map['token'] as String?,
      expiresIn: map['expiresIn'] as int?,
      user: map['user'] == null ? null : User.fromMap(map['user']),
    );
  }
}
