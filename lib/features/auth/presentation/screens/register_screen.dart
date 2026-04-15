import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:laundry/core/di/injection_container.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state.dart';
import 'package:laundry/features/auth/presentation/cubit/auth_state_x.dart';
import 'package:laundry/features/auth/presentation/utils/auth_navigation.dart';
import 'package:laundry/features/auth/presentation/widgets/forms/register_form_view.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  void _submitRegistration(BuildContext context) {
    context.read<AuthCubit>().requestRegisterOtp(
      name: _usernameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      phone: _phoneController.text.trim(),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              AuthNavigation.handleEntryFlowState(context, state);
            },
            child: BlocSelector<AuthCubit, AuthState, bool>(
              selector: (state) => state.isLoading,
              builder: (context, isLoading) {
                return RegisterFormView(
                  formKey: _formKey,
                  usernameController: _usernameController,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  phoneController: _phoneController,
                  isPasswordObscured: _obscurePassword,
                  isConfirmPasswordObscured: _obscureConfirmPassword,
                  isLoading: isLoading,
                  onTogglePasswordVisibility: _togglePasswordVisibility,
                  onToggleConfirmPasswordVisibility:
                      _toggleConfirmPasswordVisibility,
                  onSubmit: () => _submitRegistration(context),
                  onNavigateToLogin: () => context.pop(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
