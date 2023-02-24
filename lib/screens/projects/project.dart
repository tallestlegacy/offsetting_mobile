import 'package:flutter/material.dart';
import 'package:offsetting_mobile/components/map.dart';
import 'package:offsetting_mobile/widgets/sanity_text.dart';

class ProjectScreen extends StatelessWidget {
  var project;
  ProjectScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    push(Widget route) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => route));
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            stretch: true,
            expandedHeight: MediaQuery.of(context).size.height * .4,
            actions: [
              IconButton(
                onPressed: () {
                  push(OSMMap(lat: project["lat"], lon: project["lon"]));
                },
                icon: const Icon(Icons.map),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
              ],
              background: Hero(
                tag: project["heroImageUrl"],
                child: Image.network(
                  project["heroImageUrl"],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              ListView(
                padding: const EdgeInsets.all(16),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    project["title"],
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(project["description"]),
                    ),
                  ),
                  SanityText(json: project["story"]),
                ],
              )
            ],
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text("Fund Project"),
        icon: const Icon(Icons.savings_rounded),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}
