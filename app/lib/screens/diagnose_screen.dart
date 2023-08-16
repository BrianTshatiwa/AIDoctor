import 'dart:html';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tflite/flutter_tflite.dart';

class DiagnosePage extends StatefulWidget {
  @override
  State<DiagnosePage> createState() => _DiagnosePageState();
}

class _DiagnosePageState extends State<DiagnosePage> {
  PickedFile? _image;
  bool _loading = false ;
  List<dynamic>? _outputs;
  final ImagePicker _picker = ImagePicker();

  //Load the Tflite model
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant",
      labels: "assets/labels.txt"
    ).then((value) {
      _loading = false;
    });
  }

  void _imageClasification(PickedFile image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _loading = false;
      _outputs = output;
    });
  }

  Future openGallery() async {
    final PickedFile ? picture = await _picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = picture;
    }
    );
    _imageClasification(_image as PickedFile);
  }

  Future openCamera() async {
    final PickedFile? image = (await _picker.getImage(source: ImageSource.camera)) as PickedFile?;

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(80),
        child: Column(
          children: [
            Center(child:Text('Artificial Intelligence Doctor', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),)),
            SizedBox(height: 20),
            _loading ?
            Container(
              width: 200,
              height: 200,
              color: Colors.grey,
              child: Image.network('data:image/jpeg;base64,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'),
            ) :
                Container(
                  width: 200,
                  height:200,
                  color: Colors.grey,
                  child: Image.asset(_image!.path),
                ),

            SizedBox(height: 30,),
            Row(children: [
              SizedBox(
                height:80,
                width: 95,
                child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  backgroundColor: Colors.blue[600],
                ),
                onPressed: (){
                  openGallery();
                },
                child: Column(
                  children: [
                    Icon(Icons.photo_album, size: 50, color: Colors.black,),
                    SizedBox(height:10),
                    Text('Gallery', style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],
                ),
              )
              ),
              SizedBox(width: 100),
              SizedBox(
                  height:80,
                  width: 95,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      backgroundColor: Colors.blue[600],
                    ),
                    onPressed: (){
                      openCamera();
                    },
                    child: Column(
                      children: [
                        Icon(Icons.camera, size: 50, color: Colors.black,),
                        SizedBox(height:10),
                        Text('Camera', style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),),
                      ],
                    ),
                  )
              )
            ],),
            SizedBox(height: 20,),
            Center(child:Container(
              decoration: BoxDecoration(
                  color: Colors.blue[600],
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              height: 45,
              width: 600,
              child: Center(child:Text('Condition: Pneumonia Positive \nConfidence:96%')),
            )),
          ],
        ),
      )
    );
  }
}
