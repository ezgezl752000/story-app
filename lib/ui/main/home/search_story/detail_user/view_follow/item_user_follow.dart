import 'package:flutter/material.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ui/main/home/search_story/detail_user/view_follow/view_follow_viewmodel.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';

import '../../../../../../model/user.dart';
import '../../../../../../ultils/constants.dart';

class ItemUserFollow extends StatelessWidget {
  final UserModel user;
  const ItemUserFollow({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ViewFollowViewModel>();
    return InkWell(
      onTap: () async {
        await navigatorToUserPage(context, user.id ?? '');
        viewModel.refreshData();
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
            (user.avatarUrl != null && user.avatarUrl != '')
                ? CachedNetworkImageCustom(
                    url: user.avatarUrl ?? '',
                    width: 50,
                    height: 50,
                    boxFit: BoxFit.cover,
                    borderRadius: 150,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Image.asset(
                      'assets/logo_no_text.png',
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
            sizeBox20,
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.tagName ?? '',
                  style: textTitleBlack,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  user.fullName ?? '',
                  style: textTitleBlack.copyWith(color: Colors.grey),
                ),
              ],
            )),
            sizeBox10,
          ],
        ),
      ),
    );
  }
}
