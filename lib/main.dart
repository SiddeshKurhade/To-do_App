import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "To-do List",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? title;
  String? description;
  String? date;

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<Map> todoList = [];

  List<Color> containerColor = [
    const Color.fromRGBO(250, 232, 232, 1),
    const Color.fromRGBO(232, 237, 250, 1),
    const Color.fromRGBO(250, 249, 232, 1),
    const Color.fromRGBO(250, 232, 250, 1),
  ];

  void openBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(
                  top: 20, left: 10, right: 10, bottom: 10),
              child: const Text(
                "Create To-Do",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Title",
                style: TextStyle(
                    color: Color.fromRGBO(2, 167, 177, 1), fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 5, left: 10, right: 10, bottom: 10),
              // padding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "Enter Title", border: OutlineInputBorder()),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Description",
                style: TextStyle(
                  color: Color.fromRGBO(2, 167, 177, 1),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 5, left: 10, right: 10, bottom: 10),
              // padding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: descController,
                decoration: const InputDecoration(
                    hintText: "Enter Description",
                    border: OutlineInputBorder()),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                "Date",
                style: TextStyle(
                    color: Color.fromRGBO(2, 167, 177, 1), fontSize: 16),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 5, left: 10, right: 10, bottom: 10),
              // padding: EdgeInsets.only(
              //     bottom: MediaQuery.of(context).viewInsets.bottom),
              child: TextField(
                controller: dateController,
                decoration: const InputDecoration(
                    hintText: "Enter Date", border: OutlineInputBorder()),
              ),
            ),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(
                    top: 5, left: 10, right: 10, bottom: 10),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(2, 167, 177, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              onTap: () {
                title = titleController.text.trim();
                description = descController.text.trim();
                date = dateController.text.trim();

                todoList.add({
                  "title": title,
                  "description": description,
                  "date": date,
                });

                titleController.clear();
                descController.clear();
                dateController.clear();
                setState(() {});
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(2, 167, 177, 1),
        title: const Text(
          "To-do list",
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
      ),
      body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(7),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              // width: MediaQuery.of(context).size.width,
              width: 330,
              height: 130,
              decoration: BoxDecoration(
                // color: const Color.fromRGBO(250, 232, 232, 1),
                // color: containerColor[index % 4],
                color: containerColor[index % containerColor.length],
                borderRadius: BorderRadius.circular(10),
              ),

              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        // color: Colors.amber,
                        margin: const EdgeInsets.all(13),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset("assets/images/profile.jpg"),
                        ),
                      ),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${todoList[index]["title"]}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text(
                                "${todoList[index]["description"]}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(84, 84, 84, 1)),
                              )
                            ]),
                      )
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        "${todoList[index]["date"]}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(84, 84, 84, 1)),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.edit_outlined,
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Icon(
                        Icons.delete_outlined,
                        color: Color.fromRGBO(0, 139, 148, 1),
                      ),
                    ],
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
