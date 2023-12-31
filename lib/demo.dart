import 'package:flutter/material.dart';
import 'package:contacts_buddy/add_contact.dart';
import 'package:contacts_buddy/contacts.dart';
import 'package:contacts_buddy/helper.dart';
import 'package:contacts_buddy/view_contact.dart';



class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);
  

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {

  
  @override
  Widget build(BuildContext context) {
    
    var scaffold = Scaffold(
      
      appBar: AppBar(
        title: const Text('Contacts'),
            foregroundColor: Colors.white,
             backgroundColor: const Color.fromARGB(255, 47, 66, 236),
          automaticallyImplyLeading: false,
      ),

      //add Future Builder to get contacts
      body: FutureBuilder<List<Contact>>(
        future: DBHelper.readContacts(), //read contacts list here
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> snapshot) {
          //if snapshot has no data yet
          if (!snapshot.hasData) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Loading...'),
                ],
              ),
            );
          }
          //if snapshot return empty [], show text
          //else show contact list
          return snapshot.data!.isEmpty
              ? const Center(
                  child: Text('No contacts in your list'),
                )
              : ListView(
                  children: snapshot.data!.map((contacts) {
                    return Center(
                      child: ListTile(
                        title: Text(contacts.name),
                        subtitle: Text(contacts.contact),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          color:const Color.fromARGB(255, 234, 48, 48),
                          onPressed: () async {
                            await DBHelper.deleteContacts(contacts.id!);
                            setState(() {
                              //rebuild widget after delete
                            });
                          },
                        ),
                        onTap: () async {
                          //tap on ListTile, for update
                          final refresh = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (_) => ViewContact(
                                        contact: Contact(
                                          id: contacts.id,
                                          name: contacts.name,
                                          contact: contacts.contact,
                                        ),
                                      )));

                          if (refresh) {
                            setState(() {
                              //if return true, rebuild whole widget
                            });
                          }
                        },
                      ),
                    );
                  }).toList(),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 47, 66, 236),
        onPressed: () async {
          final refresh = await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => AddContacts()));

          if (refresh) {
            setState(() {
              //if return true, rebuild whole widget
            });
            
          }
        },
        child: const Icon(Icons.add),
      ),
    );
    return scaffold;
  }
}