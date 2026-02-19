import 'dart:developer';
import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final DemoItem item;

  const ProjectCard({super.key, required this.item});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard>
    with AutomaticKeepAliveClientMixin {
  bool checked = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    log('disposing card for ${widget.item.id}');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    log('building card for ${widget.item.id}');

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              // Image.network takes a runtime URL, so it
              // cannot be const — but its static children can.
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  widget.item.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Container(width: 80, height: 80, color: Colors.grey[200]),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[200],
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),

                    // ─────────────────────────────────────
                    const SizedBox(height: 4),
                    Text(
                      widget.item.subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
              ),

              const Icon(Icons.chevron_right),
            ],
          ),
        ),
        Checkbox(
          value: checked,
          onChanged: (v) => setState(() => checked = v!),
        ),
      ],
    );
  }
}

class DemoItem {
  final int id;
  final String title;
  final String subtitle;
  final String imageUrl;

  const DemoItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  // ─────────────────────────────────────────────────────────
  @override
  int get hashCode => Object.hash(id, title, subtitle, imageUrl);

  DemoItem copyWith({
    int? id,
    String? title,
    String? subtitle,
    String? imageUrl,
  }) {
    return DemoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  String toString() => 'DemoItem(id: $id, title: $title, subtitle: $subtitle)';
}
