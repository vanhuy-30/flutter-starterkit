import 'package:flutter/material.dart';
import '/core/utils/utils.dart';
import '/presentation/components/atoms/text_fields/app_text_field.dart';
import '/presentation/components/atoms/text_fields/password_text_field.dart';
import '/presentation/components/molecules/social_login_button.dart';
import '/presentation/pages/register_page.dart';
import '/presentation/viewmodels/login_viewmodel.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(context.read()),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  const _LoginView();

  VoidCallback _wrapCallback(Future<void> Function()? callback) {
    return () {
      if (callback != null) {
        callback();
      }
    };
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LoginViewModel>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Login'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const FlutterLogo(size: 80),
                  const SizedBox(height: 24.0),
                  Text(
                    'Chào mừng trở lại!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Đăng nhập để tiếp tục',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 32.0),
                  AppTextField(
                    controller: viewModel.usernameController,
                    labelText: 'Tên đăng nhập hoặc Email',
                    hintText: 'Nhập tên đăng nhập của bạn',
                    prefixIcon: const Icon(Icons.person_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên đăng nhập';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  PasswordTextField(
                    controller: viewModel.passwordController,
                    labelText: 'Mật khẩu',
                    hintText: 'Nhập mật khẩu của bạn',
                    prefixIcon: const Icon(Icons.lock_outline),
                    obscureText: viewModel.obscurePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        viewModel.obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: viewModel.togglePasswordVisibility,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập mật khẩu';
                      }
                      if (value.length < 6) {
                        return 'Mật khẩu phải có ít nhất 6 ký tự';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        showAppSnackBar(context, 'Chức năng quên mật khẩu');
                      },
                      child: const Text('Quên mật khẩu?'),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      textStyle:
                          const TextStyle(fontSize: 18.0, color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 5,
                    ),
                    onPressed: viewModel.isLoading
                        ? null
                        : _wrapCallback(viewModel.login),
                    child: viewModel.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('Đăng Nhập',
                            style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    children: <Widget>[
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          'Hoặc đăng nhập với',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SocialLoginButton(
                        icon: Icons.phone_android,
                        label: 'Điện thoại',
                        onPressed: viewModel.isLoading
                            ? () {}
                            : _wrapCallback(viewModel.loginWithPhone),
                        color: Colors.green,
                      ),
                      SocialLoginButton(
                        icon: Icons.mail_outline,
                        label: 'Gmail',
                        onPressed: viewModel.isLoading
                            ? () {}
                            : _wrapCallback(viewModel.loginWithGoogle),
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SocialLoginButton(
                        icon: Icons.facebook,
                        label: 'Facebook',
                        onPressed: viewModel.isLoading
                            ? () {}
                            : _wrapCallback(viewModel.loginWithFacebook),
                        color: Colors.blue.shade800,
                      ),
                      SocialLoginButton(
                        icon: Icons.apple,
                        label: 'Apple',
                        onPressed: viewModel.isLoading
                            ? () {}
                            : _wrapCallback(viewModel.loginWithApple),
                        color: Colors.black,
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text("Chưa có tài khoản? "),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                        child: const Text(
                          'Đăng ký ngay',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
