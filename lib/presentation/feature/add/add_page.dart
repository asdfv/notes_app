import 'package:domain/coordinators/notes_coordinator.dart';
import 'package:domain/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation/utils/utils.dart';

import 'add_bloc.dart';
import 'add_event.dart';
import 'add_state.dart';

class AddPage extends StatelessWidget {
  final NotesCoordinator coordinator;
  static final String route = "/add";

  AddPage({Key key, @required this.coordinator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddBloc>(
      create: (_) => AddBloc(coordinator),
      child: Builder(
        builder: (ctx) => Scaffold(
          key: key,
          appBar: AppBar(
            title: Text("Add note"),
          ),
          body: BlocBuilder<AddBloc, AddState>(builder: (context, state) => _buildWidgetFor(context, state)),
        ),
      ),
    );
  }

  Widget _buildWidgetFor(BuildContext context, AddState state) {
    switch (state.runtimeType) {
      case Initial:
        return _createInitialWidget();
      case Loading:
        return _createLoadingWidget();
      case Saved:
        {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context, (state as Saved).note);
          });
          return _createLoadingWidget();
        }
      case Failed:
        return _createErrorWidget(state as Failed);
      default:
        return _createErrorWidget();
    }
  }

  Widget _createErrorWidget([Failed state]) {
    if (state == null) {
      return Text("Error happened, oh my god!");
    } else {
      return Text("Error happened: ${state.reason}. Cause: ${state.cause}.");
    }
  }

  Widget _createLoadingWidget() => Center(child: CircularProgressIndicator());

  Widget _createInitialWidget() => AddNoteForm();
}

class AddNoteForm extends StatefulWidget {
  @override
  AddNoteFormState createState() => AddNoteFormState();
}

class AddNoteFormState extends State<AddNoteForm> {
  static final _titleLabel = 'title';
  static final _descriptionLabel = 'description';
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> fields = {_titleLabel: null, _descriptionLabel: null};

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            onSaved: (value) {
              fields[_titleLabel] = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter title',
              labelText: 'Title',
            ),
            keyboardType: TextInputType.text,
            validator: _validator,
          ),
          TextFormField(
            onSaved: (value) {
              fields[_descriptionLabel] = value;
            },
            decoration: const InputDecoration(
              hintText: 'Enter description',
              labelText: 'Description',
            ),
            keyboardType: TextInputType.text,
            validator: _validator,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                  _submitForm(BlocProvider.of<AddBloc>(context));
                } else {
                  context.snack("Your form is invalid!");
                }
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  String _validator(value) {
    if (value.length < 3) {
      return 'Please enter some text longer than 3 symbols';
    }
    return null;
  }

  void _submitForm(AddBloc bloc) {
    var title = fields[_titleLabel];
    var description = fields[_descriptionLabel];
    final note = Note(title: title, description: description, created: DateTime.now().millisecondsSinceEpoch);
    bloc.add(Save(note));
  }
}
