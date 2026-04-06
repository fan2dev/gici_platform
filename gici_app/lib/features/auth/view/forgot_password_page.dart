import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/auth_cubit.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _codeSent = false;
  bool _isLoading = false;
  String? _message;
  bool _isError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _requestReset() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _message = null;
    });

    await context.read<AuthCubit>().requestPasswordReset(
          email: _emailController.text.trim(),
        );

    setState(() {
      _isLoading = false;
      _codeSent = true;
      _isError = false;
      _message = 'Se ha enviado un codigo de verificacion a tu email.';
    });
  }

  Future<void> _resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _message = null;
    });

    final success = await context.read<AuthCubit>().resetPassword(
          email: _emailController.text.trim(),
          code: _codeController.text.trim(),
          newPassword: _passwordController.text,
        );

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Contrasena actualizada. Inicia sesion.'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      context.go('/login');
    } else {
      setState(() {
        _isError = true;
        _message = 'Codigo invalido o expirado.';
      });
    }
  }

  int get _currentStep => _codeSent ? 1 : 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.primary.withValues(alpha: 0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: _ForgotPasswordCard(
                  formKey: _formKey,
                  emailController: _emailController,
                  codeController: _codeController,
                  passwordController: _passwordController,
                  codeSent: _codeSent,
                  isLoading: _isLoading,
                  message: _message,
                  isError: _isError,
                  currentStep: _currentStep,
                  onRequestReset: _requestReset,
                  onResetPassword: _resetPassword,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Card
// ---------------------------------------------------------------------------

class _ForgotPasswordCard extends StatelessWidget {
  const _ForgotPasswordCard({
    required this.formKey,
    required this.emailController,
    required this.codeController,
    required this.passwordController,
    required this.codeSent,
    required this.isLoading,
    required this.message,
    required this.isError,
    required this.currentStep,
    required this.onRequestReset,
    required this.onResetPassword,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController codeController;
  final TextEditingController passwordController;
  final bool codeSent;
  final bool isLoading;
  final String? message;
  final bool isError;
  final int currentStep;
  final VoidCallback onRequestReset;
  final VoidCallback onResetPassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 40,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // -- Back + title -------------------------------------------
            Row(
              children: [
                IconButton(
                  onPressed: () => context.go('/login'),
                  icon: const Icon(Icons.arrow_back_rounded),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Recuperar contrasena',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Te enviaremos un codigo para restablecer tu contrasena',
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),

            // -- Step indicator -----------------------------------------
            _StepIndicator(currentStep: currentStep),
            const SizedBox(height: 28),

            // -- Email field (always visible) ---------------------------
            TextFormField(
              controller: emailController,
              decoration: _inputDecoration(
                hint: 'Email',
                icon: Icons.email_outlined,
              ),
              keyboardType: TextInputType.emailAddress,
              enabled: !codeSent,
              validator: (v) =>
                  v == null || v.isEmpty ? 'Introduce tu email' : null,
            ),

            // -- Code + new password (step 2) --------------------------
            if (codeSent) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: codeController,
                decoration: _inputDecoration(
                  hint: 'Codigo de verificacion',
                  icon: Icons.pin_outlined,
                ),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Introduce el codigo' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: _inputDecoration(
                  hint: 'Nueva contrasena',
                  icon: Icons.lock_outlined,
                ),
                obscureText: true,
                validator: (v) => v == null || v.length < 6
                    ? 'Minimo 6 caracteres'
                    : null,
              ),
            ],

            // -- Message ------------------------------------------------
            if (message != null) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isError
                      ? Colors.red.withValues(alpha: 0.08)
                      : colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Icon(
                      isError
                          ? Icons.error_outline_rounded
                          : Icons.info_outline_rounded,
                      size: 18,
                      color: isError ? Colors.red : colorScheme.primary,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        message!,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isError ? Colors.red : colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 24),

            // -- Action button ------------------------------------------
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: isLoading
                    ? null
                    : (codeSent ? onResetPassword : onRequestReset),
                style: FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                child: isLoading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        codeSent ? 'Cambiar contrasena' : 'Enviar codigo',
                      ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: TextButton(
                onPressed: () => context.go('/login'),
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                ),
                child: const Text(
                  'Volver al inicio de sesion',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
  }) {
    // Note: this is a stateless helper — we rely on the parent providing
    // a BuildContext-derived colorScheme via the surrounding widget tree.
    // Since this is inside a container that already uses colorScheme.primary,
    // the focusedBorder color below matches the theme.
    return InputDecoration(
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.grey.shade500),
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade100),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Step indicator (line-based with dots)
// ---------------------------------------------------------------------------

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({required this.currentStep});

  final int currentStep;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final primary = colorScheme.primary;

    return Row(
      children: [
        _StepDot(
          label: '1',
          isActive: true,
          isCurrent: currentStep == 0,
          color: primary,
        ),
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 3,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: currentStep >= 1
                  ? primary
                  : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        ),
        _StepDot(
          label: '2',
          isActive: currentStep >= 1,
          isCurrent: currentStep == 1,
          color: primary,
        ),
      ],
    );
  }
}

class _StepDot extends StatelessWidget {
  const _StepDot({
    required this.label,
    required this.isActive,
    required this.isCurrent,
    required this.color,
  });

  final String label;
  final bool isActive;
  final bool isCurrent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? color : Colors.grey.shade200,
        boxShadow: isCurrent
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey.shade500,
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
