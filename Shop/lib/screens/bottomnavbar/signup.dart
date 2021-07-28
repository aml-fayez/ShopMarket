//import 'package:buy/provider/modalHud.dart';
import 'package:buy/screens/bottomnavbar/login.dart';
import 'package:buy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:flutter_progress_hud/flutter_progress_hud.dart';


class Signup extends StatefulWidget {

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _auth=Auth();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool secure = true;
GlobalKey<FormState> nameKey = GlobalKey<FormState>();
GlobalKey<FormState> emailKey = GlobalKey<FormState>();
GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
var _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return    
    Scaffold(
      backgroundColor: Colors.orange[200],
      body:Container(
        margin: EdgeInsets.all(15.0),
        child:Form(
          key: _formKey,
       child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
                margin:EdgeInsets.all(15.0),
              child:Column(children: [
               Container( 
                 height: MediaQuery.of(context).size.height*0.2,
              child:Image(
               image:AssetImage('images/lo.png'),
               fit: BoxFit.fill
              ), 
               ),
            
              Text('Buy it ',
              style: TextStyle(color: Colors.black ,fontFamily:'Pacifico',fontSize: 30.0),
              ),
              ],
             ),
            ),
            field('Enter your Name',Icons.person,nameController,TextInputType.text,false,nameKey),
            field('Enter your Email',Icons.email,emailController,TextInputType.emailAddress,false,emailKey),
            field('Enter your Password',Icons.lock,passwordController,TextInputType.text,secure,passwordKey),
         Column(
           children: [
             Builder(
               builder: (BuildContext context){
                  return FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),),
                    child:Text(
                      'Sign up' ,
                      style:TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    color:Colors.black,
                    onPressed:() async{ 
                      if(_formKey.currentState.validate()){
                         _formKey.currentState.save();
                         try{
                   final authResult =await (_auth.signUp(emailController.text,passwordController.text));
                   print(authResult.user.uid);

                      }on PlatformException catch(e){
                        Scaffold.of(context).showSnackBar(snack(e.message));
                       
                      }
                      }else{
                        return
                          Scaffold.of(context).showSnackBar(snack('Some Field Required!'));
                       
                      }
                    },
                  );
               },
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                Text(
                    'Do have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 20, height: 1.5,fontWeight:FontWeight.bold),
             ),
             GestureDetector(
               onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return LoginScreen();}));
               },
            child: Text('Login',
                   style: TextStyle(color: Colors.black, fontSize: 22, height: 1.5,fontWeight:FontWeight.bold),
             ),
             ),
             
            /* Align(
               alignment:Alignment.bottomCenter,
               child:InkWell(
                 onTap:(){},
                 child: Text(
                    'Don\'t have an account? Sign In',
                    style: TextStyle(color: Colors.grey, fontSize: 15.0, height: 1.5)
                  ),
               ),
            */
             ],
             ), 
           ],
           ),
              ],
            ),
        ),
      ),
    
    );
  }
  snack(String content){
    return SnackBar(
      content:Text( content),
     duration: Duration(seconds: 3),
     backgroundColor: Colors.red,
      );
  }
    

  
displayToastMassge(String ms,BuildContext context){
  FlutterToast.showToast(msg: ms);
}

field(String label,IconData icon,TextEditingController controller,TextInputType type,bool secured,Key key){
  return Padding(
    padding: const EdgeInsets.all(15.0),
  child:TextFormField(
    cursorColor: Colors.orange[200],
   key: key,
   validator:(value){
   if(value.isEmpty){
   return 'this field required';
   }else{
     return null;  
   }
},
  decoration: InputDecoration(
    filled: true,
    fillColor:Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white, width:1)
          
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white, width: 1)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: Colors.white, width: 1)
          ),
          prefixIcon:Icon(icon,color: Colors.orange),
          suffixIcon: label=='Enter your Password' ? IconButton(
            icon:Icon( Icons.remove_red_eye),
            color: Colors.grey,
            onPressed: (){
              setState(() {
                 secure = !secure;
              });
            },
          ): null,
  labelText: label,
  ),
  textInputAction: TextInputAction.done,
  keyboardType: type,
   obscureText: secured,
   controller: controller
  
  ),
  );
}
}