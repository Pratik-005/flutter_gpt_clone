part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class NewPromptEvent extends ChatEvent {
  final String prompt;
  NewPromptEvent({required this.prompt});
}
