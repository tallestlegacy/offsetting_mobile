import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:offsetting_mobile/components/map.dart';
import 'package:offsetting_mobile/widgets/sanity_text.dart';
import 'package:sliver_app_bar_title/sliver_app_bar_title.dart';

import '../utils/strings.dart';

class ProjectScreen extends StatelessWidget {
  var project;
  ProjectScreen({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    push(Widget route) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => route));
    }

    final globalKey = GlobalKey();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            pinned: true,
            stretch: true,
            expandedHeight: MediaQuery.of(context).size.height * .4,
            actions: [
              IconButton(
                onPressed: () {
                  push(
                    OSMMap(
                      lat: project["lat"],
                      lon: project["lon"],
                      locationName: project["locationName"],
                    ),
                  );
                },
                icon: const Icon(Icons.map),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: SliverAppBarTitle(
                targetWidgetKey: globalKey,
                duration: const Duration(milliseconds: 100),
                child: Text(
                  project["title"],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              stretchModes: const [StretchMode.zoomBackground],
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
                    key: globalKey,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Summary(project: project),
                  const Divider(),
                  ProjectReport(report: project["report"]),
                  const SizedBox(height: 100),
                  Comments(project: project),
                  const SizedBox(height: 100),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}

class Summary extends StatelessWidget {
  final project;
  const Summary({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    push(Widget route) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => route));
    }

    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.money_rounded),
          title: const Text("Required Funds"),
          subtitle: Text(currencyFormat.format(project["requiredFunds"])),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.money_rounded),
          title: const Text("Allocated Funds"),
          subtitle: const Text("\$ 00.00"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.money_rounded),
          title: const Text("Consumption"),
          subtitle: const Text("\$ 00.00"),
          onTap: () {},
        ),
        Card(
          margin: const EdgeInsets.symmetric(vertical: 16.0),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(project["description"]),
              subtitle: TextButton(
                onPressed: () => push(
                  Story(
                    title: project["title"],
                    text: project["story"],
                  ),
                ),
                child: const Text("Learn more"),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Story extends StatelessWidget {
  final text;
  final String title;
  const Story({super.key, required this.text, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SanityText(json: text),
        ],
      ),
    );
  }
}

class ProjectReport extends StatelessWidget {
  final report;
  const ProjectReport({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: Wrap(
        spacing: 20,
        direction: Axis.vertical,
        children: [
          Text(
            "Project Report",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SanityText(json: report),
        ],
      ),
    );
  }
}

class Comments extends StatelessWidget {
  final project;

  Comments({super.key, required this.project});

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("comments").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }

            if (snapshot.hasData) {
              List comments = [];

              for (var document in snapshot.data!.docs) {
                Map<String, dynamic> data = document.data();
                if (data["projectId"] == project["_id"]) {
                  comments.add(data);
                }
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Comments",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Column(children: [
                    for (var comment in comments)
                      ListTile(
                        leading: const Icon(Icons.message_rounded),
                        title: Text(comment["message"]),
                        subtitle: Text(comment["userName"]),
                      )
                  ])
                ],
              );
            }
            return const Text("...");
          },
        ),
        TextField(
          controller: commentController,
          decoration: const InputDecoration(
            label: Text("Add your comment"),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection("comments").add({
                "userId": FirebaseAuth.instance.currentUser!.uid,
                "userName": FirebaseAuth.instance.currentUser!.displayName,
                "projectId": project["_id"],
                "message": commentController.value.text,
              });
            },
            child: const Text("Save"),
          ),
        ),
      ],
    );
  }
}
