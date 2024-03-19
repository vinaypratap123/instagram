import 'package:flutter/material.dart';
import 'package:instagram/data/response/status.dart';
import 'package:instagram/provider/search_view_provider.dart';
import 'package:instagram/screens/user_profile_screen.dart';
import 'package:instagram/ui_helper/ui_helper.dart';
import 'package:instagram/utils/app_color.dart';
import 'package:instagram/utils/app_string.dart';
import 'package:instagram/widgets/custom_text_field.dart';
import 'package:instagram/widgets/rectangle_button.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
// ****************************** SEARCH CONTROLLER **********************************
  final TextEditingController _searchController = TextEditingController();
  SearchViewModel searchViewModel = SearchViewModel();
// ****************************** DISPOSE SEARCH CONTROLLER **********************************
  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
    searchViewModel.resetSearchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
// ****************************** APP BAR **********************************
      appBar: AppBar(
        title: const Text(AppString.search),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        child: Column(
          children: [
// ****************************** SEARCH TEXT FIELD **********************************
            CustomTextField(
                controller: _searchController,
                labelText: AppString.search,
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColor.primaryBlackColor,
                )),
            const SizedBox(
              height: 20,
            ),
// ****************************** SEARCH BUTTON FIELD **********************************
            RectangleButton(
                btnName: AppString.search,
                btnCallBack: () async {
                  String data = _searchController.text.toString();
                  if (data.isEmpty || data == "") {
                    UiHelper.showAlertDialog(
                        context,
                        "Invalid Name or User Name",
                        "Please Enter The Valid Name or User Name.");
                  } else {
                    SearchViewModel searchViewModel =
                        Provider.of<SearchViewModel>(context, listen: false);

                    await searchViewModel.fetchSearchList(data, context);
                  }
                }),
            Expanded(
              child: Consumer<SearchViewModel>(
                builder: (context, searchViewModel, child) {
                  if (searchViewModel.searchList.status == Status.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (searchViewModel.searchList.status ==
                      Status.error) {
                    return Center(
                        child: Text(
                            "Error: ${searchViewModel.searchList.message}"));
                  } else if (searchViewModel.searchList.status ==
                      Status.complete) {
                       
                    if (searchViewModel.searchList.data!.data.length == 0 )  {
                      return const Center(child: Text(AppString.noResultFound));
                    } else {
                       return ListView.builder(
                        itemCount: searchViewModel.searchList.data!.data.length,
                        itemBuilder: (context, index) {
                          final result =
                              searchViewModel.searchList.data!.data[index];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UserProfileScreen(
                                          userId: result.id.toString())));
                            },
                            child: ListTile(
                              leading: const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              title: Text(result.name),
                              subtitle: Text(result.userName),
                            ),
                          );
                        },
                      );
                     
                    }
                  } else {
                    return const Center(child: Text(AppString.searchForUsers));
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
