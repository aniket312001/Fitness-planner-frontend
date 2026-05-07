import '../../domain/entities/auth_entity.dart';
import '../../../users/data/models/user_model.dart';

class AuthResponseModel extends AuthEntity {
  AuthResponseModel({required super.user, required super.token});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }
}
