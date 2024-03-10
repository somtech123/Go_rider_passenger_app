import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_rider/ui/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:go_rider/ui/features/chat/presentation/bloc/chat_bloc_event.dart';
import 'package:go_rider/ui/features/chat/presentation/bloc/chat_bloc_state.dart';
import 'package:go_rider/ui/features/chat/presentation/view/widget/chat_widgets.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';
import 'package:go_rider/utils/app_constant/app_color.dart';

// ignore: must_be_immutable
class ViewLayout extends StatefulWidget {
  ViewLayout({super.key, required this.sender, required this.receiver});
  UserModel sender;
  RiderModel receiver;

  @override
  State<ViewLayout> createState() => _ViewLayoutState();
}

class _ViewLayoutState extends State<ViewLayout> {
  @override
  void initState() {
    super.initState();

    setUser().then((value) => BlocProvider.of<ChatBloc>(context).add(
        FetchMessage(
            senderId: widget.sender.userId!,
            receiverId: widget.receiver.id!,
            receiver: receiver!,
            user: user!)));
  }

  ChatUser? user;
  ChatUser? receiver;

  Future<void> setUser() async {
    user = ChatUser(
      id: widget.sender.userId!,
      profileImage: widget.sender.profileImage,
      firstName: widget.sender.username,
    );

    receiver = ChatUser(
        id: widget.receiver.id!,
        profileImage: widget.receiver.profileImage,
        firstName: widget.receiver.username);

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ChatBloc chatBloc = BlocProvider.of<ChatBloc>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          iconTheme: const IconThemeData(color: AppColor.whiteColor),
          backgroundColor: AppColor.primaryColor,
          title: Text(
            'Inbox',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.whiteColor),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.call,
              ),
            ),
          ],
        ),
        body: BlocListener<ChatBloc, ChatBlocState>(
          listener: (context, state) {},
          child: BlocBuilder<ChatBloc, ChatBlocState>(
            bloc: chatBloc,
            builder: (context, state) {
              return Stack(
                children: [
                  DashChat(
                    currentUser: user!,
                    onSend: (ChatMessage m) {
                      chatBloc.add(SendMessage(
                          message: m,
                          sender: widget.sender,
                          receiver: widget.receiver));
                    },
                    messages: state.messages!,
                    inputOptions: InputOptions(
                      inputToolbarStyle: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                        10,
                      )),
                      sendOnEnter: true,
                    ),
                    messageOptions: MessageOptions(
                      showTime: true,
                      showOtherUsersAvatar: true,
                      messagePadding: EdgeInsets.all(15.h),
                      showCurrentUserAvatar: true,
                    ),
                    messageListOptions: const MessageListOptions(),
                  ),
                  state.messages!.isEmpty
                      ? noMessages(context)
                      : const SizedBox()
                ],
              );
            },
          ),
        ));
  }
}
