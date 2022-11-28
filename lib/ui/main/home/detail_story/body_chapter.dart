import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/ui/main/home/detail_story/read_story/read_story_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:ns_read_story/ultils/global_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../shared/dialog.dart';
import 'detail_story_viewmodel.dart';

class BodyChapter extends StatelessWidget {
  const BodyChapter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<DetailStoryViewModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Danh sách chương",style: textBoldNormalBlueDark.copyWith(color: blueColor,)),
        const Divider(color: blueColor,thickness: 2,),
        sizeBox10,
        Table(
          columnWidths: const {
            0: FlexColumnWidth(2.5),
            1: FlexColumnWidth(2),
            2: FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children:  [
            const TableRow(
              children: [
                Text(
                  "Số chương",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Cập nhật",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Lượt xem",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),

            ...viewModel.listChapter.where((e) => e.enabled==true).toList().map((e) {
              int index = viewModel.listChapter.indexOf(e);
              return   TableRow(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: colorGrey
                        )
                    )
                ),
                children: [
                  InkWell(
                    onTap: () async {
                      if(AppProvider.instance.token == null){
                        if(e.price !=0){
                          AppProvider.instance.showDialogLogin(
                              context,
                              'Bạn cần đăng nhập để mua chương này');
                        }else{
                          if(index+1>10 || viewModel.checkNumberPage != 0){
                            AppProvider.instance.showDialogLogin(
                                context,
                                'Bạn cần đăng nhập để đọc tiếp');
                          }else{
                            await  Navigator.pushNamed(context, PageRoutes.readStory,arguments: ModelReadStory(
                                idChapter: e.id,
                                listChapter: viewModel.detailStory?.chapters,
                                story:  viewModel.detailStory,
                              index: index,
                              page: viewModel.checkNumberPage
                            ));
                          }

                        }

                      }else{
                        if(e.price ==0 || e.isBuy == true){
                          await  Navigator.pushNamed(context, PageRoutes.readStory,arguments: ModelReadStory(
                              idChapter: e.id,
                              listChapter: viewModel.detailStory?.chapters,
                              story:  viewModel.detailStory,
                              index: index,
                              page: viewModel.checkNumberPage
                          ));
                        }else{
                        }
                        viewModel.getData();
                        viewModel.getListChapter();
                        viewModel.getHistoryReadBook();
                      }

                    },
                    child: IntrinsicHeight(
                      child: Container(
                        padding:  const EdgeInsets.only(top: 10,bottom: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Visibility(
                              visible:AppProvider.instance.token == null ? e.price != 0 : (e.price != 0 && e.isBuy == false),
                              child: Icon(
                                Icons.lock_outline_rounded,
                                size: 20,
                              ),
                            ),
                            Visibility(
                                visible:AppProvider.instance.token == null ? e.price != 0 : (e.price != 0 && e.isBuy == false),
                                child: const SizedBox(width: 4,)),
                            Expanded(
                              child: Text(
                                e.name ?? '',
                                textAlign: TextAlign.start,
                                style: const TextStyle(fontStyle: FontStyle.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Container(
                      padding:  const EdgeInsets.only(top: 10,bottom: 5),
                      child: Text(
                        e.createdAt == null ? '' : e.createdAt!.formatDate(),
                        // e.createdAt == null ? '' : e.createdAt!.formatDateVN(),
                        textAlign: TextAlign.center,
                        style:  const TextStyle(color: Colors.black38),
                      ),
                    ),
                  ),
                  IntrinsicHeight(
                    child: Container(
                      padding:  const EdgeInsets.only(top: 10,bottom: 5),
                      child: Text(
                        '${e.totalView}',
                        textAlign: TextAlign.center,
                        style:  const TextStyle(color: Colors.black38),
                      ),
                    ),
                  )
                ],
              );
            }).toList(),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () => viewModel.backPage(),
                  child: Icon(Icons.navigate_before_sharp,size: 25,color: viewModel.canBackPage ? null : colorGrey)),
              const SizedBox(width: 10,),
              Text('${viewModel.page+1}'),
              const SizedBox(width: 10,),
              InkWell(
                  onTap: () => viewModel.nextPage(),
                  child: Icon(Icons.navigate_next_sharp,size: 25,color: viewModel.canNextPage ? null : colorGrey,)),
            ],
          ),
        ) ,
      ],
    );
  }
}
