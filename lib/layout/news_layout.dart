import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';

class NewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("News App"),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                  }),
              IconButton(
                  icon: Icon(
                    Icons.brightness_4_outlined,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    cubit.changeMode();
                  }),

            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.navigationItems,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeNavigationIndex(index);
            },
          ),
        );
      },
    );
  }
}
