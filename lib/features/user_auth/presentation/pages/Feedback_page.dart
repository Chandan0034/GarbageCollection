import 'package:flutter/material.dart';

class FeedBackPage extends StatefulWidget {
  const FeedBackPage({super.key});

  @override
  State<FeedBackPage> createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {
  TextEditingController _locationController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Garbage Report Feedback'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle the submission of the feedback
                String location = _locationController.text;
                String description = _descriptionController.text;

                // You can send this data to a backend server, Firebase, or any storage mechanism for further processing
                // Optionally, you can also add validation and error handling here

                // Clear the input fields after submission
                _locationController.clear();
                _descriptionController.clear();

                // Provide feedback to the user (e.g., a success message)
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Feedback submitted successfully!'),
                  ),
                );
              },
              child: Text('Submit Feedback'),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed to prevent memory leaks
    _locationController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
