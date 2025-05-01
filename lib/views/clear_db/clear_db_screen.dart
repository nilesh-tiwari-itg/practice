import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_backend/utils/dialogs.dart';
import 'package:practice_backend/views/clear_db/bloc/clear_db_screen_bloc.dart';
import 'package:practice_backend/views/clear_db/bloc/clear_db_screen_event.dart';
import 'package:practice_backend/views/clear_db/bloc/clear_db_screen_state.dart';
import 'package:practice_backend/views/widgets/custom_button.dart';

class ClearDbScreen extends StatelessWidget {
  const ClearDbScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClearDbScreenBloc(),
      child: BlocConsumer<ClearDbScreenBloc, ClearDbScreenState>(
        listener: (context, state) {
          if (state is ClearDbScreenSuccessState) {
            Dialogs.successDialog(message: state.message);
          } else if (state is ClearDbScreenFailureState) {
            Dialogs.errorDialog(message: state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Clear Chat DB"),
            ),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Clear Complete Chat History",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: "Clear Complete Chat History",
                    onPressed: () async {
                      DIALOG_ACTION action = await Dialogs.customAbortDialog(
                          context, "Are you sure?", "",
                          secondarybuttonText: "No");
                      if (action == DIALOG_ACTION.YES) {
                        context
                            .read<ClearDbScreenBloc>()
                            .add(OnClearDbCompleteChatHistoryEvent());
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Divider(
                    color: Colors.black,
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      "Clear",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
