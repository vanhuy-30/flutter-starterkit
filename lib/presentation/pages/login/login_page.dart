import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pushReplacementNamed(context, '/home');
            } else if (state.error != null) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          builder: (context, state) {
            final bloc = context.read<LoginBloc>();

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextField(
                    key: const Key('email'),
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    key: const Key('password'),
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 24),
                  state.isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () {
                            bloc.add(LoginSubmitted('test', '123'));
                          },
                          child: const Text('Login'),
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
