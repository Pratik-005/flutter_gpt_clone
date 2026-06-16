import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:gpt_clone/design/app_colors.dart';
import 'package:gpt_clone/features/chat/bloc/chat_bloc.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  bool isPromptEntered = false;
  TextEditingController controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Icon(Icons.menu, size: 30),
        title: Text('ChatGPT', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<ChatBloc, ChatState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                if (isPromptEntered)
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.messageList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 5),
                          decoration: BoxDecoration(
                            color: state.messageList[index].role == 'model'
                                ? AppColors.messageBgColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                state.messageList[index].role == 'model'
                                    ? Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/chatgpt.jpeg",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        height: 25,
                                        width: 25,
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: AssetImage(
                                              "assets/random.jpeg",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        height: 25,
                                        width: 25,
                                      ),

                                const SizedBox(width: 10),

                                Expanded(
                                  child: MarkdownBody(
                                    selectable: true,
                                    data: state.messageList[index].content,
                                    styleSheet: MarkdownStyleSheet(
                                      p: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                if (!isPromptEntered)
                  Expanded(
                    child: Center(
                      child: Text(
                        'How can I help with ?',
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.only(right: 15, left: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            hintText: 'Ask Anything ...',
                            filled: false,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      InkWell(
                        child: Icon(Icons.send),
                        onTap: () {
                          if (controller.text.isNotEmpty) {
                            final text = controller.text;
                            context.read<ChatBloc>().add(
                              NewPromptEvent(prompt: text),
                            );
                            controller.clear();
                            FocusScope.of(context).unfocus();
                          }
                          setState(() {
                            isPromptEntered = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  spacing: 10,
                  children: [
                    const SizedBox(width: 1),
                    Text(
                      'Chatgpt Mar 14 version.',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                    Text('Free Research Preview'),
                  ],
                ),
              ],
            ),
          );
        },
        listener: (context, state) {
          _scrollToBottom();
        },
      ),
    );
  }
}
