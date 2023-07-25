import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_fyp_impas/Controller/Department/DepartmentController.dart';
import 'package:project_fyp_impas/Views/SubDepartment/Subdepartments.dart';
import 'package:project_fyp_impas/Widgets/MyDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_decoration/dotted_decoration.dart';

class Department extends StatefulWidget {
  const Department({Key? key}) : super(key: key);

  @override
  State<Department> createState() => _DepartmentState();
}

class _DepartmentState extends State<Department> {
  @override
  Widget build(BuildContext context) {
    final dashboardController = Get.put(DepartmentController());
    final fireStore = FirebaseFirestore.instance;
    final auth = FirebaseAuth.instance;

    return SafeArea(
      child: Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.brown),
          title: Text(
            'Department',
            style: TextStyle(color: Colors.brown),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    decoration: DottedDecoration(
                        shape: Shape.box,
                        color: Colors.brown,
                        strokeWidth: 2,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            dashboardController.createDialog(context);
                          },
                          child: Text(
                            'Create Department',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.brown, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(thickness: 2, color: Colors.brown),
              Container(
                // height: 200,
                child: StreamBuilder(
                  stream: fireStore
                      .collection('Departments')
                      .orderBy('Department_Name')
                      .where('Company_Id', isEqualTo: auth.currentUser!.uid)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data!.docs[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(SubDepartments(data: data),
                                    transition: Transition.rightToLeft);
                              },
                              child: Material(
                                color: Colors.brown.shade400,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20))),
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.brown,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(20),
                                        bottomRight: Radius.circular(20)),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 14.0, top: 14),
                                            child: Text(
                                              data['Department_Name'] ?? "",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 26,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Flexible(
                                            child: Align(
                                              alignment: Alignment(1.05, 0),
                                              child: PopupMenuButton(
                                                  icon: Icon(
                                                    Icons.more_vert,
                                                    color: Colors.white,
                                                  ),
                                                  itemBuilder: (context) {
                                                    return [
                                                      PopupMenuItem<int>(
                                                        value: 0,
                                                        child: Text("Delete"),
                                                      ),
                                                    ];
                                                  },
                                                  onSelected: (value) {
                                                    if (value == 0) {
                                                      showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return CupertinoAlertDialog(
                                                              title: const Text(
                                                                  'Delete'),
                                                              content: Text(
                                                                  "Deleting Department will delete all your data saved in it"),
                                                              actions: <Widget>[
                                                                CupertinoDialogAction(
                                                                  onPressed:
                                                                      () async {
                                                                    await fireStore
                                                                        .collection(
                                                                            'Departments')
                                                                        .doc(data
                                                                            .id)
                                                                        .collection(
                                                                            'Sub-Department')
                                                                        .get()
                                                                        .then(
                                                                            (snapshot) {
                                                                      for (DocumentSnapshot ds
                                                                          in snapshot
                                                                              .docs) {
                                                                        ds.reference
                                                                            .delete();
                                                                      }
                                                                    });
                                                                    await fireStore
                                                                        .collection(
                                                                            'Departments')
                                                                        .doc(data
                                                                            .id)
                                                                        .delete()
                                                                        .catchError(
                                                                            (e) {
                                                                      Get.snackbar(
                                                                          'Error',
                                                                          e.toString());
                                                                    }).then((value) =>
                                                                            Navigator.of(context).pop());
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'Yes'),
                                                                ),
                                                                CupertinoDialogAction(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        "No");
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                          'No'),
                                                                ),
                                                              ],
                                                            );
                                                          });
                                                    }
                                                  }),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 14.0, top: 14),
                                        child: Text(
                                          'Department Type : ' +
                                              data['Department_Type'],
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 14.0, top: 14),
                                        child: Text(
                                            'Departments Head : ' +
                                                data['Head_of_Department'],
                                            style: TextStyle(
                                              color: Colors.white,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
