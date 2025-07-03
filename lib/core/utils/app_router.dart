
import 'package:go_router/go_router.dart';
import 'package:scholar_app/views/chat_view.dart';
import 'package:scholar_app/views/login_view.dart';
import 'package:scholar_app/views/register_view.dart';
import 'package:scholar_app/views/splash_view.dart';

class AppRouter {
  static const kLoginView = '/loginView';
  static const kRegisterView = '/registerView';
  static const kChatView = '/chatView';

  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: kRegisterView,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(path: kLoginView, builder: (context, state) => const LoginView()),
  GoRoute(
  path: kChatView,
  builder: (context, state) {
    final userEmail = state.extra as String;
    return ChatView(userEmail: userEmail);
  },
),


    
    ],
  );
}
