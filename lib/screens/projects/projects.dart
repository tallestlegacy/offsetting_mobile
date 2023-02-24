import 'package:flutter/material.dart';
import 'package:offsetting_mobile/screens/projects/project.dart';
import 'package:offsetting_mobile/utils/network.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Offsetting Projects")),
      body: FutureBuilder(
          future: getProjects(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  for (var project in snapshot.data)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProjectScreen(project: project)));
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        child: Wrap(
                          children: [
                            Hero(
                              tag: project["heroImageUrl"],
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(
                                  project["heroImageUrl"],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(project["title"]),
                              subtitle: Text(project["description"]),
                            ),
                          ],
                        ),
                      ),
                    )
                ],
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
