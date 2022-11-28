// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../ultils/constants.dart';

// class ItemMenu extends StatelessWidget {
//   String icon;
//   String title;
//   var action;
//    ItemMenu({Key? key, required this.icon,required this.title,required this.action}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//         onTap: action?? (){

//         },
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         child: Container(
//           padding: const EdgeInsets.all(10),
//           decoration:  BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: colorGrey.withOpacity(0.5)
//               )
//             )
//           ),
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 25,
//                 height: 25,
//                 child: Center(
//                   child: SvgPicture.asset(
//                     icon,
//                     width: 20,
//                     height: 20,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12,),
//               Expanded(child: Text(title,style: textNormal.copyWith(fontSize: fontSize14),)),
//                const Icon(Icons.navigate_next,color: colorGrey,size: 25,)
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
