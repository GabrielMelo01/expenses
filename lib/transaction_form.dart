import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final valueController = TextEditingController();

  // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _submitForm() {
    final title = titleController.text;
    final value = double.parse(valueController.text.replaceAll(",", "."));
    if(title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value);
  }

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
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onFieldSubmitted: (_) => _submitForm(),
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
                      onPressed: _submitForm,
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
