// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ns_read_story/ultils/extensions.dart';
// import 'package:ns_read_story/ultils/global_bloc.dart';

// import '../../../shared/cache_image_network.dart';
// import '../../../ultils/constants.dart';

// class HeaderPersonal extends StatelessWidget {
//   const HeaderPersonal({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: context.getHeight() / 5 + context.getWidth() /4.7,
//           child: Stack(
//             children: [
//               Hero(
//                 tag: 'assets/bg_personal.png',
//                 child: (AppProvider.instance.user.coverImage != null && AppProvider.instance.user.coverImage != '') ?
//                 CachedNetworkImageCustom(
//                   url:  AppProvider.instance.user.coverImage!,
//                   width: context.getWidth(),
//                   height: context.getHeight() / 4,
//                   boxFit: BoxFit.cover,
//                 )
//                     :
//                 Image.asset('assets/bg_story.png',
//                   width: context.getWidth(),
//                   height: context.getHeight() / 4,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Positioned(
//                   top: context.getHeight() /6.5,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Hero(
//                       tag: 'assets/logo.png',
//                       child: ClipRRect(
//                           borderRadius: BorderRadius.circular(150),
//                           child:AppProvider.instance.user.avatarUrl != null ? CachedNetworkImageCustom(
//                             url: AppProvider.instance.user.avatarUrl ?? '' ,
//                             width: context.getWidth() /3.5,
//                             height: context.getWidth() /3.5,
//                             boxFit: BoxFit.cover,
//                           ) : Image.asset('assets/logo.png',
//                             width: context.getWidth() /3.5,
//                             height: context.getWidth() /3.5,
//                             fit: BoxFit.cover,
//                             alignment: Alignment.topCenter,
//                           )
//                       ),
//                     ),
//                   )
//               )

//             ],
//           ),
//         ),
//         Text(
//           AppProvider.instance.user.fullName ?? '',
//           style: textStyleFullName,
//         ),
//         const SizedBox(height: 3,),
//         Text(
//           '@${AppProvider.instance.user.tagName ?? ''}',
//           style: textStyleTagName,
//         ),
//         // const SizedBox(height: 5,),
//         // Container(
//         //   decoration: BoxDecoration(
//         //       color: colorWhite,
//         //       borderRadius: BorderRadius.circular(20),
//         //       border: Border.all(color: colorBlack.withOpacity(0.7))
//         //   ),
//         //   height: 35,
//         //   constraints: BoxConstraints(
//         //       minWidth: context.getWidth()/9,
//         //       maxHeight: double.infinity
//         //   ),
//         //   child: Row(
//         //     crossAxisAlignment: CrossAxisAlignment.center,
//         //     mainAxisSize: MainAxisSize.min,
//         //     children: [
//         //       Padding(
//         //         padding: const EdgeInsets.symmetric(horizontal: 5),
//         //         child: Row(
//         //           crossAxisAlignment: CrossAxisAlignment.center,
//         //           mainAxisSize: MainAxisSize.min,
//         //           children: [
//         //             SvgPicture.asset('assets/ic_coin.svg',width: 20,height: 20,),
//         //             const SizedBox(width: 10,),
//         //             Text("60",style: textNormal.copyWith(fontSize: 14),),
//         //           ],
//         //         ),
//         //       ),
//         //       const SizedBox(
//         //         height: 35,
//         //         width: 1,
//         //         child: VerticalDivider(
//         //           color: colorGrey,
//         //         ),
//         //       ),
//         //       Padding(
//         //         padding: const EdgeInsets.symmetric(horizontal: 10),
//         //         child: SvgPicture.asset('assets/ic_add.svg',width: 15,height: 15,color: Colors.green,),
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
