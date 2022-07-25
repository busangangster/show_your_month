import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  home_pageState createState() => home_pageState();
}

class home_pageState extends State<home_page> {

  var today_Date = DateFormat('dd').format(DateTime.now());

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('products');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (price != null) {
                      await _products
                          .doc(documentSnapshot!.id)
                          .update({"name": name, "price": price});
                      _nameController.text = '';
                      _priceController.text = '';
                    }
                  },
                )
              ],
            ),
          );
        });
  } // 업데이트

  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    if (price != null) {
                      await _products.add({"name": name, "price": price});

                      _nameController.text = '';
                      _priceController.text = '';
                    }
                  },
                )
              ],
            ),
          );
        });
  } // 생성

  Future<void> _delete(String productId) async {
    await _products.doc(productId).delete();

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  } // 삭제

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/top_bar_logo.png',
          width: 100.w,
          height: 48.h,
        ),
      ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(38, 45, 38 , 0),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text("오늘은",style: TextStyle(fontSize: 12.sp)),
                   Text("${today_Date} 일",style: TextStyle(fontSize: 32.sp,fontWeight: FontWeight.bold),),
                   SizedBox(height: 54.h,),
                   Text("할 일을 차근차근 해보아요 !",style: TextStyle(fontSize: 12.sp)),
                   Container(
                     height: 400.h,
                     child: StreamBuilder(
                       stream: _products.snapshots(),
                       builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                         if (streamSnapshot.hasData) {
                           return ListView.builder(
                             itemCount: streamSnapshot.data!.docs.length, // number of rows
                             itemBuilder: (context, index) {
                               final DocumentSnapshot documentSnapshot =
                               streamSnapshot.data!.docs[index];
                               return Card(

                                 child: ListTile(
                                   title: Text(documentSnapshot['name']),
                                   subtitle: Text(documentSnapshot['price'].toString()),
                                   trailing: SizedBox(
                                       width: 100,
                                       child: Row(
                                         children: [
                                           IconButton(
                                             icon: const Icon(Icons.edit),
                                             onPressed: () => _update(documentSnapshot),
                                           ),
                                           IconButton(
                                             icon: const Icon(Icons.delete),
                                             onPressed: () => _delete(documentSnapshot.id),
                                           )
                                         ],
                                       )),
                                 ),
                               );
                             },
                           );
                         }
                         return const Center(
                           child: CircularProgressIndicator(),
                         );
                       },
                     ),
                   ),
                 ],
              ),


              Column(

                children: [
                  SizedBox(height: 570.h,),
                  FloatingActionButton(
                      onPressed: () => _create(),
                      child: const Icon(Icons.add),
                    ),
                ],
              ),

            ],
          ),
        ));
  }
}
