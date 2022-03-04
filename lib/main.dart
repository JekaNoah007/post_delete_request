import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_delete_request/api/user_service.dart';
import 'package:post_delete_request/bloc/user_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController jobController = TextEditingController();

  final userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reqyest"),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => userBloc,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserInitialState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          hintText: "Напишите имя",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: jobController,
                        decoration: const InputDecoration(
                          hintText: "Напишите профессию",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          userBloc.add(UserCreateEvent(
                              name: nameController.text,
                              job: jobController.text));
                        },
                        child: const Text("Создать"),
                      ),
                    ],
                  );
                }
                if (state is UserLoadedState) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.model.name.toString()),
                      const SizedBox(height: 10),
                      Text(state.model.job.toString()),
                      const SizedBox(height: 10),
                      Text(
                          "${DateFormat("yyyy-MM-dd").parse(state.model.createdAt.toString())}"),
                      // IconButton(
                      //     onPressed: () {
                      //       userBloc.add(UserDeleteEvent(
                      //           name: state.model.name.toString(),
                      //           job: state.model.id.toString()));
                      //     },
                      //     icon: Icon(Icons.delete))
                      const SizedBox(height: 40),
                      FloatingActionButton(
                          child: const Icon(Icons.delete,
                              color: Color.fromARGB(255, 255, 17, 0)),
                          onPressed: () async {
                            await UserService().deleteUser(
                                nameController.text, jobController.text);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Delete Info")));
                          }),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
