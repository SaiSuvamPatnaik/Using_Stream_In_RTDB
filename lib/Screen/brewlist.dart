import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:streaminrtdb/Screen/trial.dart';
class brewlist extends StatefulWidget {
  String neededsort;
  brewlist({
    this.neededsort
  });
  @override
  _brewlistState createState() => _brewlistState();
}

class _brewlistState extends State<brewlist> {
  DatabaseReference ref2 = FirebaseDatabase().reference().child("Stream");
  ScrollController _semicircleController = ScrollController();
  Query ref;
  String key,neededsugar,neededstrength;
  @override
  Widget build(BuildContext context) {
    print(widget.neededsort);
    if(widget.neededsort.length==0){
      ref = FirebaseDatabase().reference().child("Stream");
    }
    if(widget.neededsort.length>0){
      ref = FirebaseDatabase().reference().child("Stream").orderByChild("Sugar").equalTo(widget.neededsort);
    };
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snap) {

        if (snap.hasData && !snap.hasError && snap.data.snapshot.value != null) {

          Map data = snap.data.snapshot.value;
          List item = [];

          data.forEach((index, data) => item.add({"key": index, ...data}));


          return RawScrollbar(
            isAlwaysShown: false,
            thumbColor: Colors.redAccent,
            radius: Radius.circular(20),
            thickness: 5,
            child: ListView.builder(
              itemCount: item.length,
              itemBuilder: (context,index) {
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10,5,10,0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                            backgroundColor: Colors.brown[item[index]["Strength"]*100],
                            child: Text(item[index]["Strength"].toString())),
                          title: Text(item[index]["Name"]),
                          subtitle: Text(item[index]["Sugar"]) ,

                      ),
                    ),
                  ),
                  actions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.redAccent,
                      icon: Icons.delete,
                      onTap: (){
                        ref2.child(item[index]["Key"]).remove();
                      },
                    ),

                  ],
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.purple,
                      icon: Icons.delete,
                      onTap: (){
                        setState(() {
                          showModalBottomSheet(
                              context: context, builder: (builder) => openedit(item:item,index:index));
                        });

                      },
                    ),

                  ],

                );
              },
            ),
          );
        }
        else
          return Text("");
      },
    );
  }
  Widget openedit({List item, int index}) {
    return SingleChildScrollView(
      child: Container(
        height: 300,
        child: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(60,40,60,0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'How many sugar you want ??',
                      labelStyle: TextStyle(
                          fontSize:19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),),
                    style: TextStyle(fontSize: 19),
                    onChanged: (text2){
                      neededsugar=text2;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(60,0,60,0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Strength of sugar ??',
                      labelStyle: TextStyle(
                          fontSize:19,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),),
                    style: TextStyle(fontSize: 19),
                    onChanged: (text){
                      neededstrength=text;
                    },
                  ),
                ),

                SizedBox(height: 30,),

                Container(
                  height: 40.0,
                  width: 120,
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        if(neededstrength.isEmpty!=true && neededsugar.isEmpty!=true) {
                          Map<String,dynamic> update1 = {
                            "Sugar":neededsugar,
                            "Strength":int.parse(neededstrength)
                          };
                          ref2.child(item[index]["Key"]).update(update1);
                        }
                        else{
                          Fluttertoast.showToast(
                              msg: "Fill up both the field !!!",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 3,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }


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


              ],
            ),
          ],
        ),
      ),
    );
  }
}






















