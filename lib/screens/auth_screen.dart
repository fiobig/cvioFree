import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../state/auth_provider.dart';
import '../services/auth_service.dart';
import '../i18n/app_localizations.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = ref.watch(appLocalizationsProvider);
    final auth = ref.watch(authProvider);
    final isLoading = auth is AsyncLoading;
    final error = auth.asError?.error.toString();

    // Close screen automatically on successful login
    ref.listen<AsyncValue<AuthUser?>>(authProvider, (_, next) {
      if (next.valueOrNull != null && mounted) Navigator.pop(context);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('authLogin')),
        bottom: TabBar(
          controller: _tabs,
          tabs: [
            Tab(text: l.t('authLogin')),
            Tab(text: l.t('authRegister')),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _LoginTab(
            emailCtrl: _emailCtrl,
            passCtrl: _passCtrl,
            obscure: _obscure,
            onToggleObscure: () => setState(() => _obscure = !_obscure),
            isLoading: isLoading,
            error: error,
            onSubmit: () => ref.read(authProvider.notifier).signInEmail(
                  _emailCtrl.text,
                  _passCtrl.text,
                ),
            onGoogleSignIn: () => ref.read(authProvider.notifier).signInGoogle(),
            l: l,
          ),
          _RegisterTab(
            nameCtrl: _nameCtrl,
            emailCtrl: _emailCtrl,
            passCtrl: _passCtrl,
            obscure: _obscure,
            onToggleObscure: () => setState(() => _obscure = !_obscure),
            isLoading: isLoading,
            error: error,
            onSubmit: () => ref.read(authProvider.notifier).signUpEmail(
                  _nameCtrl.text,
                  _emailCtrl.text,
                  _passCtrl.text,
                ),
            onGoogleSignIn: () => ref.read(authProvider.notifier).signInGoogle(),
            l: l,
          ),
        ],
      ),
    );
  }
}

// ── Login tab ─────────────────────────────────────────────────────────────────

class _LoginTab extends StatelessWidget {
  const _LoginTab({
    required this.emailCtrl,
    required this.passCtrl,
    required this.obscure,
    required this.onToggleObscure,
    required this.isLoading,
    required this.error,
    required this.onSubmit,
    required this.onGoogleSignIn,
    required this.l,
  });

  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final bool isLoading;
  final String? error;
  final VoidCallback onSubmit;
  final VoidCallback onGoogleSignIn;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return _AuthForm(
      children: [
        _EmailField(ctrl: emailCtrl, l: l),
        const SizedBox(height: 12),
        _PasswordField(
          ctrl: passCtrl,
          obscure: obscure,
          onToggle: onToggleObscure,
          l: l,
        ),
        const SizedBox(height: 8),
        if (error != null) _ErrorBox(error!),
        const SizedBox(height: 16),
        _SubmitButton(
          label: l.t('authLoginCta'),
          isLoading: isLoading,
          onPressed: onSubmit,
        ),
        const SizedBox(height: 12),
        _GoogleSignInButton(isLoading: isLoading, onSignIn: onGoogleSignIn),
      ],
    );
  }
}

// ── Register tab ──────────────────────────────────────────────────────────────

class _RegisterTab extends StatelessWidget {
  const _RegisterTab({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passCtrl,
    required this.obscure,
    required this.onToggleObscure,
    required this.isLoading,
    required this.error,
    required this.onSubmit,
    required this.onGoogleSignIn,
    required this.l,
  });

  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passCtrl;
  final bool obscure;
  final VoidCallback onToggleObscure;
  final bool isLoading;
  final String? error;
  final VoidCallback onSubmit;
  final VoidCallback onGoogleSignIn;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return _AuthForm(
      children: [
        TextFormField(
          controller: nameCtrl,
          decoration: InputDecoration(
            labelText: l.t('authName'),
            prefixIcon: const Icon(Icons.person_outline),
            border: const OutlineInputBorder(),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 12),
        _EmailField(ctrl: emailCtrl, l: l),
        const SizedBox(height: 12),
        _PasswordField(
          ctrl: passCtrl,
          obscure: obscure,
          onToggle: onToggleObscure,
          l: l,
        ),
        const SizedBox(height: 8),
        if (error != null) _ErrorBox(error!),
        const SizedBox(height: 16),
        _SubmitButton(
          label: l.t('authRegisterCta'),
          isLoading: isLoading,
          onPressed: onSubmit,
        ),
        const SizedBox(height: 12),
        _GoogleSignInButton(isLoading: isLoading, onSignIn: onGoogleSignIn),
      ],
    );
  }
}

// ── Google Sign-In button ─────────────────────────────────────────────────────

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({required this.isLoading, required this.onSignIn});
  final bool isLoading;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: isLoading ? null : onSignIn,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Google "G" logo using coloured text as a lightweight stand-in.
          const Text(
            'G',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4285F4),
            ),
          ),
          const SizedBox(width: 10),
          const Text(
            'Continua con Google',
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// ── Shared form widgets ───────────────────────────────────────────────────────

class _AuthForm extends StatelessWidget {
  const _AuthForm({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          ...children,
        ],
      ),
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField({required this.ctrl, required this.l});
  final TextEditingController ctrl;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      decoration: InputDecoration(
        labelText: l.t('authEmail'),
        prefixIcon: const Icon(Icons.mail_outline),
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
    );
  }
}

class _PasswordField extends StatelessWidget {
  const _PasswordField({
    required this.ctrl,
    required this.obscure,
    required this.onToggle,
    required this.l,
  });
  final TextEditingController ctrl;
  final bool obscure;
  final VoidCallback onToggle;
  final AppLocalizations l;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: ctrl,
      obscureText: obscure,
      decoration: InputDecoration(
        labelText: l.t('authPassword'),
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
          onPressed: onToggle,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}

class _ErrorBox extends StatelessWidget {
  const _ErrorBox(this.message);
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Text(
        message,
        style: TextStyle(color: Colors.red.shade700, fontSize: 13),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.label,
    required this.isLoading,
    required this.onPressed,
  });
  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            )
          : Text(label, style: const TextStyle(fontSize: 15)),
    );
  }
}
