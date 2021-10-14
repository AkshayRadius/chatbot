import 'package:flutter/material.dart';

import 'package:chatbot/constant.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class Message {
  String? message;
  bool? isMe;
  Message({
    this.message,
    this.isMe,
  });
}

class AskMe extends StatefulWidget {
  const AskMe({Key? key}) : super(key: key);

  @override
  State<AskMe> createState() => _AskMeState();
}

List<Message> chatList = [
  Message(
    isMe: false,
    message:
        'Howdy, I am the EVCD FAQ bot, do you have questions about EVCD? How can I help? I am the EVCD FAQ bot, do you have questions about EVCD? How can I help?',
  ),
  Message(
    isMe: true,
    message: 'hi',
  ),
  Message(
    isMe: true,
    message: ' I am the EVCD FAQ bot, do you have',
  ),
];

class _AskMeState extends State<AskMe> {
  final msgBoxRadius = const Radius.circular(15);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: chatList.length,
              itemBuilder: (context, i) {
                return StickyHeader(
                  header: Container(
                    height: 25.0,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Header #$i',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ),
                  content: ChatBotMessageTile(
                      message: chatList[i],
                      theme: theme,
                      msgBoxRadius: msgBoxRadius),
                );
              }),
        ),
        ChatBotMessage()
      ],
    );
  }
}

class ChatBotMessageTile extends StatelessWidget {
  const ChatBotMessageTile({
    Key? key,
    required this.message,
    required this.theme,
    required this.msgBoxRadius,
  }) : super(key: key);

  final Message message;
  final ThemeData theme;
  final Radius msgBoxRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment:
          message.isMe == false ? Alignment.centerLeft : Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: message.isMe == true
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            // width: size.width * .60,
            // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.all(15),
            child: Text(
              message.message!,
              style: theme.textTheme.subtitle2?.copyWith(
                  color: message.isMe == false ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            decoration: BoxDecoration(
              color: message.isMe == false ? primaryLightColor : primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft:
                    message.isMe == true ? msgBoxRadius : Radius.circular(0),
                bottomRight:
                    message.isMe == false ? msgBoxRadius : Radius.circular(0),
                topRight: msgBoxRadius,
                topLeft: msgBoxRadius,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: message.isMe == true
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text('5 min ago'),
              SizedBox(
                width: 10,
              ),
              if (message.isMe!)
                Icon(
                  Icons.done_all_outlined,
                  color: primaryColor,
                ),
            ],
          )
        ],
      ),
    );
  }
}

class ChatBotMessage extends StatefulWidget {
  ChatBotMessage({Key? key}) : super(key: key);

  @override
  State<ChatBotMessage> createState() => _ChatBotMessageState();
}

class _ChatBotMessageState extends State<ChatBotMessage> {
  String? msg = '';

  TextEditingController msgController = TextEditingController();
  @override
  void dispose() {
    msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: msgController,
                      onChanged: (val) {
                        setState(() {
                          msg = val;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Enter a message',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(Icons.image),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: primaryLightColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {},
                child: msg!.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            chatList
                                .add(Message(message: msg!.trim(), isMe: true));
                          });
                          // msgController.clear();
                        },
                        child: const Icon(Icons.send),
                      )
                    : InkWell(
                        onTap: () {},
                        child: const Icon(Icons.mic_outlined),
                      ),
              )),
        ],
      ),
    );
  }
}
