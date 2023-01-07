import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:ns_read_story/page_routes.dart';
import 'package:ns_read_story/shared/cache_image_network.dart';
import 'package:ns_read_story/ui/main/home/category/list_story_by_cate/item_story.dart';
import 'package:ns_read_story/ui/main/home/search_story/search_viewmodel.dart';
import 'package:ns_read_story/ultils/constants.dart';
import 'package:ns_read_story/ultils/extensions.dart';
import 'package:provider/provider.dart';


class SearchStory extends StatefulWidget {
  const SearchStory({Key? key}) : super(key: key);

  @override
  _SearchStoryState createState() => _SearchStoryState();
}

class _SearchStoryState extends State<SearchStory> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SearchViewModel>();
    return SafeArea(
      child: Scaffold(
          backgroundColor:colorBg,
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Stack(
                    children: [
                       Stack(
                         children: [
                           Padding(
                             padding: const EdgeInsets.only(left: 35),
                             child: Container(
                               height: 45,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 border: Border.all(color: colorGrey)
                               ),
                               child: Row(
                                 children: const [
                                  sizeBox10,
                                   Icon(
                                     Icons.search,
                                     color: colorGrey,),
                                 ],
                               ),
                             ),
                           ),
                           SizedBox(
                             height: 45,
                             child: TypeAheadField(
                               textFieldConfiguration: TextFieldConfiguration(
                                   autofocus: false,
                                   controller: viewModel.edtSearch,
                                   style: DefaultTextStyle.of(context).style.copyWith(
                                       fontStyle: FontStyle.italic
                                   ),
                                   decoration:    InputDecoration(
                                     hintText: "Tìm kiếm truyện, tác giả hoặc ...",
                                       border:const OutlineInputBorder(),
                                       enabledBorder: InputBorder.none,
                                       disabledBorder: InputBorder.none,
                                       focusedBorder: InputBorder.none,
                                       suffixIcon: InkWell(
                                         onTap: () => viewModel.clearText(),
                                         child: const Icon(
                                           Icons.close,
                                           color: colorGrey,
                                         ),
                                       ),
                                     contentPadding: const EdgeInsets.only(left: 80,top: 13)
                                   )
                               ),
                               suggestionsCallback: (pattern) async {
                                   return await viewModel.searchStorySuggest(pattern) ;
                               },
                               itemBuilder: (context,ModelSearch suggestion) {
                                 if(suggestion.type=='story'){
                                   return ItemStoryView(
                                       detailStory: suggestion.story!,
                                       isView: true);
                                 }else{
                                   return itemUser(suggestion);
                                 }
                               },
                               noItemsFoundBuilder: (_){
                                 return const Padding(
                                   padding: EdgeInsets.all(15.0),
                                   child: Text("Không tìm thấy kết quả",style: TextStyle(
                                     color: Colors.black54
                                   ),),
                                 );
                               },
                               loadingBuilder:(_){
                                 return Center(child:  CircularProgressIndicator.adaptive(valueColor: AlwaysStoppedAnimation<Color>(colorGrey.withOpacity(0.5))));
                               },
                               keepSuggestionsOnLoading: false,
                               hideOnLoading: false,
                               hideSuggestionsOnKeyboardHide: false,
                               hideOnEmpty: false,
                               onSuggestionSelected: (ModelSearch suggestion) async {
                                 viewModel.modelSearch = suggestion;
                                 if(viewModel.modelSearch?.type == 'story'){
                                   Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.detailStory,arguments:viewModel.modelSearch?.story );
                                 }else{
                                   await Navigator.pushNamed(context, PageRoutes.detailUser,arguments: viewModel.modelSearch?.id);
                                 }

                               },
                             ),
                           )
                         ],
                       ),
                      Positioned(
                        top: 12,
                        left: 5,
                        child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back_sharp,
                          color: colorGrey,
                        ),
                      ),)
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget itemUser(ModelSearch search) {
    return  InkWell(
      onTap: () {
        navigatorToUserPage(context, search.id ?? '');
        // if(search.id == AppProvider.instance.user.id){
        //   Navigator.of(context,rootNavigator: true).pushNamed(PageRoutes.personalPage, arguments: search.id);
        // }else{
        //   Navigator.pushNamed(context, PageRoutes.detailUser,arguments: search.id);
        // }
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          children: [
           (search.avt != null && search.avt != '' )? CachedNetworkImageCustom(
              url: search.avt ?? '',
              width: 50,
              height: 50,
              boxFit: BoxFit.cover,
              borderRadius: 150,
            ) :  ClipRRect(
             borderRadius: BorderRadius.circular(150),
              child: Image.asset('assets/logo.png',
               fit: BoxFit.cover,
               width: 50,
               height: 50,
           ),
            ),
            sizeBox10,
            Expanded(child: Text(search.title ?? '',style: textTitleBlack,))
          ],
        ),
      ),
    );
  }
}
