import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/Logs/LogController.dart';

class Ingredients extends StatefulWidget {
  const Ingredients({Key? key}) : super(key: key);

  @override
  State<Ingredients> createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  final collectiveController = Get.put(LogController());
  @override
  Widget build(BuildContext context) {
    String water = 'Water';
    String costic = 'Caustic';
    String palm = 'Palm Oil';
    String hard = 'Hard ST';
    String dfa = 'Lauric/DFA';
    String pko = 'PKO';
    String lab = 'Labsa';
    String salt = 'Salt';
    String sv = 'Sodium Versence';
    String tur = 'Turpinol';

    return Card(
      child: Column(
        children: [
          Container(
            child: Text(
              'Quantity of Ingredients',
              style: TextStyle(color: Colors.brown, fontSize: 25),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$water',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.water1st,

                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.water1 =
                                int.tryParse(value) ?? 0;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.water2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.water2 =
                                int.tryParse(value) ?? 0;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.watercir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.water3 =
                                int.tryParse(value) ?? 0;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.watercor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.water4 =
                                int.tryParse(value) ?? 0;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // //validator: (value) {
                          //return homeController.validateShift(value);
                          //},

                          onEditingComplete: () {
                            setState(() {
                              collectiveController.waterAll =
                                  collectiveController.water1 +
                                      collectiveController.water2 +
                                      collectiveController.water3 +
                                      collectiveController.water4;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.waterAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.waterAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$costic',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.costic1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.costic1 =
                                int.tryParse(value) ?? 0;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.costic2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.costic2 =
                                int.tryParse(value) ?? 0;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,

                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.costic3 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.costiccor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.costic4 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.costicAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.costicAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$palm',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.palm1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.palm1 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.palm2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.palm2 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.palmcir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.palm3 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.palmcor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.palm4 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.palmAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.palmAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$hard',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.hard1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.hard1 =
                                int.tryParse(value) ?? 0;
                          },
                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.hard2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.hard2 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.hardcir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.hard3 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.hardcor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.hard4 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.hardAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.hardAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$dfa',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.dfa1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.dfa1 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.dfa2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.dfa2 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.dfacir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.dfa3 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.dfacor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.dfa4 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.dfaAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.dfaAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$pko',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.pko1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.pko1 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.pko2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.pko2 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.pkocir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.pko3 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.pkocor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.pko4 =
                                int.tryParse(value) ?? 0;
                          },
                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.pkoAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.pkoAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$lab',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.lab1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.lab1 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.lab2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.lab2 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.labcir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.lab3 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.labcor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.lab4 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.labAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.labAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$salt',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.salt1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.salt1 =
                                int.tryParse(value) ?? 0;
                          },
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.salt2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.salt2 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.saltcir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.salt3 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.saltcor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.salt4 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.saltAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.saltAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$sv',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.sv1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.sv1 = int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.sv2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.sv2 = int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.svcir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.sv3 = int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.svcor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.sv4 = int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.svAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.svAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  height: 70,
                  //decoration: BoxDecoration(border: Border.all()),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                    child: Center(
                        //child: difference == null?
                        // Text('Loading...')
                        //:
                        child: Text(
                      //child text k liye add ki ha variable k liye remove krni ha
                      '$tur',
                      style: TextStyle(fontSize: 18),
                    )),
                  ),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(width: 1))),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 1st Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.tur1st,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.tur1 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual 2nd Phase',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.tur2nd,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.tur2 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Circulation',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.turcir,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.tur3 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, left: 10),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Actual Correction',
                              style: TextStyle(
                                fontSize: 15,
                              )),
                        ),
                        TextFormField(
                          keyboardType: TextInputType.phone,
                          // controller: collectiveController.turcor,
                          decoration: InputDecoration(
                            hintText: 'Enter in Kg',
                            hintStyle:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                          onChanged: (value) {
                            collectiveController.tur4 =
                                int.tryParse(value) ?? 0;
                          },

                          // : Text(
                          //   homeController.dropDownValue.value,
                          // style: TextStyle(color: Colors.black),

                          style: TextStyle(color: Colors.black, fontSize: 15),

                          // validator: (value) {
                          //return homeController.validateShift(value);
                          //},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(border: Border.all()),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: collectiveController.turAll == null
                          ? Text('Loading...')
                          : Text(
                              //child text k liye add ki ha variable k liye remove krni ha
                              'Total Weight : ${collectiveController.turAll} Kg',
                              style: TextStyle(fontSize: 15),
                            )),
                ),
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                // optional flex property if flex is 1 because the default flex is 1
                flex: 1,
                child: Container(
                  height: 75,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2, left: 10),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Text('FatCharge',
                                style: TextStyle(
                                  fontSize: 15,
                                )),
                          ),
                          Text('${collectiveController.fatAll} Tons',
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                  child: RaisedButton(
                elevation: 10,
                child: Text("Calculate Quantity of Ingredients"),
                onPressed: () {
                  setState(() {
                    collectiveController.waterAll =
                        collectiveController.water1 +
                            collectiveController.water2 +
                            collectiveController.water3 +
                            collectiveController.water4;
                    collectiveController.costicAll =
                        collectiveController.costic1 +
                            collectiveController.costic2 +
                            collectiveController.costic3 +
                            collectiveController.costic4;
                    collectiveController.palmAll = collectiveController.palm1 +
                        collectiveController.palm2 +
                        collectiveController.palm3 +
                        collectiveController.palm4;
                    collectiveController.hardAll = collectiveController.hard1 +
                        collectiveController.hard2 +
                        collectiveController.hard3 +
                        collectiveController.hard4;
                    collectiveController.dfaAll = collectiveController.dfa1 +
                        collectiveController.dfa2 +
                        collectiveController.dfa3 +
                        collectiveController.dfa4;
                    collectiveController.pkoAll = collectiveController.pko1 +
                        collectiveController.pko2 +
                        collectiveController.pko3 +
                        collectiveController.pko4;
                    collectiveController.labAll = collectiveController.lab1 +
                        collectiveController.lab2 +
                        collectiveController.lab3 +
                        collectiveController.lab4;
                    collectiveController.saltAll = collectiveController.salt1 +
                        collectiveController.salt2 +
                        collectiveController.salt3 +
                        collectiveController.salt4;
                    collectiveController.svAll = collectiveController.sv1 +
                        collectiveController.sv2 +
                        collectiveController.sv3 +
                        collectiveController.sv4;
                    collectiveController.turAll = collectiveController.tur1 +
                        collectiveController.tur2 +
                        collectiveController.tur3 +
                        collectiveController.tur4;
                    collectiveController.fatAll =
                        ((collectiveController.palmAll +
                                collectiveController.hardAll +
                                collectiveController.dfaAll +
                                collectiveController.pkoAll +
                                collectiveController.labAll) /
                            1000);
                  });
                },
              ))
            ],
          )
        ],
      ),
    );
  }
}
