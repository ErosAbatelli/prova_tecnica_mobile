import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prova_tecnica_mobile/quesito2.dart';
import 'package:prova_tecnica_mobile/utils/customSnackBar.dart';
import 'package:http/http.dart' as http;

class Quesito1 extends StatefulWidget {
  Quesito1({Key key}) : super(key: key);

  @override
  _Quesito1 createState() => _Quesito1();
}

class _Quesito1 extends State<Quesito1> {

  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  List lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false, //fix keyboard
        //Rimuovo in questo modo l'app bar, senza crearmi troppi problemi nel layout
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(0.0),
          child: AppBar(
          ),
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/image/backgroundImage.jpg"),
                    fit: BoxFit.cover
                )
            ),
            child: Column(
                children: [
                  SizedBox(height: 20),
                  build_title_icon(),
                  build_email_password(),
                  build_footer(),
                  SizedBox(height: 10.0),
                ]
            ),
          ),
        )
    );
  }

  /**
   *
   * BUILD PARTE GRAFICA
   */

  Widget build_title_icon()
  {
    return Flexible(
      flex: 3,
      child: Container(
          height: double.infinity,
          child: Column(
            children: [
              Icon(
                  Icons.arrow_downward,
                  color: Color.fromRGBO(40, 234, 239, 100),
                  size: 200
              ),
              Text(
                "#IMPRINTING",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "Pirulen",
                    color: Color.fromRGBO(40, 234, 239, 100),
                    fontSize: 23
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget build_email_password(){
    /**
     *
     * Email
     *
     */
    return Flexible(
        flex: 2,
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                    "EMAIL",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  TextField(
                    focusNode: focusNodeEmail,
                    controller: loginEmailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(40, 234, 239, 100),
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Scrivi la tua email',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(40, 234, 239, 100),
                        )
                    ),
                    onSubmitted: (_) {
                      focusNodePassword.requestFocus();
                    },
                  ),

                  Container(height: 2.0, color: Colors.grey[400],),

                  /**
                   *
                   * Password
                   *
                   */
                  SizedBox(height: 10),
                  Text(
                    "PASSWORD",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  TextField(
                    focusNode: focusNodePassword,
                    controller: loginPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromRGBO(40, 234, 239, 100),
                      fontFamily: 'OpenSans',
                    ),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Scrivi la tua password',
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(40, 234, 239, 100),
                        )
                    ),
                    onSubmitted: (_) {
                      _LoginButton();
                    },
                  ),
                  Container(height: 2.0, color: Colors.grey[400],),
                ],
              )
          ),
        )
    );
  }

  Widget build_footer() {
    var size = MediaQuery.of(context).size;

    return Flexible(
      flex: 2,
      child: Column(
        children: [
          Flexible(flex: 3, child: build_btnLogin(size)),
          Flexible(flex: 2, child: Container(),), //usato solo per fare spazio, senza utilizzare dei valori numerici
          Flexible(flex: 1, child: build_forgotPassword()),
          Flexible(flex: 1, child: build_help())
        ],
      ),
    );
  }

  Widget build_btnLogin(size){
    return Container(
      width: (size.height*0.50) / 3,
      height: (size.height*0.50) / 9,

      child: RaisedButton(
        onPressed: () {
          _LoginButton();
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0)),
        color: Colors.black,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget build_forgotPassword() {
    return Container(
      height: double.infinity,
      alignment: Alignment.center,
      child: Text(
        "Hai dimenticato la tua password?",
        textAlign: TextAlign.start,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontFamily: 'OpenSans',
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget build_help() {
    return Container(
      height: double.infinity,
      alignment: Alignment.bottomCenter,
      child: Text(
        "Hai bisogno di aiuto?",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          color: Colors.black,
          fontFamily: 'OpenSans',
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }


  /**
   *
   * PARTE LOGICA
   */

  void _LoginButton(){
    if(loginEmailController.text == "" || loginPasswordController.text == "" || (loginPasswordController.text == "" && loginEmailController.text == ""))
      {
        CustomSnackBar(context, const Text("Credenziali non corrette. Riprovare"));
      }
    else{
      showCheckCredentialDialog(context);
      loadData();
    }
  }

  showCheckCredentialDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7),
              child: Text("Controllando le credenziali..")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> loadData() async {
    String dataURL = 'http://example.com/api/users';

    //Invio la richiesta POST
    var response = await http.post(
        Uri.parse(dataURL),
        body: {
          "email": loginEmailController.text,
          "password": loginPasswordController.text,
        });
    print(response.body);

    /**
     *
     * ESEMPIO DI .PHP che dovrebbe risiedere nella pagina 'http://example.com/api/users':
     *
     * <?php
        $Email = $_POST['email'];
        $Password = $_POST['password'];

        if(str_contains($Email, 'gino') && (str_contains($Password, 'onig'))
        {
        $data = array("authenticated" => true);

        header("Content-Type: application/json");
        echo json_encode($data);
        }
        else{
        $data = array("authenticated" => false);

        header("Content-Type: application/json");
        echo json_encode($data);
        }

        exit();
        ?>
     */

    //A questo punto, se le credenziali saranno corrette si potrà procedere nella seconda form

    String strJSON = '{authenticated: true}';
    print(strJSON);

    if (strJSON == "{authenticated: true}") {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Quesito2()),
      );
    } else {
      Navigator.pop(context);
      CustomSnackBar(context, Text("Errore, qualcosa è andato storto"));
    }

  }



}

