
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:ns_read_story/page_routes.dart';
// import 'package:ns_read_story/shared/cache_image_network.dart';
// import 'package:ns_read_story/ultils/app_config.dart';
// import 'package:ns_read_story/ultils/extensions.dart';
// import 'package:ns_read_story/ultils/global_bloc.dart';

// import '../../../ultils/constants.dart';

// class Header extends StatelessWidget {
//   const Header({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return  SliverAppBar(
//       elevation: 0,
//       pinned: true,
//       snap: false,
//       backgroundColor: colorBg,
//       floating: false,
//       expandedHeight: context.getHeight()/2.5,
//       flexibleSpace: LayoutBuilder(
//         builder: (context, constraints) {
//           var top = constraints.biggest.height;
//           return FlexibleSpaceBar(
//             centerTitle: false,
//             titlePadding: const EdgeInsets.all(0),
//             title: top >= context.getHeight()/2.5
//                 ? Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ClipRRect(
//                       borderRadius: BorderRadius.circular(150),
//                       child:AppProvider.instance.user.avatarUrl != null ? CachedNetworkImageCustom(
//                         url: AppProvider.instance.user.avatarUrl ?? '' ,
//                         width: context.getWidth() /6,
//                         height: context.getWidth() /6,
//                         boxFit: BoxFit.cover,
//                       ) : Image.asset('assets/logo_no_text.png',
//                         width: context.getWidth() /6,
//                         height: context.getWidth() /6,
//                         fit: BoxFit.cover,
//                         alignment: Alignment.topCenter,
//                       )
//                   ),
//                   SizedBox(width: context.getWidth(),height: 8,),
//                   Text(
//                     AppProvider.instance.user.fullName ?? '',
//                     style: textStyleFullName,
//                   ),
//                   const SizedBox(height: 3,),
//                   Text(
//                     '@${AppProvider.instance.user.tagName ?? ''}',
//                     style: textStyleTagName,
//                   ),
//                   const SizedBox(height: 5,),
//                   Container(
//                     decoration: BoxDecoration(
//                         color: colorWhite,
//                         borderRadius: BorderRadius.circular(20),
//                         border: Border.all(color: colorBlack.withOpacity(0.7))
//                     ),
//                     height: 35,
//                     constraints: BoxConstraints(
//                         minWidth: context.getWidth()/9,
//                         maxHeight: double.infinity
//                     ),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 5),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               SvgPicture.asset('assets/ic_coin.svg',width: 20,height: 20,),
//                               const SizedBox(width: 10,),
//                               Text("60",style: textNormal.copyWith(fontSize: 14),),
//                             ],
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 35,
//                           width: 1,
//                           child: VerticalDivider(
//                             color: colorGrey,
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 10),
//                           child: SvgPicture.asset('assets/ic_add.svg',width: 15,height: 15,color: Colors.green,),
//                         ),
//                       ],
//                     ),
//                   ),
//                   sizeBox10,
//                 ],
//               ),
//             )
//                 : Padding(
//               padding: const EdgeInsets.all(5),
//               child: Row(
//                 children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(150),
//                       child:AppProvider.instance.user.avatarUrl != null ? CachedNetworkImageCustom(
//                         url:  AppProvider.instance.user.avatarUrl ?? '' ,
//                         width: context.getWidth() /6.5,
//                         height: context.getWidth() /6.5,
//                         boxFit: BoxFit.cover,
//                       ) : Image.asset('assets/logo_no_text.png',
//                         width: context.getWidth() /6.5,
//                         height: context.getWidth() /6.5,
//                         fit: BoxFit.cover,
//                         alignment: Alignment.topCenter,
//                       )
//                   ),
//                   sizeBox10,
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                   AppProvider.instance.user.fullName ?? '',
//                         style: textStyleFullName,
//                       ),
//                       const SizedBox(height: 5,),
//                       Text(
//                         '@${AppProvider.instance.user.tagName ?? ''}',
//                         style: textStyleTagName,
//                       ),
//                       const SizedBox(height: 5,),
//                       Container(
//                         decoration: BoxDecoration(
//                             color: colorWhite,
//                             borderRadius: BorderRadius.circular(20),
//                             border: Border.all(color: colorBlack.withOpacity(0.7))
//                         ),
//                         height: 35,
//                         constraints: BoxConstraints(
//                             minWidth: context.getWidth()/5,
//                             maxHeight: double.infinity
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 5),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   SvgPicture.asset('assets/ic_coin.svg',width: 20,height: 20,),
//                                   const SizedBox(width: 10,),
//                                   Text("60",style: textNormal.copyWith(fontSize: 14),),
//                                 ],
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 35,
//                               width: 1,
//                               child: VerticalDivider(
//                                 color: colorGrey,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 10),
//                               child: SvgPicture.asset('assets/ic_add.svg',width: 15,height: 15,color: Colors.green,),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             background: Hero(
//               tag: AppProvider.instance.user.coverImage ?? 'assets/bg_personal.png',
//               child: AppProvider.instance.user.coverImage != null ?
//               CachedNetworkImageCustom(
//                 url:  AppProvider.instance.user.coverImage! ,
//                 width: context.getWidth(),
//                 height: context.getHeight() / 5,
//                 boxFit: BoxFit.cover,
//               )
//                   :
//               Image.asset('assets/bg_story.png',
//                 width: context.getWidth(),
//                 height: context.getHeight() / 5,
//                 fit: BoxFit.cover,
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
