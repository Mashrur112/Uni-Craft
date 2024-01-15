import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class members extends StatelessWidget{
  var join_code;
  var prsn=[];
  var prfl_inf=[];
  int pr=0,prf=0;
  var d=0.0;
  int s=0;
  var name;

  members({super.key});
  @override
  Widget build(BuildContext context) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding:  const EdgeInsets.symmetric(vertical: 30),
        child: StreamBuilder(stream: FirebaseFirestore.instance.collection('Profile').snapshots(), builder: (context,snapshots){
          if(snapshots.hasData)
            {
              final res=snapshots.data!.docs.reversed.toList();
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
                      prfl_inf.insert(5, r['uid']);
                     for(int i=0;i<6;i++)
                       {

                         prsn.insert(pr, prfl_inf[i]);
                         pr++;
                       }


                    }
                }
               d=(pr)/6;
              s=d.toInt();

            }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
              itemCount: s,

              itemBuilder: (BuildContext context,int index){




            if (prsn[index*6]!=name && prsn[(index*6)+1]=="General member") {
              return SizedBox(
              height: (250/872)*screenH,

              child: Card(
                elevation: 10,
                margin: EdgeInsets.fromLTRB(((10/392)*screenW), ((10/872)*screenH), ((10/392)*screenW), ((0/872)*screenH)),

                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    (10 / 392) * screenW,
                    (10 / 872) * screenH,
                    (10 / 392) * screenW,
                    (0 / 872) * screenH,
                  ),
                    children: <Widget>[ Column(
                    children: [
                      SizedBox.fromSize(size: const Size(0,20),),
                      Stack(
                        children: [

                          CircleAvatar(
                            radius: 31,
                            backgroundImage: CachedNetworkImageProvider(prsn[(index*6)+4]),
                          )
                        ],


                      ),
                      Text("Name: "+prsn[index*6]),
                      Text("Role: "+prsn[(index*6)+1]),
                      Text("Roll: "+prsn[(index*6)+2]),
                      Text("Email: "+prsn[(index*6)+3]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(onPressed: (){
                              FirebaseFirestore.instance.collection("Profile").doc(prsn[(index*6)+5]).delete();




                            }, child: const Text("Delete")),
                          ),
                        ],
                      ),

                    ],
                  ),],
                ),

              ),
            );
            }
            if(prsn[index*6]!=name && prsn[(index*6)+1]=="Administrator")
              {
                return SizedBox(
                  height: (250/872)*screenH,

                  child: Card(
                    color: Colors.blue.shade200,
                    elevation: 10,
                    margin: EdgeInsets.fromLTRB(((10/392)*screenW), ((10/872)*screenH), ((10/392)*screenW), ((0/872)*screenH)),

                    child: Column(
                      children: [
                        SizedBox.fromSize(size: const Size(0,20),),
                        Stack(
                          children: [

                            CircleAvatar(
                              radius: 31,
                              backgroundImage: CachedNetworkImageProvider(prsn[(index*6)+4]),
                            )
                          ],


                        ),
                        Text("Name: "+prsn[index*6]),
                        Text("Role: "+prsn[(index*6)+1]),
                        Text("Roll: "+prsn[(index*6)+2]),
                        Text("Email: "+prsn[(index*6)+3]),
                      ],
                    ),

                  ),
                );
              }
            if (prsn[index*6]!=name && prsn[(index*6)+1]=="Co-Administrator"){
              return SizedBox(
              height: (250/872)*screenH,

              child: Card(
                color: Colors.yellow.shade200,
                elevation: 10,
                margin: EdgeInsets.fromLTRB(((10/392)*screenW), ((10/872)*screenH), ((10/392)*screenW), ((0/872)*screenH)),

                child: ListView(
                    //padding: const EdgeInsets.all(8),
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.fromLTRB(
                    (10 / 392) * screenW,
                    (10 / 872) * screenH,
                    (10 / 392) * screenW,
                    (0 / 872) * screenH,
                  ),
                  children: <Widget>[ Column(
                    children: [
                      SizedBox.fromSize(size: const Size(0,20),),
                      Stack(
                        children: [
                  
                          CircleAvatar(
                            radius: 31,
                            backgroundImage: CachedNetworkImageProvider(prsn[(index*6)+4]),
                          )
                        ],
                  
                  
                      ),
                      Text("Name: "+prsn[index*6]),
                      Text("Role: "+prsn[(index*6)+1]),
                      Text("Roll: "+prsn[(index*6)+2]),
                      Text("Email: "+prsn[(index*6)+3]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(onPressed: (){
                              FirebaseFirestore.instance.collection("Profile").doc(prsn[(index*6)+5]).delete();
                  
                  
                  
                  
                            }, child: const Text("Delete"),),

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
                if (prsn[index*6]==name && prsn[(index*6)+1]=="General member") {
                  return SizedBox(
                    height: (250/872)*screenH,



                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 10,
                      margin: EdgeInsets.fromLTRB(((10/392)*screenW), ((10/872)*screenH), ((10/392)*screenW), ((0/872)*screenH)),

                      child: Column(
                        children: [
                          SizedBox.fromSize(size: const Size(0,20),),
                          Stack(
                            children: [

                              CircleAvatar(
                                radius: 31,
                                backgroundImage: CachedNetworkImageProvider(prsn[(index*6)+4]),
                              )
                            ],


                          ),
                          Text("Name: "+prsn[index*6]),
                          Text("Role: "+prsn[(index*6)+1]),
                          Text("Roll: "+prsn[(index*6)+2]),
                          Text("Email: "+prsn[(index*6)+3]),
                        ],
                      ),

                    ),
                  );
                }
                if(prsn[index*6]==name && prsn[(index*6)+1]=="Administrator")
                {
                  return SizedBox(
                    height: (250/872)*screenH,


                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                        borderRadius: BorderRadius.circular(12),

                      ),
                      color: Colors.blue.shade200,
                      elevation: 10,
                      margin: EdgeInsets.fromLTRB(((10/392)*screenW), ((10/872)*screenH), ((10/392)*screenW), ((0/872)*screenH)),

                      child: Column(
                        children: [
                          SizedBox.fromSize(size: const Size(0,20),),
                          Stack(
                            children: [

                              CircleAvatar(

                                radius: 31,
                                backgroundImage: CachedNetworkImageProvider(prsn[(index*6)+4]),
                              )
                            ],


                          ),
                          Text("Name: "+prsn[index*6]),
                          Text("Role: "+prsn[(index*6)+1]),
                          Text("Roll: "+prsn[(index*6)+2]),
                          Text("Email: "+prsn[(index*6)+3]),
                        ],
                      ),

                    ),
                  );
                }
                if (prsn[index*6]==name && prsn[(index*6)+1]=="Co-Administrator"){
                  return SizedBox(
                    height: (250/872)*screenH,


                    child: Card(
                      shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            color: Colors.black,
                            width: 2,

                          ),
                              borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.yellow.shade200,
                      elevation: 10,
                      margin: EdgeInsets.fromLTRB(((10/392)*screenW), ((10/872)*screenH), ((10/392)*screenW), ((0/872)*screenH)),

                      child: Column(
                        children: [
                          SizedBox.fromSize(size: const Size(0,20),),
                          Stack(
                            children: [

                              CircleAvatar(
                                radius: 31,
                                backgroundImage: CachedNetworkImageProvider(prsn[(index*6)+4]),
                              )
                            ],


                          ),
                          Text("Name: "+prsn[index*6]),
                          Text("Role: "+prsn[(index*6)+1]),
                          Text("Roll: "+prsn[(index*6)+2]),
                          Text("Email: "+prsn[(index*6)+3]),

                        ],
                      ),

                    ),
                  );
                }
                return null;




              });


        }),
      ),


    );
  }

}