import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:streaminrtdb/Screen/brewlistnew.dart';

import 'brewlist.dart';
class trialnew extends StatefulWidget {
  @override
  _trialnewState createState() => _trialnewState();
}

class _trialnewState extends State<trialnew> {
  String needed,neededname,neededstrength,key1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Trial New"),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: (builder) => bottompart());
                },
                icon: Icon(
                  Icons.settings,
                  size: 30,
                )),
            IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context, builder: (builder) => bottompart());
                },
                icon: Icon(
                  Icons.next_plan,
                  size: 30,
                )),
            SizedBox(width: 10,)
          ],
          centerTitle: true,
        ),
        body: brewlistnew());
  }
  Widget bottompart() {
    return SingleChildScrollView(
      child: Container(
        height: 350,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60,40,60,0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Change Your Name',
                      labelStyle: TextStyle(
                          fontSize:19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),),
                    style: TextStyle(fontSize: 19),
                    onChanged: (text2){
                      neededname=text2;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60,0,60,0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'How many Sugar do you need ??',
                      labelStyle: TextStyle(
                          fontSize:19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),),
                    style: TextStyle(fontSize: 19),
                    onChanged: (text){
                      needed=text;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60,0,60,0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Strength Of Sugar',
                      labelStyle: TextStyle(
                          fontSize:19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),),
                    style: TextStyle(fontSize: 19),
                    onChanged: (text3){
                      neededstrength=text3;
                    },
                  ),
                ),
                SizedBox(height: 10,),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(60,10,0,0),
                      child: Container(
                        height: 40.0,
                        width: 120,
                        child: Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("brew").doc("2").set({
                                "Name": "Sai Suvam"
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ADD DATA',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,),
                                ),

                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20,10,0,0),
                      child: Container(
                        height: 40.0,
                        width: 120,
                        child: Material(
                          color: Colors.transparent,
                          child: GestureDetector(
                            onTap: () {
                              var docRef = FirebaseFirestore.instance.collection("brews").doc("1");
                              docRef.get().then((value) => print(value));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'DELETE DATA',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,),
                                ),

                              ],
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black,
                                style: BorderStyle.solid,
                                width: 1.0),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }

}
