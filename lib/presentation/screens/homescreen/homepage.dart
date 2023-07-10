import 'package:flutter/material.dart';
import 'package:hive_pjt/presentation/screens/homescreen/homescreen_bloc/homescreen_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomescreenBlocBloc(context:context),
      child: Scaffold(
        appBar: AppBar(
          title:
              const Center(child: Text("Welcome to Student Data Base System")),
        ),
        body: Center(
          child: BlocBuilder<HomescreenBlocBloc, HomescreenBlocState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      BlocProvider.of<HomescreenBlocBloc>(context).add(Write());
                    },
                    color: Colors.blue,
                    child: const Text('Write'),
                  ),
                  MaterialButton(
                    onPressed: () {
                      BlocProvider.of<HomescreenBlocBloc>(context).add(Read());
                    },
                    color: Colors.red,
                    child: const Text('Read'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}


