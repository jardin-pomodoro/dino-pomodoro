import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../state/user/user_provider.dart';
import '../../../state/user/user_state_notifier.dart';
import '../../theme/assets.dart';
import '../../theme/theme.dart';

class FriendsBanner extends ConsumerWidget {
  final String userId;

  const FriendsBanner({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final providers = ref.watch(userServiceProvider);
    providers.fetchUserById(userId).then((value)  {
      ref.read(userStateNotifierProvider.notifier).clearUsers();
      ref
          .read(userStateNotifierProvider.notifier)
          .addUser(value.data!);
    });
    return ListTile(
      tileColor: PomodoroTheme.secondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      leading: const Icon(
        Icons.people_alt_outlined,
        color: PomodoroTheme.white,
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Consumer(builder: (context, ref, child) {
            final user = ref.watch(getUserByIdStateNotifierProvider(userId));
            return Text(
              user.email,
              style: PomodoroTheme.title4White,
            );
          }),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(children: [
                  Text(
                    "15",
                    style: PomodoroTheme.textWhite,
                  ),
                  const Image(
                    image: AssetImage(PomodoroAssets.treeImage),
                    color: PomodoroTheme.white,
                    height: 20,
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: const [
                    Text(
                      "214 min",
                      style: PomodoroTheme.textWhite,
                    ),
                    Image(
                      image: AssetImage(PomodoroAssets.chronoImage),
                      color: PomodoroTheme.white,
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
