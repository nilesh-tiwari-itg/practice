// import 'package:flutter/material.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class ChatScreen extends StatefulWidget {
//   final String userId; // Current user ID
//   final String friendId; // Friend's user ID

//   ChatScreen({required this.userId, required this.friendId});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   IO.Socket? socket;
//   TextEditingController messageController = TextEditingController();
//   List<Map<String, dynamic>> messages = [];

//   @override
//   void initState() {
//     super.initState();
//     connectToSocket();
//   }

//   final String SERVER_URL = 'https://your-server-url.ngrok-free.app/';

//   void connectToSocket() {
//     socket = IO.io(SERVER_URL, <String, dynamic>{
//       'transports': ['websocket'],
//     });

//     socket!.onConnect((_) {
//       print('Connected to server');

//       // Join a private chat room
//       socket!.emit('joinChat', {
//         'sender': widget.userId,
//         'receiver': widget.friendId,
//       });
//     });

//     // Load chat history
//     socket!.on('currentHistory', (data) {
//       setState(() {
//         messages = List<Map<String, dynamic>>.from(data);
//       });
//     });

//     // Listen for new messages
//     socket!.on('addNewMessage', (data) {
//       setState(() {
//         messages.add(data);
//       });
//     });
//   }

//   void sendMessage() {
//     if (messageController.text.isNotEmpty) {
//       final message = {
//         'sender': widget.userId,
//         'receiver': widget.friendId,
//         'text': messageController.text,
//         'createdAt': DateTime.now().toIso8601String(),
//       };

//       socket!.emit('addNewMessage', message); // Send to server
//       setState(() {
//         messages.add(message); // Update UI
//       });

//       messageController.clear();
//     }
//   }

//   @override
//   void dispose() {
//     socket!.disconnect();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Chat with ${widget.friendId}')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: messages.length,
//               itemBuilder: (context, index) {
//                 final msg = messages[index];
//                 bool isMe = msg['sender'] == widget.userId;
//                 return Align(
//                   alignment:
//                       isMe ? Alignment.centerRight : Alignment.centerLeft,
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                     decoration: BoxDecoration(
//                       color: isMe ? Colors.blue : Colors.grey[300],
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Text(msg['text']),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: messageController,
//                     decoration: InputDecoration(labelText: 'Type a message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
