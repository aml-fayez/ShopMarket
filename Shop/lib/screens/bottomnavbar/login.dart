import 'package:buy/screens/bottomnavbar/signup.dart';
import 'package:flutter/material.dart';
import 'package:buy/services/auth.dart';
import 'package:buy/screens/bottomnavbar/home.dart';
import 'package:buy/admin/adminHome.dart';
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  static String id ='LoginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
final _auth =Auth();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
bool secure = true;
bool isAdmin=false;
bool keepMeLoggedIn=false;
GlobalKey<FormState> emailKey = GlobalKey<FormState>();
GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
var _formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[200],
      body:Container(
        margin: EdgeInsets.all(15.0),
        child: Form(
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
            field('Enter your Email',Icons.email,emailController,TextInputType.emailAddress,false,emailKey),
            Padding(padding: EdgeInsets.only(left: 10),
           child: Row(children: [
            Checkbox(value:keepMeLoggedIn,
            activeColor: Colors.orange,
            //checkColor:Colors.orange[200],
             onChanged:(value){
              setState(() {
                keepMeLoggedIn=value;
              });
            }),
            Text('Remmeber Me',
            style:TextStyle(color: Colors.white)
            ),
            ]),
            ),
            field('Enter your Password',Icons.lock,passwordController,TextInputType.text,secure,passwordKey),
         Column(
           children: [
             Builder(
               builder: (BuildContext context){
                  return FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),),
                    child:Text(
                      'Login' ,
                      style:TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    color:Colors.black,
                    onPressed:(){
                      if(keepMeLoggedIn==true){
                        keepUserLoggedIn();
                      }
                      validate(context);
                    } 
               
                  );
               },
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                Text(
                    'Don\'t have an account?',
                    style: TextStyle(color: Colors.white, fontSize: 20, height: 1.5,fontWeight:FontWeight.bold),
             ),
             GestureDetector(
               onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return Signup();}));
               },
            child: Text('Signup',
                   style: TextStyle(color: Colors.black, fontSize: 22, height: 1.5,fontWeight:FontWeight.bold),
             ),
             ),
               ],
             ),
              Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 GestureDetector(
               onTap: (){
                 setState(() {
                   isAdmin=!isAdmin;
                 });
               },
               child: Text(
                    'I\'m an admin',
                    textAlign: TextAlign.center,
                    style: TextStyle(color:isAdmin? Colors.orange[200]:Colors.white, fontSize: 20, height: 1.5,fontWeight:FontWeight.bold),
             ),
                 ),
                   GestureDetector(
               onTap: (){
                 setState(() {
                   isAdmin=!isAdmin;
                 });
               },
            child: Text(
                     'I\'m a user',
                     textAlign: TextAlign.center,
                    style: TextStyle(color:isAdmin? Colors.white:Colors.orange[200], fontSize: 20, height: 1.5,fontWeight:FontWeight.bold),
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
  keepUserLoggedIn() async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setBool('keepMeLoggedIn', keepMeLoggedIn);
  }


field(String label,IconData icon,TextEditingController controller,TextInputType type,bool secured,Key key){
  return Padding(
    padding: const EdgeInsets.all(10),
  child:TextFormField(
    cursorColor: Colors.orange[200],
   key: key,
   validator:(value){
   if(value.isEmpty){
   return 'this field required';
   }else{
   return null;}
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
validate(BuildContext context) async{
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      if(isAdmin==true){
       if(passwordController.text=='admin1234'){
            try{
     await _auth.signIn(emailController.text,passwordController.text);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return AdminPage();}));
    }catch(e){
     Scaffold.of(context).showSnackBar(snack(e.message));
     } 
       }
       else{
       Scaffold.of(context).showSnackBar(snack('Somethings Wrong'));
       }
      
    }else{
      try{
      await _auth.signIn(emailController.text,passwordController.text);
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return HomePage();}));
    }catch(e){
     Scaffold.of(context).showSnackBar(snack(e.message));
     }
    }
    }else{
      Scaffold.of(context).showSnackBar(snack('Some Field Required!'));
     }
  }
}
