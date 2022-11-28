// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:ns_read_story/model/user.dart';
// import 'package:ns_read_story/page_routes.dart';
// import 'package:ns_read_story/shared/app_bar_home.dart';
// import 'package:ns_read_story/ui/main/personal/header.dart';
// import 'package:ns_read_story/ui/main/personal/header_new.dart';
// import 'package:ns_read_story/ui/main/personal/item_menu.dart';
// import 'package:ns_read_story/ultils/constants.dart';
// import 'package:ns_read_story/ultils/extensions.dart';
// import 'package:ns_read_story/ultils/global_bloc.dart';
// import 'package:ns_read_story/ultils/pref_data.dart';

// import '../../../shared/dialog.dart';

// class PersonalPage extends StatefulWidget {
//   PersonalPage({Key? key, this.navigatorFromForum}) : super(key: key);
//   bool? navigatorFromForum;
//   @override
//   _PersonalPageState createState() => _PersonalPageState();
// }

// class _PersonalPageState extends State<PersonalPage> {

// final ScrollController _scrollController = ScrollController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: colorBg,
//         body: Stack(
//           children: [          
//             FutureBuilder(
//               initialData: AppProvider.instance.token,
//               builder: (_,data){
//                 if(data.hasData){
//                   return SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         HeaderPersonal(),
//                         const SizedBox(height: 5,),
//                         ItemMenu(icon: 'assets/ic_edit.svg', title: 'Đăng truyện', action: (){
//                           Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.postStory,arguments: '');
//                         }),
//                         ItemMenu(icon: 'assets/ic_document.svg', title: 'Trang cá nhân', action: (){
//                           Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.detailPersonal, arguments: AppProvider.instance.user.id);
//                         }),
//                         // ItemMenu(icon: 'assets/ic_store.svg', title: 'Nạp xu', action: (){
//                         //
//                         // }),
//                         // ItemMenu(icon: 'assets/ic_history.svg', title: 'Lịch sử giao dịch', action: (){
//                         //
//                         // }),
//                         ItemMenu(icon: 'assets/ic_edit.svg', title: 'Chỉnh sửa thông tin cá nhân', action: () async{
//                           await  Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.updateProfile);
//                           setState(() {});
//                         }),
//                         ItemMenu(icon: 'assets/ic_lock.svg', title: 'Đổi mật khẩu', action: (){
//                           Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.changePassword);
//                         }),
//                         // ItemMenu(icon: 'assets/ic_policy.svg', title: 'Chính sách và điều khoản', action: (){
//                         //
//                         // }),
//                         // ItemMenu(icon: 'assets/ic_info.svg', title: 'Về Hải Vương', action: (){
//                         //
//                         // }),
//                         // ItemMenu(icon: 'assets/ic_vote.svg', title: 'Rate cho chúng tôi', action: (){
//                         //
//                         // }),
//                         // ItemMenu(icon: 'assets/ic_info.svg', title: 'Giới thiệu về ứng dụng nhận thưởng', action: (){
//                         //
//                         // }),
//                         ItemMenu(icon: 'assets/ic_logout.svg', title: 'Đăng xuất', action: () async{
//                          await logOut();
//                         }),
    
//                       ],
//                     ),
//                   );
//                 }else{
//                   return Center(
//                     child: DialogLogin(
//                       mess: 'Vui lòng đăng nhập để sử dụng chức năng này',
//                       action: () async{
//                         Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.login,arguments: 4);
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//             if(widget.navigatorFromForum ?? false)Positioned(
//                     top: 5,
//                     left: 10,
//                     child: IconButton(
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                         icon: SvgPicture.asset(
//                           'assets/ic_back.svg',
//                           width: 30,
//                           height: 30,
//                         ))),
//           ],
//         ),
//         // appBar: MyAppBarHome(
//         //   title: "Cá nhân",
//         // ),
//         // body: Stack(
//         //   children: [
//         //     CustomScrollView(
//         //       controller: _scrollController,
//         //       slivers: [
//         //         Header(),
//         //         SliverList(
//         //             delegate: SliverChildListDelegate(
//         //               [
//         //                 const SizedBox(height: 5,),
//         //                 ItemMenu(icon: 'assets/ic_edit.svg', title: 'Đăng truyện', action: (){
//         //                   Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.postStory,arguments: '');
//         //                 }),
//         //                 ItemMenu(icon: 'assets/ic_document.svg', title: 'Truyện đã đăng', action: (){
//         //                   Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.detailPersonal);
//         //                 }),
//         //                 // ItemMenu(icon: 'assets/ic_store.svg', title: 'Nạp xu', action: (){
//         //                 //
//         //                 // }),
//         //                 // ItemMenu(icon: 'assets/ic_history.svg', title: 'Lịch sử giao dịch', action: (){
//         //                 //
//         //                 // }),
//         //                 ItemMenu(icon: 'assets/ic_edit.svg', title: 'Chỉnh sửa thông tin cá nhân', action: () async{
//         //                   await  Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.updateProfile);
//         //                   setState(() {});
//         //                 }),
//         //                 ItemMenu(icon: 'assets/ic_lock.svg', title: 'Đổi mật khẩu', action: (){
//         //                   Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.changePassword);
//         //                 }),
//         //                 // ItemMenu(icon: 'assets/ic_policy.svg', title: 'Chính sách và điều khoản', action: (){
//         //                 //
//         //                 // }),
//         //                 // ItemMenu(icon: 'assets/ic_info.svg', title: 'Về Hải Vương', action: (){
//         //                 //
//         //                 // }),
//         //                 // ItemMenu(icon: 'assets/ic_vote.svg', title: 'Rate cho chúng tôi', action: (){
//         //                 //
//         //                 // }),
//         //                 // ItemMenu(icon: 'assets/ic_info.svg', title: 'Giới thiệu về ứng dụng nhận thưởng', action: (){
//         //                 //
//         //                 // }),
//         //                 ItemMenu(icon: 'assets/ic_logout.svg', title: 'Đăng xuất', action: () async{
//         //                   await PreferenceManager.setBool(PreferenceManager.remember, false);
//         //                   Navigator.of(context,rootNavigator: true).pushNamedAndRemoveUntil(PageRoutes.login, (route) => false);
//         //                 }),
//         //
//         //               ]
//         //             )
//         //         ),
//         //       ],
//         //     ),
//         //      // Positioned(
//         //      //    top: 25,
//         //      //    right: 5,
//         //      //    child: InkWell(
//         //      //        onTap: () async{
//         //      //
//         //      //        },
//         //      //        child: const Icon(Icons.edit,color: Colors.black54,size: 35,)))
//         //   ],
//         // ),
//       ),
//     );
//   }
//   Future logOut() async{
//     await PreferenceManager.clear();
//     await PreferenceManager.setBool(PreferenceManager.remember, false);
//     await PreferenceManager.setBool(PreferenceManager.isFirstLogin, false);
//     AppProvider.instance.token = null;
//     AppProvider.instance.user = UserModel();
//     Navigator.of(context,rootNavigator: true).pushNamedAndRemoveUntil(PageRoutes.mainPage, (route) => false,arguments: 0);
//   }
// }
