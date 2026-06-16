part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  final List<ChatMessageModel> messageList;
  const ChatState({required this.messageList});
}

final class ChatInitialState extends ChatState {
  const ChatInitialState({required super.messageList});
}

final class ChatLoadState extends ChatState {
  const ChatLoadState({required super.messageList});
}

final class ChatSuccessState extends ChatState {
  const ChatSuccessState({required super.messageList});
}

final class ChatErrorState extends ChatState {
  final String message;
  const ChatErrorState({required this.message, required super.messageList});
}
