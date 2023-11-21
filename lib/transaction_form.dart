import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  // GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            // key: formKey,
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                TextFormField(
                  controller: valueController,
                  decoration: const InputDecoration(
                    labelText: 'Valor (R\$)',
                  ),
                  keyboardType: TextInputType.datetime,
                  // validator: (value) {
                  //   if(value!.isEmpty) {
                  //     return "Campo nao pode ser vazio!";
                  //   }
                  // },
                  autovalidateMode: AutovalidateMode.always,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(primary: Colors.purple),
                      onPressed: () {
                        onSubmit(titleController.text, double.parse(valueController.text));
                        // print(titleController.text);
                        // print(valueController.text);
                        // if(formKey.currentState!.validate()) {
                        //   print("Deu certo!");
                        // }
                      },
                      child: Icon(Icons.add_circle),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
