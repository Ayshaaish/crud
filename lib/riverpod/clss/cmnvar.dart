import 'package:crud/riverpod/clss/statenotifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


///provider
final nameProviderCls=Provider<String>((ref) => 'aysha');

///state provider
final studentProvider=StateProvider<String>((ref) => 'aysha',);
final counterProviderCls=StateProvider<int>(
      (ref)=>0,
);
final userProvider=StateProvider<StateModel?>((ref) => null,);
final personListProvider=StateProvider<List<StateModel>>((ref) => [],);
/// provider for calculator
final displayProvider=StateProvider<String>(
        (ref)=>'0'
);
final resultProvider = StateProvider<String>((ref) => '0');

/// statenotifier provider
final listOfData=StateNotifierProvider<SampleNotifier,List<StateModel>>((ref) =>SampleNotifier());

/// stream provider
final streamProvider=StreamProvider<int>((ref) {
  return Stream.periodic(const Duration(seconds: 2),(computationCount) => computationCount,);
},);