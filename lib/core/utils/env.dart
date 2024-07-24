import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(
  path: '.env',
  obfuscate: true,
)
abstract class Env {
  @EnviedField(varName: 'SUPABASE_URL', obfuscate: true)
  static String sbUrl = _Env.sbUrl;

  @EnviedField(varName: 'SUPABASE_ANON_KEY', obfuscate: true)
  static String sbAnonKey = _Env.sbAnonKey;
}
