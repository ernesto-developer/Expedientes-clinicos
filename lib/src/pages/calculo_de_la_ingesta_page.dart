import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:aplicacion_web/src/providers/expedientes_provider.dart';
import 'package:aplicacion_web/src/source/expediente.model.dart';
import 'package:aplicacion_web/src/widgets/botones.dart';


class CalculoDeLaIngestaPage extends StatefulWidget {
    // final scaffoldKey  = new GlobalKey<ScaffoldState>(); ########### esto para usar el snackbar

  @override
  _CalculoDeLaIngestaPageState createState() => _CalculoDeLaIngestaPageState();
}

class _CalculoDeLaIngestaPageState extends State<CalculoDeLaIngestaPage> {
      

       List<String> elementos = ['Macronutrientes','                   Gramos','                     Porcentaje','                     Calorias'];
        List<String> macronutrientes = [
    'CH',
    'PTS',
    'LIP',
    'TOTAL',
  ];

  Gramos gramosClase = new Gramos();
  Porcentaje porcentajeClase = new Porcentaje();
  Calorias caloriasClase = new Calorias();

  final expedienteProvider = new ExpedientesProvider();
  final keyForm            = new GlobalKey<FormState>();
  
  

  // ############################################################ instancias de las clases #####################
  ExpedienteModel expediente = new ExpedienteModel();
 
  

  @override
  Widget build(BuildContext context) {
  
    
    final ExpedienteModel expeData = ModalRoute.of(context).settings.arguments;
    if (expeData != null){
      expediente = expeData;
    }

     
    
    Size size = MediaQuery.of(context).size;
    
   
   
    return Scaffold(
      // key: scaffoldKey,  ########### esto para usar el snackbar
      appBar: AppBar(
        centerTitle: true,
        actions: [botonDeHome(context),],
        title: Text('Calculo de la ingesta habitual')
      ),
    
     body:  Stack(
      children: [
    //########################################################################################## Container fondo de madera ####################    
         Container(
          
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
             image: DecorationImage(
               fit: BoxFit.fill,
                  image: AssetImage('assets/madera_escritorio.jpg'),
          ),
          
        )
        ),
        
        Row(children: [
    //################################################################################# Container morado lateral #################
        Container(
          color: Color.fromRGBO(62, 66, 107, 0.3,),
          width: size.width * .25,
          height: size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                                          //########################## Container blanco con azul superior ###########
                BounceInDown(
                  duration: Duration(seconds: 2),
                  child: Container(
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                   boxShadow: [
                       BoxShadow(color: Colors.black38,blurRadius: 3.0,offset: Offset(0.0, 5.0),spreadRadius: 3.0)
                     ]
                  ),
                  
                  width: size.width * .245,
                  height: size.height * .25,
                  child:   Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Container(
                            padding: EdgeInsets.all(6),
                           decoration: BoxDecoration(
                             boxShadow: [
                              BoxShadow(color: Colors.black54,blurRadius: 3.0,offset: Offset(0.0, 5.0),spreadRadius: .5),
                            ], 
                            color: Colors.blue[300],
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                          ),
                            width: 1,
                            height: 1,
                            child: Column(
                              children: [
                                Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Expediente",style: TextStyle(color: Colors.white,fontSize: size.longestSide * .015))
                                ],
                                ),
                                SizedBox(height: size.longestSide *.01,),
                                Row(
                                  children: [
                                    Container(
                                      color: Colors.transparent,
                                      width: size.longestSide * .17,
                                      height: size.longestSide * .070,
                                      child: Column(
                                        
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [ 
                                         Text('Nombre: ${expediente.nombre}',style: TextStyle(fontSize: size.longestSide * .008)  ,),
                                          Divider(),
                                          Text(decisionDefecha(),style: TextStyle(fontSize: size.longestSide * .008)  ,),
                                          Divider(),
                                          Text(decisionDxMed(),style: TextStyle(fontSize: size.longestSide * .008)  ,),
                                          Divider(),
                                          Text(decisionDxNut(),style: TextStyle(fontSize: size.longestSide * .008)  ,)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: size.longestSide *  .050,
                                      height: size.longestSide * .050,
                                      
                                      decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        borderRadius: BorderRadius.all(Radius.circular(50))),
                                      child: FlatButton(
                                       onPressed: (){ submit();},
                                       child: Text(_textoDelBoton(),style: TextStyle(color: Colors.white,fontSize: size.longestSide * .01),)           
                                      ) ,

                                    )
                                  ],
                                )
                              ],
                            ),
                      ),
                    ) 
                  ),
                ),
                                          //########################## Containers de campos de seleccion  ###########
               camposDeSeleccion(context, 'Datos Generales','datosGeneralesPage'),
               camposDeSeleccion(context, 'Antropometrias','antropometriasPage'),
               camposDeSeleccion(context, 'Laboratorios','laboratoriosPage'),
               camposDeSeleccion(context, 'Antecedentes Patologicos Generales','antecedentesPersonalesPage'),
               camposDeSeleccion(context, '''Antecedentes Patologicos Familiares y antecedentes Personales no Patologicos''','antecedentesFamiliaresYNoPatologicos'),
               camposDeSeleccion(context, 'Frecuencia alimentaria','frecuenciaAlimentariaPage'),
               camposDeSeleccion(context,'Raciones Habituales','racionesHabitualesPage'),
               camposDeSeleccion(context, 'Calculo de la ingesta habitual','calculoDeLaIngestaPage'),
               camposDeSeleccion(context, 'Plan nutricional','planNutricionalpage'),
               camposDeSeleccion(context, 'Nota de evolucion','notaDeEvolucion'),
              ],
            ),
          ),
        ),
    //  ############################################################### Containers de escritorio #########################################################
        Form(
          key: keyForm,
          child:
           Column(
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: [
               hojaDeTrabajo(context, Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: TextFormField(
                   style: TextStyle(fontSize: 25),
                    decoration: InputDecoration(
                   
                      labelText: "Calculo de la ingesta Habitual",
                     
                      filled: true,fillColor: Colors.transparent
                    ), 
                    maxLines: 25,
                    initialValue: expediente.calculoIngesta.toString(),
                 onSaved: (value) => expediente.calculoIngesta = value
          ),
               ), 
          size.longestSide  * .70,
          size.longestSide * .25,
         ),

           hojaDeTrabajo(context, Padding(
             padding: const EdgeInsets.all(8.0),
             child: DataTable( dataTextStyle: TextStyle(fontSize: 5),dataRowHeight: 21,headingRowHeight: 25,columns: datosColumna(elementos), rows: dataRowComidas1()),
           ),size.longestSide * .70 , size.longestSide * .10),

            hojaDeTrabajo(context, Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(maxLines: 1,initialValue: expediente.dxNutCorto.toString(),style: TextStyle(fontSize:  size.longestSide * .01),decoration: InputDecoration(labelText: 'Dx Nutricional'),
                       onSaved: (value) => expediente.dxNutCorto = value, ),
            ), size.longestSide *.30, size.longestSide * .05)
             ],
           ),

        )
      ],
    ),
      ]
      )
    );
  }
  
  
  //###################################################################### Widget de hojas de trabajo ######################
Widget hojaDeTrabajo(BuildContext context,contenido,ancho,alto){
  
  return  SlideInDown(
    duration: Duration(seconds: 1),
      child: 
      
      Scrollbar(
        showTrackOnHover: true,
        radius: Radius.circular(20),
        thickness: 10.0,
        controller: ScrollController(initialScrollOffset: 20,keepScrollOffset: true),
        isAlwaysShown: true,
              child: Container( 
                width: ancho,
                height: alto,
                decoration: BoxDecoration(
                   boxShadow: [
                     BoxShadow(color: Colors.black45,blurRadius: 3.0,offset: Offset(0.0, 5.0),spreadRadius: 2.0)
                  ],
                   color: Colors.white,
                   border: Border.all(
                     color: Colors.blue[300],
                     width: 4
                  ),
                    borderRadius: BorderRadius.only(
                     topRight: Radius.circular(15),
                     bottomRight: Radius.circular(15),
                     topLeft: Radius.circular(15),
                     bottomLeft: Radius.circular(15),
                   )
               ),
                 child: contenido
     ),
      ),
  );
}
  //######################################################################### Widget de Campos de seleccion   ##############
 Widget camposDeSeleccion(BuildContext context,String texto,String ruta){
  final  size = MediaQuery.of(context).size;
  return  Row(
    children: [  
      Container(
       color: Colors.transparent,
        width: size.longestSide * .245,
        height: size.longestSide * .03,
         child: ListTile(
          leading: Icon( Icons.accessibility , color: Colors.deepPurple ),
          //  trailing:  Checkbox( activeColor: Colors.deepPurple ,value: expediente.checkDatosGn, onChanged: (value) => setState((){expediente.checkDatosGn = value;} )) ,
            title: Text(texto,style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic, decoration: TextDecoration.underline, decorationStyle: TextDecorationStyle.wavy,  )),
            onTap: (){
              Navigator.pushReplacementNamed(context,ruta,arguments: expediente);
          }
        ),
      ),
    ],
  );
}

//##################################################################### Widgets de menu de dataTable ###################  

List<DataColumn> datosColumna(valores){
  List<DataColumn> lista = [];
  valores.forEach((element) {lista.add(DataColumn(label: Text(element,textAlign: TextAlign.center,)));});
  return lista;
}

dataRowComidas1(){

  if (expediente.gramosList == null)    {expediente.gramosList     = [gramosClase];}/*else if (expediente.gramosList[0]. == '' ){}*/
  if (expediente.porcentajeList == null){expediente.porcentajeList = [porcentajeClase];}/*else if (expediente.carne2[0].desayunoHab == '' ){}*/
  if (expediente.caloriasList == null)  {expediente.caloriasList   = [caloriasClase];}/*else if (expediente.carne3[0].desayunoHab == '' ){}*/
 
  

  List<DataRow> lista = [

    DataRow(cells: [ 
       DataCell(TextButton(child: Text(macronutrientes[0],textAlign: TextAlign.left,), onPressed: (){})), 
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.gramosList    [0] .ch, onSaved: (value) => expediente.gramosList    [0].ch = value)),
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.porcentajeList[0] .ch, onSaved: (value) => expediente.porcentajeList[0].ch = value)),
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.caloriasList  [0] .ch, onSaved: (value) => expediente.caloriasList  [0].ch = value)),
      
    ]),
    DataRow(cells: [ 
       DataCell(TextButton(child: Text(macronutrientes[1],textAlign: TextAlign.center,), onPressed: (){})), 
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.gramosList    [0] .pts, onSaved: (value) => expediente.gramosList    [0].pts = value)),
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.porcentajeList[0] .pts, onSaved: (value) => expediente.porcentajeList[0].pts = value)),
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.caloriasList  [0] .pts, onSaved: (value) => expediente.caloriasList  [0].pts = value)),
       
    ]),
    DataRow(cells: [ 
       DataCell(TextButton(child: Text(macronutrientes[2],textAlign: TextAlign.center,), onPressed: (){})), 
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.gramosList    [0] .lib, onSaved: (value) => expediente.gramosList    [0].lib = value)),
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.porcentajeList[0] .lib, onSaved: (value) => expediente.porcentajeList[0].lib = value)),
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.caloriasList  [0] .lib, onSaved: (value) => expediente.caloriasList  [0].lib = value)),
    ]),
    DataRow(cells: [ 
       DataCell(TextButton(child: Text(macronutrientes[3],textAlign: TextAlign.center,), onPressed: (){})), 
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.gramosList    [0] .total, onSaved: (value) => expediente.gramosList    [0].total = value)),
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.porcentajeList[0] .total, onSaved: (value) => expediente.porcentajeList[0].total = value)),
       DataCell(TextFormField(textAlign: TextAlign.center,textAlignVertical: TextAlignVertical.center,initialValue: expediente.caloriasList  [0] .total, onSaved: (value) => expediente.caloriasList  [0].total = value)),
       
    ]),
   

  ];
  return lista;
}

   //################################################################## Widgets del boton de guardar ################### 
_textoDelBoton(){
    if (expediente.id == null){
      return 'Guardar';
    }else{
      return 'Renovar';
    }
  }
submit(){
   if (!keyForm.currentState.validate()) return;
   
   keyForm.currentState.save();
  
   if (expediente.id == null){
     expedienteProvider.crearExpedinete(expediente);
  }else{
    expedienteProvider.editarExpedinete(expediente);
  }
  
 }



   decisionDefecha(){
   if(expediente.fecha == null){
     return 'Primera Cita: 00/00/0000';
   }else{return 'Primera Cita ${expediente.fecha[0]}';}
 }
 decisionDxMed(){
   if(expediente.dxMedCorto == null){
     return 'DxMe:';
   }else{return 'DxMe: ${expediente.dxMedCorto}';}
 }
 decisionDxNut(){
   if(expediente.dxNutCorto == null){
     return 'DxNu:';
   }else{return 'DxNu: ${expediente.dxNutCorto}';}
 }

}





