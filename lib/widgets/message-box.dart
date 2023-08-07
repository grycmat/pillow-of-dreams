import 'package:flutter/material.dart';

class MessageBox extends StatefulWidget {
  MessageBox({required this.onSend, Key? key}) : super(key: key);

  Function onSend;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return // Generated code for this material_MessageBox Widget...
        Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 44),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type here to respond...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        EdgeInsetsDirectional.fromSTEB(12, 24, 20, 24),
                  ),
                  maxLines: 5,
                  minLines: 1,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
              child: IconButton(
                icon: Icon(
                  Icons.send_rounded,
                  color: Color(0xFF06D5CD),
                  size: 30,
                ),
                onPressed: () {
                  widget.onSend(_controller.text);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
