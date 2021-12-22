import 'package:get/get.dart';

class StepController extends GetxController{
  RxInt activeStepState = 0.obs;

  increment(){
    activeStepState += 1;
  }

  decrement(){
     activeStepState -= 1;
  }

  returnZero(){
    activeStepState.value = 0;
  }
  
}