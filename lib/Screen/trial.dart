import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streaminrtdb/Screen/brewlist.dart';

class trial extends StatefulWidget {
  @override
  _trialState createState() => _trialState();
}

class _trialState extends State<trial> {
  String needed,neededname,neededstrength,neededsort="0",key1;
  int c=0,sort;
  DatabaseReference ref = FirebaseDatabase().reference().child("Stream");
  DatabaseReference ref10;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    neededsort="";
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Trial"),
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

          SizedBox(width: 10,)
        ],
        centerTitle: true,
      ),
      body: brewlist(neededsort:neededsort));
  }
  Widget bottompart() {
    return SingleChildScrollView(
      child: Container(
        height: 450,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(60,0,60,0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Sorting of Sugar',
                      labelStyle: TextStyle(
                          fontSize:19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),),
                    style: TextStyle(fontSize: 19),
                    onChanged: (text5){
                      neededsort=text5;

                    },
                  ),
                ),
                SizedBox(height: 30,),

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

                              setState(() {
                                ref10 = ref.push();
                                key1 = ref10.key;
                                Map datas = {
                                  "Name":neededname,
                                  "Sugar":needed,
                                  "Strength":int.parse(neededstrength),
                                  "Key":key1

                                };

                                ref.once().then((DataSnapshot snapshot) {
                                  List item = [];
                                  if (snapshot.value==null){
                                    Map datas1 = {
                                      "Name":"Sai Suvam",
                                      "Sugar":"One",
                                      "Strength":int.parse("1"),
                                      "Key":key1

                                    };
                                    ref10.set(datas1);
                                  }
                                  snapshot.value.forEach((index, data) => item.add({"key": index, ...data}));
                                  for (int i=0;i<item.length;i++){
                                    if (neededname==item[i]["Name"]){
                                      ref.child(item[i]["key"]).update({"Sugar":needed});
                                      ref.child(item[i]["key"]).update({"Strength":int.parse(neededstrength)});
                                    }
                                    else{
                                      c++;
                                    }
                                  }
                                  if(c==item.length){
                                    ref10.set(datas);
                                  }
                                  c=0;
                                });

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
                              setState(() {
                                brewlist(neededsort: neededsort);

                              });

                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SORT DATA',
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
