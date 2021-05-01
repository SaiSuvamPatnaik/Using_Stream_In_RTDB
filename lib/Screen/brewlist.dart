import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  ScrollController _semicircleController = ScrollController();
  Query ref;
  String key;
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
                return Padding(
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
}






















