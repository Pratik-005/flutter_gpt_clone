import 'dart:async';
import 'package:flutter/material.dart' show immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Emitter, Bloc;
import 'package:gpt_clone/features/chat/models/chat_message_model.dart';
import 'package:gpt_clone/features/chat/repo/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState(messageList: [])) {
    on<NewPromptEvent>(newPromptEvent);
  }

  StreamSubscription<String>? _subscription;

  FutureOr<void> newPromptEvent(
    NewPromptEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      _subscription?.cancel();

      final history = state.messageList;

      final messageList = List<ChatMessageModel>.from(state.messageList)
        ..add(ChatMessageModel(role: 'user', content: event.prompt))
        ..add(ChatMessageModel(role: 'model', content: ""));

      emit(ChatLoadState(messageList: messageList));

      // final completer = Completer<void>();

      _subscription = ChatRepo.fetchMessges(history, event.prompt).listen(
        (chunk) {
          if (emit.isDone) return;

          final text = chunk.startsWith('data : ')
              ? chunk.replaceFirst('data : ', '').trim()
              : chunk;

          messageList.last = ChatMessageModel(
            role: 'model',
            content: messageList.last.content + text,
          );

          emit(ChatSuccessState(messageList: messageList));
        },
        // onDone: () {
        //   completer.complete();
        // },
      );

      // await completer.future;
      await _subscription?.asFuture();
    } catch (e) {
      emit(ChatErrorState(message: e.toString(), messageList: []));
    }
  }
}
