import 'package:FabriConnect/authentication_repository/authentication_repository.dart';
import 'package:FabriConnect/exit_dialogue.dart';
import 'package:FabriConnect/firestore_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // var controller = Get.put(productController());
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Color(0xFF000000),
            )),
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Color(0xFFe1e0dc),
      ),
      home: SplashScreen(),
    );
  }
  SplashScreen() {}
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState(){
    super.initState();
  }
  double value = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:() async {
        showDialog(
            barrierDismissible:false,
            context: context, builder: (context)=>exitDialogue(context));
        return false;
      },
      child: Scaffold(
        body: StreamBuilder(
            stream: FirestoreServices.getUser(FirebaseAuth.instance.currentUser!.uid),
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
              if(!snapshot.hasData){
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.red),
                  ),
                );
              }
              else {
                var data=snapshot.data!.docs[0];
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF0000FF),
                              Color(0xFF45b6fe),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          )),
                    ),
                    SafeArea(
                        child: Container(
                          width: 200.0,
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              DrawerHeader(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    data['Imgurl']==''?
                                    Container(

                                      child: Center(
                                        child: CircleAvatar(
                                          radius: 45,
                                          backgroundImage: AssetImage('assets/images/babyjacket.jpg'),
                                        ),
                                      ),
                                    ):
                                    Image.network(data['Imgurl'],width: 100,height:100,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make(),

                                    SizedBox(
                                      height: 10.0,
                                    ),

                                    Text("${data["FullName"]}",style: TextStyle(color: Colors.white,fontSize: 20),),
                                  ],
                                ),
                              ),

                              Expanded(
                                child: ListView(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyHomePage()));
                                      },
                                      leading: Icon(
                                        Icons.home,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        "Home",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => profile()));
                                      },
                                      leading: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        "profile",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) => cart()));
                                      },
                                      leading: Icon(
                                        Icons.card_travel,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        "Cart",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        AuthenticationRepository.instance.logOut();
                                        Get.snackbar(
                                            "Success",
                                            "you are logged out successfully.",
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.green
                                                .withOpacity(0.1),
                                            colorText: Colors.green);
                                      },
                                      leading: Icon(
                                        Icons.logout,
                                        color: Colors.white,
                                      ),
                                      title: Text(
                                        "LogOut",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                    TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: value),
                        duration: Duration(milliseconds: 500),
                        builder: (_, double value, __) {
                          return (Transform(
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.001)..setEntry(0, 3, 200 * value),
                            child: Scaffold(
                                appBar: AppBar(
                                  title: Center(child: Text("B2B Exchange")),
                                ),
                                body: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => men()));
                                        },
                                        child: SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: Center(
                                            child: CircleAvatar(
                                              radius: 100,
                                              backgroundImage:
                                              AssetImage('assets/images/men.jpg'),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment
                                            .center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          kids()));
                                            },
                                            child: SizedBox(
                                              height: 200,
                                              width: 200,
                                              child: Center(
                                                child: CircleAvatar(
                                                  radius: 100,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/kids.jpg'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => women()));
                                        },
                                        child: SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: Center(
                                            child: CircleAvatar(
                                              radius: 100,
                                              backgroundImage:
                                              AssetImage('assets/images/women.jpg'),
                                            ),
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                )),
                          ));
                        }),
                    GestureDetector(
                      onHorizontalDragUpdate: (e) {
                        if (e.delta.dx > 0) {
                          setState(() {
                            value = 1;
                          });
                        } else {
                          setState(() {
                            value = 0;
                          });
                        }
                      },
                    )
                  ],
                );
              }
            }
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  cart() {}
  profile(){}
  men() {}
  kids() {}
  women() {}
}
