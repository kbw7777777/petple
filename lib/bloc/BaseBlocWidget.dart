
import 'package:flutter/material.dart';

class BaseBlocWidget{

  Stream streams() => null;

  Widget streamBuilder<T>({
    T initalData,
    Function success,
    Function error,
    Function loading,
    Function finished,
    Stream<T> stream,
  }) {
    return StreamBuilder(//StreamBuilder 
        stream: stream,
        initialData: initalData,
        builder: (context, AsyncSnapshot<T> snapshot) {
          if (finished != null) {
            finished();
          }
          if (snapshot.hasData) {
            if (success != null) return success(snapshot.data);
          } else if (snapshot.hasError) {
            if (error != null) return error(snapshot.hasError);
          } else {
            if (loading != null) return loading();
          }
        });
  }
}

