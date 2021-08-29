import 'package:flutter/material.dart';
import 'package:kteen_app/list_article_page.dart';
import 'package:kteen_app/models/YouthWelfareService.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<YouthWelfareService>> _youthWelfareServiceFuture;
  List<YouthWelfareService> _youthWelfareServiceList = [];
  List<String> _youthWelfareServiceTitleList = [];

  @override
  void initState() {
    super.initState();
    _youthWelfareServiceFuture = readYouthWelfareService().then((value) {
      value.forEach((element) {
        _youthWelfareServiceList.add(element);
        _youthWelfareServiceTitleList.add(element.TITLE);
      });

      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      title: Text(
        '청소년 복지 목록',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
            showSearch(context: context, delegate:Search(_youthWelfareServiceList, _youthWelfareServiceTitleList));
          },
        ),
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              FutureBuilder<List<YouthWelfareService>>(
                future: _youthWelfareServiceFuture,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2.0,
                          child: ListTile(
                            title: Text(snapshot.data[index].TITLE),
                            trailing: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => ListArticlePage(data: snapshot.data[index]),),
                                );
                              },
                            ),
                          ),
                        );
                      }
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;
  int selectedResultIndex;

  @override
  Widget buildResults(BuildContext context) {
    return ListArticlePage(data: dataList[selectedResultIndex]);
  }

  final List<YouthWelfareService> dataList;
  final List<String> searchList;

  Search(this.dataList, this.searchList);

  List<String> recentList = [];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    query.isEmpty ? suggestionList = recentList : suggestionList.addAll(
        searchList.where((element) => element.contains(query),)
    );

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            suggestionList[index],
          ),
          leading: query.isEmpty ? Icon(Icons.access_time) : SizedBox(),
          onTap: () {
            selectedResult = suggestionList[index];
            selectedResultIndex = searchList.indexOf(selectedResult);

            showResults(context);
          },
        );
      },
    );
  }
}