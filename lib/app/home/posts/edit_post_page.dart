import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tellus_mockup/app/home/models/post.dart';
import 'package:tellus_mockup/common_widgets/platform_exception_alert_dialog.dart';
import 'package:tellus_mockup/services/database.dart';

class EditPostPage extends StatefulWidget {
  const EditPostPage({Key key, @required this.database, this.post})
      : super(key: key);
  final Database database;
  final Post post;

  static Future<void> show(
      BuildContext context, {
        Database database,
        Post post,
  }) async {
    await Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => EditPostPage(database: database, post: post),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _EditPostPageState createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _formKey = GlobalKey<FormState>();

  String _title;
  String _speaker;
  String _description;
  String _url;
  String _img;
  int _fee;
  List<String> _selectedItems = ['biz', 'game', 'green', 'sea', 'sky', 'town'];

  @override
  void initState() {
    super.initState();
    if (widget.post != null) {
      _title = widget.post.title;
      _speaker = widget.post.speaker;
      _description = widget.post.description;
      _url = widget.post.url;
      _img = widget.post.img;
      _fee = widget.post.fee;
    }
  }

  bool _validateAndSaveForm() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    print(_img);

    if (_validateAndSaveForm()) {
      try {
        final postId = widget.post?.postId ?? documentIdFromCurrentDate();
        final post = Post(postId: postId,
            title: _title,
            speaker: _speaker,
            description: _description,
            url: _url,
            img: _img,
            fee: _fee);
        await widget.database.setPost(post);
        Navigator.of(context).pop();
      } on PlatformException catch (e) {
        PlatformExceptionAlertDialog(
          title: 'Operation failed',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text(widget.post == null ? 'New Post' : 'Edit Post'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _submit,
          ),
        ],
      ),
      body: _buildContents(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContents() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Post title'),
        initialValue: _title,
        validator: (value) => value.isNotEmpty ? null : 'Title can\'t be empty',
        onSaved: (value) => _title = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Speaker name'),
        initialValue: _speaker,
        validator: (value) => value.isNotEmpty ? null : 'Speaker can\'t be empty',
        onSaved: (value) => _speaker = value,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Description'),
        initialValue: _description,
        //validator: (value) => value.isNotEmpty ? null : 'Description can\'t be empty',
        onSaved: (value) => _description = value,
        maxLines: null,
        keyboardType: TextInputType.multiline,
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Room URL'),
        initialValue: _url,
        validator: (value) => value.isNotEmpty ? null : 'URL can\'t be empty',
        onSaved: (value) => _url = value,
      ),
      SizedBox(height: 24.0),
      Row(
        children: <Widget>[
          Text(
            'Thum image      ',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          DropdownButton<String> (
            value: _img,
            onChanged: (String string) => setState(() => _img = string),
            selectedItemBuilder: (BuildContext context) {
              return _selectedItems.map<Widget>((String item) {
                return Text(item);
              }).toList();
            },
            items: _selectedItems.map((String item) {
              return DropdownMenuItem<String>(
                child: Text('$item'),
                value: item,
              );
            }).toList(),
          ),
        ],
      ),
      TextFormField(
        decoration: InputDecoration(labelText: 'Fee'),
        initialValue: _fee != null ? '$_fee' : null,
        validator: (value) => value.isNotEmpty ? null : 'Fee can\'t be empty',
        onSaved: (value) => _fee = int.tryParse(value) ?? 0,
      ),
    ];
  }
}


