import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'node.dart';

List<Node> decisionMap = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // POPULATE LIST CODE
  String csv = "assets/my_map.csv"; // Ensure the correct path
  String fileData = await rootBundle.loadString(csv);
  print("CSV Data Loaded: $fileData");  // Debug print

  List<String> rows = fileData.split("\n");
  for (int i = 0; i < rows.length; i++) {
    // selects an item from row and places
    String row = rows[i];
    List<String> itemInRow = row.split(",");
    print("Row $i: $itemInRow");  // Debug print

    if (itemInRow.length >= 6) {
      Node node = Node(
          int.parse(itemInRow[0]),
          int.parse(itemInRow[1]),
          int.parse(itemInRow[2]),
          int.parse(itemInRow[3]),
          itemInRow[4],
          itemInRow[5]);
      decisionMap.add(node);
    } else {
      print("Row $i does not have enough columns: $row");
    }
  }

  runApp(
    const MaterialApp(
      home: MyFlutterApp(),
    ),
  );
}

class MyFlutterApp extends StatefulWidget {
  const MyFlutterApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyFlutterState();
  }
}

class MyFlutterState extends State<MyFlutterApp> {
  String image = "";
  late int iD;
  late int yesID;
  late int noID;
  late int maybeID;
  String question = "";

  @override
  void initState() {
    super.initState();
    // PLACE CODE HERE TO INITIALISE SERVER OBJECTS

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // PLACE CODE HERE YOU WANT TO EXECUTE IMMEDIATELY AFTER
      // THE UI IS BUILT
      setState(() {
        if (decisionMap.isNotEmpty) {
          Node current = decisionMap.first;
          iD = current.iD;
          yesID = current.yesID;
          noID = current.noID;
          maybeID = current.maybeID;
          question = current.question;
          image = current.image;
          print("Initial node $current");
        }
        else {
          print("Decision map is empty");
        }
      });
    });
  }

  void yesHandler() {
    setState(() {
      for (Node nextNode in decisionMap) {
        if (nextNode.iD == yesID) {
          iD = nextNode.iD;
          yesID = nextNode.yesID;
          noID = nextNode.noID;
          maybeID = nextNode.maybeID;
          question = nextNode.question;
          image = nextNode.image;
          break;
        }
      }
    });
  }

  void noHandler() {
    setState(() {
      for (Node nextNode in decisionMap) {
        if (nextNode.iD == noID) {
          iD = nextNode.iD;
          yesID = nextNode.yesID;
          noID = nextNode.noID;
          maybeID = nextNode.maybeID;
          question = nextNode.question;
          image = nextNode.image;
          break;
        }
      }
    });
  }

  void maybeHandler() {
    setState(() {
      for (Node nextNode in decisionMap) {
        if (nextNode.iD == maybeID) {
          iD = nextNode.iD;
          yesID = nextNode.yesID;
          noID = nextNode.noID;
          maybeID = nextNode.maybeID;
          question = nextNode.question;
          image = nextNode.image;
          break;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd7b516),
      body: Align(
        alignment: Alignment.center,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Align(
                alignment: const Alignment(-0.5, 0.0),
                child: MaterialButton(
                  onPressed: () {
                    yesHandler();
                  },
                  color: const Color(0xff019fa1),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  textColor: const Color(0xffe8e5e5),
                  height: 40,
                  minWidth: 140,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "YES",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.0),
                child: MaterialButton(
                  onPressed: () {
                    noHandler();
                  },
                  color: const Color(0xff019fa1),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 40,
                  minWidth: 140,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "NO",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.5, 0.0),
                child: MaterialButton(
                  onPressed: () {
                    maybeHandler();
                  },
                  color: const Color(0xff019fa1),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  textColor: const Color(0xfffffdfd),
                  height: 40,
                  minWidth: 140,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: const Text(
                    "MAYBE",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, -0.3),
                child: Text(
                  question,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 56,
                    color: Color(0xffffffff),
                  ),
                ),
              ),
              Align(
                alignment: const Alignment(0.0, 0.5),
                child: image.isNotEmpty
                    ? Image.asset(
                  image,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    ); // end of scaffold
  }
}