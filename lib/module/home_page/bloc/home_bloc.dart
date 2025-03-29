import 'package:smart_locker/module/home_page/bloc/home_event.dart';
import 'package:smart_locker/module/home_page/bloc/home_state.dart';
import 'package:smart_locker/module/home_page/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState>{
  final List<Widget> pages = [
    HomePage(),
  ];
  HomeBloc() : super(HomeInital()){
    on<ChangePage>((event, emit){
      emit(HomeChangePage(index: event.index));
    });
  }
}
