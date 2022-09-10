import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:prova_tecnica_mobile/utils/customSnackBar.dart';

import 'classes/book.dart';

class Quesito2 extends StatefulWidget {
  Quesito2({Key key}) : super(key: key);

  @override
  _Quesito2 createState() => _Quesito2();
}

class _Quesito2 extends State<Quesito2> {
  List<Book> listBook = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _getRequest();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/image/backgroundImage.jpg"),
                fit: BoxFit.cover
            )
        ),
        child: isLoading
            ? Center( child: CircularProgressIndicator() )
            : build_list(),
      )
    );
  }

  /**
   * PARTE GRAFICA
   */

  Widget build_list() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: listBook.length,
      itemExtent: MediaQuery.of(context).size.height * 0.135,
      itemBuilder: (context, position) {
        return Container(
          alignment: AlignmentDirectional.center,
          color: Colors.transparent,
          margin: EdgeInsets.only(top:8),
          width: MediaQuery.of(context).size.width * 0.9,
          child: _itemList(position)
        );
      },
    );
  }

  Widget _itemList(int position) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(width: 2, color: Colors.black)
            )
        ),
        child: ListTile(
          onTap: () {
            CustomSnackBar(
                context, Text("Hai clickato title: ${listBook[position].title}"));
          },
          title: Container(
            child: Row(
              children: <Widget>[
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        child: Text("Titolo: ${listBook[position].title}"),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.6,
                        child: Text(
                            "Descrizione: ${listBook[position].description}"),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.centerRight,
                      child: MaterialButton(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.1,
                        color: Colors.white70,
                        textColor: Colors.black,
                        child: Text("ELIMINA"),
                        onPressed: () {
                          print("${listBook[position].title}");
                          _deleteBtn(position);
                        },
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }


  /**
   * PARTE LOGICA
   */

  Future _getRequest() async {
    String dataURL = 'http://example.com/api/data';

    //Invio la richiesta GET
    var response = await http.get(Uri.parse(dataURL));

    /**
     *
        ESEMPIO DI .PHP che dovrebbe risiedere nella pagina 'http://example.com/api/data':

        <?php
        $data1 = array("id" => 1, "title" => "Bello", "description" => "Descrizione Bello");
        $data2 = array("id" => 2, "title" => "Carino", "description" => "Descrizione Carino");
        $data3 = array("id" => 3, "title" => "Simpatico", "description" => "Descrizione Simpatico");
        $data4 = array("id" => 4, "title" => "Eccetera", "description" => "Descrizione Eccetera");
        $data5 = array("id" => 5, "title" => "Bene", "description" => "Descrizione Benissimo");

        $dataResult = array($data1, $data2, $data3, $data4, $data5);

        header("Content-Type: application/json");
        echo json_encode($dataResult);
        exit();
        ?>


        Nel seguente modo funziona l'aggiunta degli elementi se il sito ha un Json formattato come da descrizione

        final jsonData = (jsonDecode(response.body) as List).map((data) => Book.fromJson(data)).toList();
        for(var i = 0; i < jsonData.length; i++){
        listBook.add(jsonData[i]);
        }

     */



    /**
     * In questo caso mi creo una lista predefinita
     *
     */

    for(var i = 0; i < 8; i++){
      Book book = new Book(id: i, title: '$i', description: '$i');
      listBook.add(book);
    }

    setState(() {
      isLoading = false;
    });
  }

  void _deleteBtn(int position) {
    CustomSnackBar(context, Text("Hai rimosso title: ${listBook[position].title}"));
    listBook.removeAt(position);

    setState(() {});
  }

}