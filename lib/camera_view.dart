import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:objectdetection/scan_controller.dart';
import 'package:objectdetection/sql_helper.dart';

class CameraView extends StatelessWidget {
   CameraView( {super.key});

 var data = ScanController().RecipeData().toString();
  List<Map<String, dynamic>> _recipe = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          GetBuilder<ScanController>(
            init: ScanController(),
            builder: (controller) {
              return controller.isCameraInitialized.value ? CameraPreview(controller.cameraController) : Center(
                child: const Text(
                  "Loading preview"),
                  
              );
            }
          ),
          ElevatedButton(onPressed:  () async {
            var recipe = await SQLHelper.getItem(data);
            _recipe = recipe;
            print(_recipe);
           }
          , child: Text('scan now'))
        ],
      ),
    );
  }
}