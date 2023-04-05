import 'package:flutter/material.dart';

void main() {
  print("1");
  runApp(
    const MaterialApp(
      home: BugRepro(),
    ),
  );
  print("2");
}

class BugRepro extends StatefulWidget {
  const BugRepro({Key? key}) : super(key: key);

  @override
  State<BugRepro> createState() => _BugReproState();
}

class _BugReproState extends State<BugRepro> with TickerProviderStateMixin {
  _Page _page = _Page.listViewVertical;

  @override
  Widget build(BuildContext context) {
    print("build()");
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildContent(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    late final String title;
    switch (_page) {
      case _Page.listViewVertical:
        title = "ListView (Vertical)";
        break;
      case _Page.listViewHorizontal:
        title = "ListView (Horizontal)";
        break;
    }

    return AppBar(title: Text(title));
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _page = _Page.listViewVertical;
                });
              },
              child: const Text("ListView (Vertical)"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _page = _Page.listViewHorizontal;
                });
              },
              child: const Text("ListView (Horizontal)"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_page) {
      case _Page.listViewVertical:
        return _buildListViewVertical();
      case _Page.listViewHorizontal:
        return _buildListViewHorizontal();
    }
  }

  Widget _buildListViewVertical() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 900 / 1700,
          child: Image.asset(
            "assets/test-image.jpeg",
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }

  Widget _buildListViewHorizontal() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 900 / 1700,
          child: Image.asset(
            "assets/test-image.jpeg",
            fit: BoxFit.fill,
          ),
        );
      },
    );
  }

  final gradient = const LinearGradient(
    colors: [Colors.blue, Colors.red],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

enum _Page {
  listViewVertical,
  listViewHorizontal,
}
