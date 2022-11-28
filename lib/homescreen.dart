import 'package:bloc_wifi/blocs/internet_bloc.dart';
import 'package:bloc_wifi/blocs/internet_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>InternetBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeScreen'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocConsumer<InternetBloc,InternetState>(builder: (context,state){
            if(state is InternetGainedState){
              return Center(child: Text('Connected!'));
            }
            else if(state is InternetLostState){
              return Center(child: Text('Not Connected!'));
            }
            else{
              return Center(child: Text('Loading...'));
            }
          }, listener: (context,state){
            if(state is InternetGainedState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Internet Connected!!'),backgroundColor: Colors.green));
            }
            else if(state is InternetLostState){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Internet Disconnected!!'),backgroundColor: Colors.red));
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Loading...'),backgroundColor: Colors.blue));
            }
          })
          // BlocBuilder<InternetBloc,InternetState>(builder: (context,state){
          //   if(state is InternetGainedState){
          //     return Center(child: Text('Connected!'));
          //   }
          //   else if(state is InternetLostState){
          //     return Center(child: Text('Not Connected!'));
          //   }
          //   else{
          //     return Center(child: Text('Loading...'));
          //   }
          // })
        ],
      ),
    );
  }
}
