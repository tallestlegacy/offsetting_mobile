import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offsetting_mobile/screens/projects/project.dart';
import 'package:offsetting_mobile/utils/store.dart';

class Projects extends StatelessWidget {
  const Projects({super.key});

  @override
  Widget build(BuildContext context) {
    var projectsStore = Get.put(ProjectsStore());
    return Obx(
      () => Scaffold(
        appBar: AppBar(title: const Text("Offsetting Projects")),
        body: projectsStore.projects.isNotEmpty
            ? ListView(
                children: [
                  for (var project in projectsStore.projects)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) => ProjectScreen(project: project)));
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
              )
            // By default, show a loading spinner.
            : const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
