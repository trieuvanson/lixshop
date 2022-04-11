
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class SliverScrollController {

  // List of categories

  List<double> listOffSetItemHeader = [];

  final globalOffSetValue = ValueNotifier<double>(0);

  final goingDown = ValueNotifier<bool>(false);

  final valueScroll = ValueNotifier<double>(0);

  late ScrollController scrollControllerItemHeader;

  late ScrollController scrollControllerGlobally;

  final visibleHeader = ValueNotifier<bool>(false);

  void init(){
    scrollControllerGlobally = ScrollController();
    scrollControllerItemHeader = ScrollController();
    scrollControllerGlobally.addListener(_listenScrollChange);
  }



  
  void _listenScrollChange(){
    globalOffSetValue.value = scrollControllerGlobally.offset;
    if(scrollControllerGlobally.position.userScrollDirection == ScrollDirection.reverse){
      goingDown.value = true;
    }else{
      goingDown.value = false;
    }
  }

  void dispose(){

    scrollControllerGlobally.dispose();
    scrollControllerItemHeader.dispose();

  }

}
final sliverScrollController = SliverScrollController();