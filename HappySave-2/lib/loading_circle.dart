import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  const LoadingCircle({Key key}) : super(key: key);

  Future refresh() async{
    LoadingCircle();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      //  RefreshIndicator(
      //     onRefresh : refresh,),
      
      //  RefreshIndicator(
      //     onRefresh : refresh,
      //    ),
      child: Container(
        height: 25,
        width: 25,
        child: CircularProgressIndicator(),
      ),
      
       
    );
     
    }
}
