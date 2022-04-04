import 'package:flutter/material.dart';
import 'package:flutter_api_with_bloc/bloc_state/universities_state.dart';
import 'package:flutter_api_with_bloc/bloc_state/universities_block.dart';
import 'package:flutter_api_with_bloc/bloc_state/universities_events.dart';
import 'package:flutter_api_with_bloc/model/universities_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'domain_web_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  List<UniversitiesModel> universities = [];
  List<UniversitiesModel> _searchResult = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    loadUniversities();
    super.initState();
  }

  loadUniversities() async {
    context.read<UniversitiesBloc>().add(UniversitiesEvents.fetchUniversities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Universities"),
      ),
      body: Column(
        children: [
          buildSearchView(context),
          buildUniversitiesList(),
        ],
      ),
    );
  }

  Expanded buildUniversitiesList() {
    return Expanded(
      child: BlocBuilder<UniversitiesBloc, UniversitiesState>(
          builder: (BuildContext context, UniversitiesState state) {
        if (state is UniversitiesListErrorState) {
          final error = state.error;
          String message = '$error\nTap to Retry.';
          return Text(
            message,
          );
        }
        if (state is UniversitiesLoadedState) {
          universities = state.universities;
          return _list(universities);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  Container buildSearchView(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: ListTile(
            leading: const Icon(Icons.search),
            title: TextField(
              controller: controller,
              decoration: const InputDecoration(
                  hintText: 'Search', border: InputBorder.none),
              onChanged: onSearchTextChanged,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                controller.clear();
                onSearchTextChanged('');
              },
            ),
          ),
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    universities.forEach((userDetail) {
      if (userDetail.name!.contains(text) ||
          userDetail.domains![0]!.contains(text)) _searchResult.add(userDetail);
    });

    setState(() {});
  }

  Widget _list(List<UniversitiesModel> universities) {
    return _searchResult.isNotEmpty || controller.text.isNotEmpty
        ? searchResultList()
        : universitiesList(universities);
  }

  ListView universitiesList(List<UniversitiesModel> universities) {
    return ListView.builder(
      itemCount: universities.length,

      itemBuilder: (_, index) {
        UniversitiesModel universitiesObject = universities[index];
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DomainWebView(link: universitiesObject.webPages![0]),
                    ),
                  );
                },
                title: Text(
                  universitiesObject.name!,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                subtitle: Text(
                  universitiesObject.domains!.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle
                  ),
                  child: Center(child: Text(universitiesObject.name![0]),),
                ),
              ),
              Divider(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ],
          ),
        );
      },
    );
  }

  ListView searchResultList() {
    return ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (_, index) {
        UniversitiesModel universitiesObject = _searchResult[index];
        return Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                onTap:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DomainWebView(link: universitiesObject.webPages![0]),
                    ),
                  );
                },
                title: Text(
                  universitiesObject.name!,
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                subtitle: Text(
                  universitiesObject.domains!.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).textTheme.bodyText1!.color,
                  ),
                ),
                leading: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle
                  ),
                  child: Center(child: Text(universitiesObject.name![0]),),
                ),
              ),
              Divider(
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ],
          ),
        );
      },
    );
  }
}
