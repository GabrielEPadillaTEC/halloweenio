import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../domain/dtos/message.dart';
import '../../../presentation/providers/chats/chat_provider.dart';
import '../../../presentation/widgets/chat/message_bubble.dart';
import '../../../presentation/widgets/shared/message_field_box.dart';
import '../../../presentation/widgets/herBar/her_presentation.dart';

class ChatScreen extends StatelessWidget {
  static const String screenName = 'chat_screen';
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatProvider(), // Create an instance of your ChatProvider
      child: const Scaffold(
        appBar: HerPresentation(
          nombre: 'Holo',
          urlAvatar:
          'https://c4.wallpaperflare.com/wallpaper/987/482/404/anime-spice-and-wolf-holo-spice-and-wolf-hd-wallpaper-preview.jpg',
        ),
        body: ChatView(),
      ),
    );
  }
}

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();
    return Container( // Wrap with a Container
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('https://www.waifu.com.mx/wp-content/uploads/2023/05/Holo-8.jpg'),
          colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
        ),
        
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messageList.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messageList[index];
                    return (message.fromWho == FromWho.hers)
                        ? HerMessageBubble(
                        message: message.text, urlGif: message.imageUrl)
                        : MyMessageBubble(message: message.text);
                  },
                ),
              ),
              MessageFieldBox(onValue: chatProvider.sendMessage),
            ],
          ),
        ),
      ),
    );
  }
}