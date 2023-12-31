import 'package:flutter/material.dart';
import 'package:contacts_buddy/helper.dart';

import 'contacts.dart';

class AddContacts extends StatefulWidget {
  AddContacts({Key? key, this.contact}) : super(key: key);
  //here i add a variable
  //it is not a required, but use this when update
  final Contact? contact;

  @override
  State<AddContacts> createState() => _AddContactsState();
}

class _AddContactsState extends State<AddContacts> {
  //for TextField
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void initState() {
    //when contact has data, mean is to update
    //instead of create new contact
    if (widget.contact != null) {
      _nameController.text = widget.contact!.name;
      _contactController.text = widget.contact!.contact;
    }
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Contact'),
        foregroundColor: Colors.white,
        backgroundColor: Color.fromARGB(255, 47, 66, 236),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(false),
          //to prevent back button pressed without add/update
        ),
      ),
      body: Center(
        //create two text field to key in name and contact
        child: SingleChildScrollView(
          padding: EdgeInsets.all(5),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildTextField(_nameController, 'Name'),
              SizedBox(
                height: 30,
              ),
              _buildTextField(_contactController, 'Contact'),
              SizedBox(
                height : 450,
              ),
              ElevatedButton(
                style: FilledButton.styleFrom(foregroundColor: Color.fromARGB(255, 255, 255, 255), backgroundColor: Color.fromARGB(255, 47, 66, 236),minimumSize: Size(360, 50),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
                //this button is pressed to add contact
                onPressed: () async {
                  //if contact has data, then update existing list
                  //according to id
                  //else create a new contact
                  if (widget.contact != null) {
                    await DBHelper.updateContacts(Contact(
                      id: widget.contact!.id, //have to add id here
                      name: _nameController.text,
                      contact: _contactController.text,
                    ));

                    Navigator.of(context).pop(true);
                  } else {
                    await DBHelper.createContacts(Contact(
                      name: _nameController.text,
                      contact: _contactController.text,
                    ));

                    Navigator.of(context).pop(true);
                  }
                },
                
                child: Text('Create'),
                
                
                
              ),
            ],
          ),
        ),
      ),
    ));
  }

  //build a text field method
  TextField _buildTextField(TextEditingController _controller, String hint) {
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 47, 66, 236))),
        floatingLabelStyle: TextStyle(color:Color.fromARGB(255, 47, 66, 236),
      ),
    ));
  }
}



