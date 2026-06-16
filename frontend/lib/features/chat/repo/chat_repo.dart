import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gpt_clone/features/chat/models/chat_message_model.dart';

class ChatRepo {
  static Stream<String> fetchMessges(
    List<ChatMessageModel> messages,
    String prompt,
  ) async* {
    final dio = Dio();
    List<Map> mappedMessages = messages.map((e) => (e.toJson())).toList();

    final response = await dio.post(
      "${dotenv.env['API_URL']}/generate",
      data: {'history': mappedMessages, 'prompt': prompt},
      options: Options(
        responseType: ResponseType.stream,
        headers: {
          "Content-Type": "application/json",
          "Accept": "text/event-stream",
          "Cache-Control": "no-cache",
        },
      ),
    );

    final sreamedData = response.data.stream;

    await for (final chunk in sreamedData) {
      final decoded = utf8.decode(chunk);
      yield decoded;
    }
  }
}
