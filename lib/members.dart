import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class members extends StatelessWidget{
  var join_code;
  var prsn=[];
  var prfl_inf=[];
  int pr=0,prf=0;
  var d=0.0;
  int s=0;
  var name;
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: 30),
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection('Profile').snapshots(), builder: (context,snapshots){
          if(snapshots.hasData)
            {
              final res=snapshots.data!.docs.toList();
              for (var r in res)
                {
                  if(r['uid']==FirebaseAuth.instance.currentUser!.uid)
                    {
                      join_code=r['code'];
                      name=r['name1'];
                      break;

                    }
                }
              pr=0;prf=0;
              for(var r in res)
                {
                  if(r['code']==join_code )
                    {
                      prfl_inf.insert(0, r['name1']);
                      prfl_inf.insert(1, r['role']);
                      prfl_inf.insert(2, r['roll']);
                      prfl_inf.insert(3, r['email']);
                      prfl_inf.insert(4, r['imageLink']);
                     for(int i=0;i<5;i++)
                       {

                         prsn.insert(pr, prfl_inf[i]);
                         pr++;
                       }


                    }
                }
               d=(pr)/5;
              s=d.toInt();

            }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
              itemCount: s,

              itemBuilder: (BuildContext context,int index){
                print(index);



            if (prsn[index*5]!=name && prsn[(index*5)+1]=="General member") {
              return Container(
              height: (190/872)*screenH,

              child: Card(
                elevation: 10,
                margin: EdgeInsets.fromLTRB(10, 5, 10, 5),

                child: Column(
                  children: [
                    SizedBox.fromSize(size: Size(0,20),),
                    Stack(
                      children: [

                        CircleAvatar(
                          radius: 31,
                          backgroundImage: CachedNetworkImageProvider(prsn[(index*5)+4]),
                        )
                      ],


                    ),
                    Text("Name: "+prsn[index*5]),
                    Text("Role: "+prsn[(index*5)+1]),
                    Text("roll: "+prsn[(index*5)+2]),
                    Text("Email: "+prsn[(index*5)+3]),
                  ],
                ),

              ),
            );
            }
            if(prsn[index*5]!=name && prsn[(index*5)+1]=="Administrator")
              {
                return Container(
                  height: (190/872)*screenH,

                  child: Card(
                    color: Colors.blue.shade200,
                    elevation: 10,
                    margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

                    child: Column(
                      children: [
                        SizedBox.fromSize(size: Size(0,20),),
                        Stack(
                          children: [

                            CircleAvatar(
                              radius: 31,
                              backgroundImage: CachedNetworkImageProvider(prsn[(index*5)+4]),
                            )
                          ],


                        ),
                        Text("Name: "+prsn[index*5]),
                        Text("Role: "+prsn[(index*5)+1]),
                        Text("roll: "+prsn[(index*5)+2]),
                        Text("Email: "+prsn[(index*5)+3]),
                      ],
                    ),

                  ),
                );
              }
            if (prsn[index*5]!=name && prsn[(index*5)+1]=="Co-Administrator"){
              return Container(
              height: (190/872)*screenH,

              child: Card(
                color: Colors.yellow.shade200,
                elevation: 10,
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

                child: Column(
                  children: [
                    SizedBox.fromSize(size: Size(0,20),),
                    Stack(
                      children: [

                        CircleAvatar(
                          radius: 31,
                          backgroundImage: CachedNetworkImageProvider(prsn[(index*5)+4]),
                        )
                      ],


                    ),
                    Text("Name: "+prsn[index*5]),
                    Text("Role: "+prsn[(index*5)+1]),
                    Text("roll: "+prsn[(index*5)+2]),
                    Text("Email: "+prsn[(index*5)+3]),
                  ],
                ),

              ),
            );
            }
                if (prsn[index*5]==name && prsn[(index*5)+1]=="General member") {
                  return Container(
                    height: (190/872)*screenH,



                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                        )
                      ),
                      elevation: 10,
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),

                      child: Column(
                        children: [
                          SizedBox.fromSize(size: Size(0,20),),
                          Stack(
                            children: [

                              CircleAvatar(
                                radius: 31,
                                backgroundImage: CachedNetworkImageProvider(prsn[(index*5)+4]),
                              )
                            ],


                          ),
                          Text("Name: "+prsn[index*5]),
                          Text("Role: "+prsn[(index*5)+1]),
                          Text("roll: "+prsn[(index*5)+2]),
                          Text("Email: "+prsn[(index*5)+3]),
                        ],
                      ),

                    ),
                  );
                }
                if(prsn[index*5]==name && prsn[(index*5)+1]=="Administrator")
                {
                  return Container(
                    height: (190/872)*screenH,


                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,
                          )
                      ),
                      color: Colors.blue.shade200,
                      elevation: 10,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

                      child: Column(
                        children: [
                          SizedBox.fromSize(size: Size(0,20),),
                          Stack(
                            children: [

                              CircleAvatar(
                                radius: 31,
                                backgroundImage: CachedNetworkImageProvider(prsn[(index*5)+4]),
                              )
                            ],


                          ),
                          Text("Name: "+prsn[index*5]),
                          Text("Role: "+prsn[(index*5)+1]),
                          Text("roll: "+prsn[(index*5)+2]),
                          Text("Email: "+prsn[(index*5)+3]),
                        ],
                      ),

                    ),
                  );
                }
                if (prsn[index*5]==name && prsn[(index*5)+1]=="Co-Administrator"){
                  return Container(
                    height: (190/872)*screenH,


                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black,

                          ),
                              borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.yellow.shade200,
                      elevation: 10,
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 10),

                      child: Column(
                        children: [
                          SizedBox.fromSize(size: Size(0,20),),
                          Stack(
                            children: [

                              CircleAvatar(
                                radius: 31,
                                backgroundImage: CachedNetworkImageProvider(prsn[(index*5)+4]),
                              )
                            ],


                          ),
                          Text("Name: "+prsn[index*5]),
                          Text("Role: "+prsn[(index*5)+1]),
                          Text("roll: "+prsn[(index*5)+2]),
                          Text("Email: "+prsn[(index*5)+3]),
                        ],
                      ),

                    ),
                  );
                }




              });


        }),
      ),


    );
  }

}