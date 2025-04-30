import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/utils/dialogs.dart';
import 'package:practice_backend/views/clear_db/bloc/clear_db_screen_bloc.dart';
import 'package:practice_backend/views/clear_db/bloc/clear_db_screen_state.dart';

class ClearDbScreen extends StatelessWidget {
  const ClearDbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClearDbScreenBloc(),
      child: BlocConsumer<ClearDbScreenBloc, ClearDbScreenState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Clear Chat DB"),
            ),
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  DIALOG_ACTION action = await Dialogs.customAbortDialog(
                      context, "Are you sure?", "",
                      secondarybuttonText: "No");
                  if (action == DIALOG_ACTION.YES) {
                    // context.read<ClearDbScreenBloc>().clearFullChatHistory();
                  }
                },
                child: const Text("Clear Complete Chat History"),
              ),
            ),
          );
        },
      ),
    );
  }
}
