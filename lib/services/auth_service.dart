import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ── Data model ────────────────────────────────────────────────────────────────

class AuthUser {
  final String id;
  final String name;
  final String email;
  final String? image;
  final bool isPro;

  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    required this.isPro,
  });

  factory AuthUser.fromJson(Map<String, dynamic> j) => AuthUser(
        id: j['id'] as String,
        name: j['name'] as String,
        email: j['email'] as String,
        image: j['image'] as String?,
        isPro: j['isPro'] as bool? ?? false,
      );
}

class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
  @override
  String toString() => message;
}

// ── Service ───────────────────────────────────────────────────────────────────

class AuthService {
  // Worker URL — mobile calls the API directly (not through the Pages proxy).
  static const _base = 'https://cv-builder-api.fiorenzo9845.workers.dev';

  AuthService._();
  static final AuthService instance = AuthService._();

  late final Dio _dio;
  late final PersistCookieJar _jar;
  bool _ready = false;

  // Web OAuth client ID — used as serverClientId on Android so the SDK
  // returns an idToken with aud = web client ID (which the backend verifies).
  // On iOS the GIDClientID in Info.plist is used instead; this is ignored.
  static const _webClientId =
      '157089452335-m7v3cjrj72c0d91gdk40e6eut25ltfom.apps.googleusercontent.com';

  final _googleSignIn = GoogleSignIn(
    serverClientId: _webClientId,
    scopes: ['email', 'profile'],
  );

  /// Must be called once at app start (after path_provider is available).
  Future<void> init() async {
    if (_ready) return;
    final dir = await getApplicationDocumentsDirectory();
    _jar = PersistCookieJar(
      ignoreExpires: false,
      storage: FileStorage('${dir.path}/.auth_cookies/'),
    );
    _dio = Dio(BaseOptions(
      baseUrl: _base,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ));
    _dio.interceptors.add(CookieManager(_jar));
    _ready = true;
  }

  // ── Public API ──────────────────────────────────────────────────────────────

  Future<AuthUser> signInEmail(String email, String password) async {
    final res = await _post('/api/auth/sign-in/email', {
      'email': email.trim(),
      'password': password,
    });
    final user = (res['user'] as Map?)?.cast<String, dynamic>();
    if (user == null) throw const AuthException('Login fallito');
    return AuthUser.fromJson(user);
  }

  Future<AuthUser> signUpEmail(String name, String email, String password) async {
    final res = await _post('/api/auth/sign-up/email', {
      'name': name.trim(),
      'email': email.trim(),
      'password': password,
    });
    final user = (res['user'] as Map?)?.cast<String, dynamic>();
    if (user == null) throw const AuthException('Registrazione fallita');
    return AuthUser.fromJson(user);
  }

  Future<AuthUser> signInGoogle() async {
    // Sign in with Google — shows the native account picker.
    final account = await _googleSignIn.signIn();
    if (account == null) throw const AuthException('Login annullato');

    final auth = await account.authentication;
    final idToken = auth.idToken;
    if (idToken == null) throw const AuthException('Token Google non disponibile');

    // Send the ID token to Better Auth's social sign-in endpoint.
    final res = await _post('/api/auth/sign-in/social', {
      'provider': 'google',
      'idToken': {'token': idToken},
    });
    final user = (res['user'] as Map?)?.cast<String, dynamic>();
    if (user == null) throw const AuthException('Login con Google fallito');
    return AuthUser.fromJson(user);
  }

  Future<void> signOutGoogle() async {
    await _googleSignIn.signOut();
  }

  Future<AuthUser?> getSession() async {
    try {
      final res = await _dio.get('/api/auth/get-session');
      if (res.data == null) return null;
      final user = (res.data['user'] as Map?)?.cast<String, dynamic>();
      if (user == null) return null;
      return AuthUser.fromJson(user);
    } catch (_) {
      return null;
    }
  }

  Future<bool> getProStatus() async {
    try {
      final res = await _dio.get('/api/pro/status');
      return res.data['isPro'] as bool? ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Grants Pro to the currently authenticated user.
  /// Returns true on success, false on failure.
  Future<bool> purchasePro() async {
    try {
      final res = await _dio.post('/api/pro/purchase');
      return res.data['isPro'] as bool? ?? false;
    } on DioException catch (e) {
      final data = e.response?.data;
      final msg = (data is Map ? data['message'] ?? data['error'] : null)
          ?? e.message
          ?? 'Errore durante l\'acquisto';
      throw AuthException(msg.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _dio.post('/api/auth/sign-out');
    } catch (_) {}
    await _jar.deleteAll();
  }

  // ── Private helpers ─────────────────────────────────────────────────────────

  Future<Map<String, dynamic>> _post(String path, Map<String, dynamic> body) async {
    try {
      final res = await _dio.post(path, data: body);
      return (res.data as Map).cast<String, dynamic>();
    } on DioException catch (e) {
      final data = e.response?.data;
      final msg = (data is Map ? data['message'] ?? data['error'] : null)
          ?? e.message
          ?? 'Errore di rete';
      throw AuthException(msg.toString());
    }
  }
}
