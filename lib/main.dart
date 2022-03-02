import 'package:myflutternotes/services/auth/auth_service.dart';
import 'package:myflutternotes/views/constants/routes.dart';
import 'package:myflutternotes/views/login_view.dart';
import 'package:myflutternotes/views/notes_view.dart';
import 'package:myflutternotes/views/verify_email_view.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:myflutternotes/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
        //copy this and put it in RunApp
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          loginRoute: (context) => const LoginView(),
          registerRoute: (context) => const RegisterView(),
          notesRoute: (context) => const NotesView(),
          verifyEmailRoute: (context) => const VerifyEmailView(),
        }),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
