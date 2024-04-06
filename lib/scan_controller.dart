import 'dart:math';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ScanController extends GetxController{
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  late CameraImage cameraImage;
  var cameraCount = 0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    inItCamera();
    inItTFLite();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }
  var isCameraInitialized = false.obs;

  inItCamera() async{
    if (await Permission.camera.request().isGranted){
      cameras = await availableCameras();

      cameraController = CameraController(cameras[0], ResolutionPreset.max);
      await cameraController.initialize().then((value){
        cameraCount++;
       
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount %10 == 0){
            cameraCount = 0;
            objectDetector(image);
          }update();
          });
       
        
        
      });
      isCameraInitialized(true);
      update();
    }else{
      print("permission denied");
      }
    }
    inItTFLite() async {
      await Tflite.loadModel(
        model: "assets/model.tflite", 
        labels: "assets/labels.txt",
        isAsset: true,
        numThreads: 1,
        useGpuDelegate:false);
    }


    objectDetector(CameraImage image) async{
      var detector = await Tflite.runModelOnFrame(bytesList: image.planes.map((e) {
        return e.bytes;
      }).toList(),
      asynch: true,
      imageHeight: image.height,
      imageWidth: image.width,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 1,
      rotation: 90,
      threshold: 0.4
      );

      if (detector != null ){
        print("result is $detector");
      }
    }
  
  }
