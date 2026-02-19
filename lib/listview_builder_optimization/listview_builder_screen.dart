import 'package:flutter/material.dart';
import 'project_card.dart';

class ListViewBuilderScreen extends StatefulWidget {
  const ListViewBuilderScreen({super.key});

  @override
  State<ListViewBuilderScreen> createState() => _ListViewBuilderScreenState();
}

class _ListViewBuilderScreenState extends State<ListViewBuilderScreen> {
  late List<DemoItem> items;

  @override
  void initState() {
    super.initState();
    items = List<DemoItem>.generate(
      1000,
      (i) => DemoItem(
        id: i + 1,
        title: 'Item ${i + 1}',
        subtitle: 'Subtitle for item ${i + 1}',
        imageUrl: 'https://picsum.photos/seed/list_$i/80/80',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView.builder with findChildIndexCallback Demo'),
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: ListView.builder(
          itemCount: items.length,

          addAutomaticKeepAlives: true,
          findChildIndexCallback: (key) {
            final valueKey = key as ValueKey;
            final id = valueKey.value as int;
            return items.indexWhere((item) => item.id == id);
          },
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(
              background: Container(color: Colors.red),
              key: ValueKey(item.id),
              onDismissed: (direction) {
                setState(() {
                  items.removeAt(index);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('State survived!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: ProjectCard(item: item),
            );
          },
        ),
      ),
    );
  }
}
