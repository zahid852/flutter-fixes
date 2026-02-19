import 'package:flutter/material.dart';
import 'package:flutter_fixes/listview_builder_optimization/listview_builder_without_findchildindexCallback.dart';
import 'listview_builder_optimization/listview_builder_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> fixes = [
    'ListView Builder without optimization',
    'LsistView Builder with optimization',
  ];

  void _openFix(int index) {
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ListViewBuilderScreenWithOutFindChildIndex(),
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const ListViewBuilderScreen()),
        );
        break;
      default:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: Text(fixes[index])),
              body: const Center(child: Text('Screen not implemented yet')),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: fixes.length,
        itemBuilder: (context, i) {
          return ListTile(
            title: Text(fixes[i]),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _openFix(i),
          );
        },
      ),
    );
  }
}
