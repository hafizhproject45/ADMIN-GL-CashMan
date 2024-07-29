import 'package:supabase/supabase.dart' as sb;

import '../../../../core/errors/failures.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../domain/entities/auth/login_request_entity.dart';
import '../../../domain/entities/auth/update_request_entity.dart';
import '../../../domain/entities/auth/user_entity.dart';
import '../../../domain/entities/auth/delete_request_entity.dart';
import '../../models/user/user_model.dart';

abstract class AuthDataSource {
  sb.Session? get getCurrentUserSession;

  Future<String> getUserIDAuth();
  Future<int> getUserID();
  Future<bool> checkLogin();
  Future<void> login(LoginRequestEntity request);
  Future<void> logout();

  Future<UserEntity> getSingleUser(int userId);
  Future<List<UserEntity>> getAllUser();
  Future<void> updateUser(UpdateRequestEntity request);
  Future<void> deleteUser(DeleteRequestEntity request);
}

class AuthDataSourceImpl extends AuthDataSource {
  final sb.SupabaseClient supabase;

  AuthDataSourceImpl({
    required this.supabase,
  });

  @override
  sb.Session? get getCurrentUserSession => supabase.auth.currentSession;

  @override
  Future<String> getUserIDAuth() async {
    try {
      return supabase.auth.currentUser!.id;
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<int> getUserID() async {
    try {
      final authId = supabase.auth.currentUser?.id;

      final response = await supabase
          .from('users')
          .select('id')
          .eq('auth_id', authId!)
          .single();

      final userId = response['id'] as int;
      return userId;
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<bool> checkLogin() async {
    try {
      if (getCurrentUserSession != null) {
        return true;
      }
      return false;
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> login(LoginRequestEntity request) async {
    try {
      final res = await supabase.auth.signInWithPassword(
        email: request.email,
        password: request.password,
      );
      await supabase.auth.setSession(res.session!.refreshToken!);
    } catch (e) {
      if (e is sb.AuthException) {
        throw sb.AuthException(e.message);
      }
      throw UnknownException();
    }
  }

  @override
  Future<void> logout() async {
    try {
      await supabase.auth.signOut();
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<UserEntity> getSingleUser(int userId) async {
    try {
      final res =
          await supabase.from('users').select().eq('id', userId).single();

      return UserModel.fromJson(res);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<List<UserEntity>> getAllUser() async {
    try {
      final res = await supabase.from('users').select().neq('id', 0);

      return res.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> updateUser(UpdateRequestEntity request) async {
    try {
      await supabase
          .from('users')
          .update(request.toJson())
          .eq('id', request.id!);
    } catch (e) {
      return _handleException(e);
    }
  }

  @override
  Future<void> deleteUser(DeleteRequestEntity request) async {
    try {
      await supabase.from('users').delete().eq('id', request.userId);

      await supabase.auth.admin.deleteUser(request.authId);
    } catch (e) {
      return _handleException(e);
    }
  }

  _handleException(Object e) {
    if (e is ServerException) {
      throw ServerFailure(message: e.message);
    } else {
      throw const UnknownFailure(message: FAILURE_UNKNOWN);
    }
  }
}
