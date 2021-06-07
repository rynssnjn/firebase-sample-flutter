import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_sample/apis/test_api/models/test_model.dart';
import 'package:firebase_sample/utilities/app_starter.dart';
import 'package:firebase_sample/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_sample/utilities/extensions.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({
    required this.onAddData,
    this.nameController,
    this.ageController,
    Key? key,
  }) : super(key: key);

  final TextEditingController? nameController;
  final TextEditingController? ageController;
  final Future<void> Function(TestModel data)? onAddData;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Firebase Demo'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('error');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }

          return ListView(
            shrinkWrap: true,
            children: [
              ...snapshot.data!.docs.map((e) {
                final testModel = TestModel.fromJson(e.decoded!);
                return Column(
                  children: [
                    Text(testModel.name!, style: textTheme.bodyText1),
                    Text(testModel.age!.toString(), style: textTheme.caption),
                  ],
                );
              }).toList(),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Name'),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  controller: ageController,
                  decoration: InputDecoration(hintText: 'Age'),
                ),
              ),
              Center(
                child: LoadingWidget(
                  futureCallback: () async => await onAddData!(TestModel(
                    name: nameController!.text,
                    age: int.tryParse(ageController!.text),
                  )),
                  renderChild: (isLoading, onTap) => isLoading
                      ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: onTap,
                          child: Text('Save to Database'),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
