import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';

import '../../../../model/user.dart';

class ItemAuthor extends StatelessWidget {
  final UserModel user;
  final int index;
  const ItemAuthor({Key? key,required this.user,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        navigatorToUserPage(context, user.id ?? '');
        // if(user.id == AppProvider.instance.user.id){
        //   await Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.personalPage, arguments: user.id);
        // }else{
        //   await Navigator.pushNamed(context, PageRoutes.detailUser,arguments: user.id);
        // }
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           SizedBox(
             width: context.getWidth()/12,
             child:  index == 0
                 ? SvgPicture.asset("assets/ic_rank_top1.svg")
                 :  index == 1
                 ? SvgPicture.asset("assets/ic_rank_top2.svg")
                 :  index == 2
                 ? SvgPicture.asset("assets/ic_rank_top3.svg")
                 :  Center(child: Text('${index+1}',style: textTitleBlack,)),
           ),
            sizeBox10,
            ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child:(user.avatarUrl != null && user.avatarUrl != '') ? CachedNetworkImageCustom(
                url: user.avatarUrl ?? '',
                width: context.getWidth()/9,
                boxFit: BoxFit.cover,
                height: context.getWidth()/9,
              ) : Image.asset('assets/logo.png',
                width: context.getWidth()/9,
                fit: BoxFit.cover,
                height: context.getWidth()/9,
              ),
            ),
            sizeBox10,
            Expanded(
                child: Text(user.fullName ?? '',style: textTitleBlack,)
            ),
            sizeBox10,
            Text('${user.totalView}',style: textNormal,),
          ],
        ),
      ),
    );
  }
}
