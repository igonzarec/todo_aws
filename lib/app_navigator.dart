import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_aws/auth_cubit.dart';
import 'package:todo_aws/auth_state.dart';
import 'package:todo_aws/auth_view.dart';
import 'package:todo_aws/loading_view.dart';
import 'package:todo_aws/todo_cubit.dart';
import 'package:todo_aws/todos_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is Unauthenticated) MaterialPage(child: AuthView()),
            if (state is Authenticated)
              MaterialPage(
                  child: BlocProvider(
                create: (context) => TodoCubit(userId: state.userId)
                  ..getTodos()
                  ..observeTodos(),
                // ..observeTodos(),
                child: TodosView(),
              )),
            if (state is UnknownAuthState) MaterialPage(child: LoadingView()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
