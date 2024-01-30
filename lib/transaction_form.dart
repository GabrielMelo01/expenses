import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();

  // GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _submitForm() {
    final title = _titleController.text;
    final value = double.parse(_valueController.text.replaceAll(",", "."));
    final date = _selectedDate ?? DateTime.now();
    if (title.isEmpty || value <= 0) {
      return;
    }
    widget.onSubmit(title, value, date);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      setState(() {
        _selectedDate = value;
        print(_selectedDate);
      });
    });
    print('Executado!');
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
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                  ),
                ),
                TextFormField(
                  controller: _valueController,
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
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _selectedDate == null
                              ? 'Nenhuma data selecionada!'
                              : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate!)}',
                        ),
                      ),
                      TextButton(
                        onPressed: _showDatePicker,
                        child: const Text(
                          'Selecionar Data',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Nova Transação'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
