import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'story.dart';
import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      theme: CupertinoThemeData(
        primaryColor: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Api api = Api();
  late Future<Story> futureStory;
  late Future<List> futureTopNew;
  late Future<List<Story>> futureTopNewStories;

  @override
  void initState() {
    super.initState();
    futureTopNew = api.fetchTopNew();
    futureTopNewStories = api.fetchTopNew().then((List results) {
      List<int> res = results.sublist(0, 40) as List<int>;
      return api.enrichStories(res);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(middle: Text('Home')),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: FutureBuilder<List<Story>>(
              future: futureTopNewStories,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 50,
                          child:
                              Center(child: Text(snapshot.data![index].title)),
                        );
                      });
                } else if (snapshot.hasError) {
                  print(snapshot.toString);
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ));
  }
}
