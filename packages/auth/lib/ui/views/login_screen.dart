import 'package:auth/auth.dart';
import 'package:core/core.dart' show getIt;
import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:gap/gap.dart';
import 'package:mobx/mobx.dart';

class LoginScreen extends StatefulWidget {
  final Function() onAuthenticated;

  const LoginScreen({required this.onAuthenticated, super.key});

  static const routeName = 'login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final store = getIt<LoginStore>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late ReactionDisposer _errorDisposer;
  late ReactionDisposer _authenticatedDisposer;

  @override
  void initState() {
    super.initState();
    _errorDisposer = reaction<String?>((_) => store.errorMessage, (errorMessage) {
      if (errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
      }
    });

    _authenticatedDisposer = reaction<bool>((_) => store.isAuthenticated, (isAuthenticated) {
      if (isAuthenticated) {
        widget.onAuthenticated();
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _errorDisposer();
    _authenticatedDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          bottom: PreferredSize(
            preferredSize: const Size(double.infinity, AppSpacing.xs),
            child: Observer(
              builder: (context) {
                if (store.isSubmitting) {
                  return const LinearProgressIndicator();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        body: AppWaveBackground(
          waveColor: theme.colorScheme.primary,
          child: Positioned.fill(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox.shrink(),
                            Column(
                              children: [
                                Column(
                                  children: [
                                    Text('Salsa Challenge', style: theme.textTheme.displaySmall?.copyWith(letterSpacing: 1.8)),
                                    Text(
                                      'Locations',
                                      style: theme.textTheme.displayMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: theme.colorScheme.primary,
                                        letterSpacing: 1.8,
                                      ),
                                    ),
                                  ],
                                ),
                                const Gap(AppSpacing.xxxl),
                                TextField(
                                  onChanged: store.setEmail,
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.sm), borderSide: BorderSide.none),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.sm)),
                                    fillColor: theme.colorScheme.surfaceContainer,
                                    filled: true,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                const Gap(AppSpacing.md),
                                Observer(
                                  builder: (context) {
                                    return TextField(
                                      onChanged: store.setPassword,
                                      controller: passwordController,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.sm), borderSide: BorderSide.none),
                                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.sm)),
                                        fillColor: theme.colorScheme.surfaceContainer,
                                        filled: true,
                                        suffixIcon: IconButton(
                                          onPressed: store.toggleShowPassword,
                                          tooltip: store.showPassword ? 'Hide password' : 'Show password',
                                          icon: !store.showPassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                        ),
                                      ),
                                      obscureText: !store.showPassword,
                                    );
                                  },
                                ),
                              ],
                            ),
                            const Gap(AppSpacing.xxxl),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Observer(
                                  builder: (context) {
                                    return FilledButton(onPressed: store.canSubmit ? store.login : null, child: const Text('Login'));
                                  },
                                ),
                                const TextButton(onPressed: null, child: Text('Create a new Account')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
