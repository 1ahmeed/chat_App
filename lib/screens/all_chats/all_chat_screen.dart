import 'package:chat_app/component/widgets/chat_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/chat_cubit/chat_cubit.dart';
import '../../layout/chat_cubit/chat_state.dart';

class AllChatScreen extends StatelessWidget {
  const AllChatScreen({Key? key}) : super(key: key);
  static String id = 'AllChatScreen';

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ChatCubit.get(context)?.getUsers();
        return BlocConsumer<ChatCubit, ChatStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              body: ConditionalBuilder(
                condition: ChatCubit.get(context)!.users!.isNotEmpty,
                builder: (context) => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      ChatItem(model: ChatCubit.get(context)!.users![index]),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 0,
                  ),
                  itemCount: ChatCubit.get(context)!.users!.length,
                ),
                fallback: (context) => Center(
                    child: Text(
                  'There are no users registered yet',
                  style: Theme.of(context).textTheme.caption,
                )),
              ),
            );
          },
        );
      }
    );
  }
}
