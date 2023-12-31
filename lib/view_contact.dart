import 'package:flutter/material.dart';
import 'package:contacts_buddy/helper.dart';
import 'package:contacts_buddy/contacts.dart';

class ViewContact extends StatefulWidget {
  const ViewContact({Key? key, this.contact}) : super(key: key);
  final Contact? contact;

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
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
      title: const Text('Contact Details'),
      foregroundColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 47, 66, 236),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.of(context).pop(false),
        //to prevent back button pressed without add/update
      ),
    ),
    body: Center(
      //create two text field to key in name and contact
      child: SingleChildScrollView(
          padding: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildTextField(_nameController, 'Name'),
            const SizedBox(
              height: 30,
            ),
            _buildTextField(_contactController, 'Contact'),
            const SizedBox(
              height: 450,
            ),
          
              FilledButton(
              style: FilledButton.styleFrom(backgroundColor: const Color.fromARGB(255, 47, 66, 236),minimumSize: const Size(360, 50),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),),
              //this button is pressed to add contact
              onPressed: () async { 
                      
                //if contact has data, then update existing list
                //according to id
                //else create a new contact
                await DBHelper.updateContacts(Contact(
                  id: widget.contact!.id, //have to add id here
                  name: _nameController.text,
                  contact: _contactController.text,
                ));
                Navigator.of(context).pop(true);
              },
              child: const Text('Update Details'),
              
            ),
          ],
        ),
      ),
    ),
  ));
}
         
}

//View contacts as same as create

  TextField _buildTextField(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Color.fromARGB(255, 47, 66, 236))),
        floatingLabelStyle: const TextStyle(color:Color.fromARGB(255, 47, 66, 236),
      ),
    ));
  }

  