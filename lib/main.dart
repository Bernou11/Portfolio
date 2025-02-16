import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mds_flutter/services/github_service.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  await dotenv.load(fileName: "assets/.env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'My portfolio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GitHubService gitHubService = GitHubService();
  Map<String, bool> buttonsStates = {
    'displayJavaProjects' : false,
    'displayNextProjects' : false,
    'displayReactProjects' : false,
    'displayNodejsProjects' : false,
    'displayFlutterProjects' : false,
    'displayCProjects': false,
    'displayCppProjects': false,
    'displayC#Projects': false,
    'displayPythonProjects': false
  };
  late Map<String, List<String>> sortedProjects;

  // Fetch projects from GitHub and store them in the corresponding lists
  Future<void> fetchProjects() async {
    final repos = await gitHubService.getReposSortedByLanguage();

    if (repos!.isNotEmpty) {
      setState(() {
        sortedProjects = repos;
      });
    } else {
      print("Error fetching repositories");
    }
  }
  @override
  void initState() {
    super.initState();
    fetchProjects();
  }
  final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    foregroundColor: Colors.black,
    shape: LinearBorder(),
    fixedSize: Size.fromWidth(70),
    textStyle: TextStyle(fontSize: 10)
  );
  void _launchURL(String language) async {
    List<String>? projects = sortedProjects[language.toLowerCase()];
    if (projects != null && projects.isNotEmpty) {
      for (String project in projects) {
        Uri uri = Uri.parse("https://github.com/Bernou11/$project");
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch $uri';
        }
      }
    }
  }
  List<ElevatedButton>? _displayButtonsAfterClick(String language) {
    List<String>? projects = sortedProjects[language.toLowerCase()];
    List<ElevatedButton> projectButtons = [];

    if (projects != null && projects.isNotEmpty) {
      for (String project in projects) {
        projectButtons.add(
          ElevatedButton(
            onPressed: () => _launchURL(language),
            child: Text(project),
          ),
        );
      }
      return projectButtons;
    } else {
      return null;
    }
  }


  Text text() {
    return Text(
        style: TextStyle(color: Colors.blueGrey),
        "Projets : "
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text(widget.title)),
      ),
      body: Padding(
        padding: EdgeInsets.only(top : 10),
        child: Center(
          child: Column(
              spacing: 20,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'
                  ),
                  radius: 50,
                ),
                Text(
                    style: TextStyle(color: Colors.blueGrey),
                    "Mes compétences : "
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      style: elevatedButtonStyle,
                      onPressed: () {
                        setState(() {
                          buttonsStates.updateAll((key, value) => false);

                          buttonsStates['displayJavaProjects'] = true;
                        });
                      },
                      child: Text(
                          style: TextStyle(
                              fontSize: 7.4, fontWeight: FontWeight.bold
                          ),
                          "Java")
                    ),
                    ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          setState(() {
                            buttonsStates.updateAll((key, value) => false);

                            buttonsStates['displayNextProjects'] = true;
                          });
                        },
                        child: Text(
                            style: TextStyle(
                              fontSize: 7.4, fontWeight: FontWeight.bold
                            ),
                            "Next")
                    ),
                    ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          setState(() {
                            buttonsStates.updateAll((key, value) => false);

                            buttonsStates['displayReactProjects'] = true;
                          });
                        },
                        child: Text(style: TextStyle(
                          fontSize: 7.4, fontWeight: FontWeight.bold
                        ),
                            "React")
                    ),
                    ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          setState(() {
                            buttonsStates.updateAll((key, value) => false);

                            buttonsStates['displayNodeProjects'] = true;
                          });
                        },
                        child: Text(style: TextStyle(
                          fontSize: 7.4, fontWeight: FontWeight.bold
                        ),
                            "Node")
                    ),
                    ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          setState(() {
                            buttonsStates.updateAll((key, value) => false);

                            buttonsStates['displayFlutterProjects'] = true;
                          });
                        },
                        child: Text(style: TextStyle(
                            fontSize: 7.4, fontWeight: FontWeight.bold
                        ),
                            "Flutter")
                    ),
                    ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          setState(() {
                            buttonsStates.updateAll((key, value) => false);

                            buttonsStates['displayCProjects'] = true;
                          });
                        },
                        child: Text(style: TextStyle(
                            fontSize: 7.4, fontWeight: FontWeight.bold
                        ),
                            "C")
                    ),
                    ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          setState(() {
                            buttonsStates.updateAll((key, value) => false);

                            buttonsStates['displayCppProjects'] = true;
                          });
                        },
                        child: Text(style: TextStyle(
                            fontSize: 7.4, fontWeight: FontWeight.bold
                        ),
                            "C++")
                    ),
                    ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          setState(() {
                            buttonsStates.updateAll((key, value) => false);

                            buttonsStates['displayC#Projects'] = true;
                          });
                        },
                        child: Text(style: TextStyle(
                            fontSize: 7.4, fontWeight: FontWeight.bold
                        ),
                            "C#")
                    ),
                    ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {
                          setState(() {
                            buttonsStates.updateAll((key, value) => false);

                            buttonsStates['displayPythonProjects'] = true;
                          });
                        },
                        child: Text(style: TextStyle(
                            fontSize: 6.9, fontWeight: FontWeight.bold
                        ),
                            "Python")
                    )
                  ],
                ),
                if(buttonsStates['displayJavaProjects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("java")?.isNotEmpty ?? false
                  ? _displayButtonsAfterClick("java") : [
                    Text("Pas de projet en java pour le moment")
                  ]
                ],
                if(buttonsStates['displayNextProjects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("next")?.isNotEmpty ?? false
                      ? _displayButtonsAfterClick("next") : [
                    Text("Pas de projet en next pour le moment")
                  ]
                ],
                if(buttonsStates['displayReactProjects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("react")?.isNotEmpty ?? false
                      ? _displayButtonsAfterClick("react") : [
                    Text("Pas de projet en react pour le moment")
                  ]
                ],
                if(buttonsStates['displayNodeProjects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("node")?.isNotEmpty ?? false
                      ? _displayButtonsAfterClick("node") : [
                    Text("Pas de projet en node pour le moment")
                  ]
                ],
                if(buttonsStates['displayFlutterProjects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("flutter")?.isNotEmpty ?? false
                      ? _displayButtonsAfterClick("flutter") : [
                    Text("Pas de projet en flutter pour le moment")
                  ]
                ],
                if(buttonsStates['displayCProjects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("c")?.isNotEmpty ?? false
                      ? _displayButtonsAfterClick("c") : [
                    Text("Pas de projet en C pour le moment")
                  ]
                ],
                if(buttonsStates['displayCppProjects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("cpp")?.isNotEmpty ?? false
                      ? _displayButtonsAfterClick("cpp") : [
                    Text("Pas de projet en C++ pour le moment")
                  ]
                ],
                if(buttonsStates['displayC#Projects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("c#")?.isNotEmpty ?? false
                      ? _displayButtonsAfterClick("c#") : [
                    Text("Pas de projet en C# pour le moment")
                  ]
                ],
                if(buttonsStates['displayPythonProjects'] == true) ...[
                  text(),
                  ...?_displayButtonsAfterClick("python")?.isNotEmpty ?? false
                      ? _displayButtonsAfterClick("python") : [
                    Text("Pas de projet en python pour le moment")
                  ]
                ],
              ]
          ),
        )
      )
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
