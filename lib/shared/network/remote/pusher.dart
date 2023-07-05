import 'package:pusher_client/pusher_client.dart';

import '../../constants/constants.dart';

PusherOptions options = PusherOptions(
  host: 'sms.gxadev.me',
  // wsPort: 6001,
  encrypted: false,
  cluster: 'eu',
  auth: PusherAuth(
    'https://sms.gxadev.me/api/broadcasting/auth',
    headers: {
      'Authorization': 'Bearer $token',
    },
  ),
);
//
// PusherClient pusher = PusherClient(
//     '524e630aa73c7b3d9752',
//     options,
//     autoConnect: false,
//
// );

PusherClient? pusher;
void connectPusher() {
  pusher = PusherClient(
    '524e630aa73c7b3d9752',
    options,
  );

  pusher?.connect();

  pusher?.onConnectionStateChange((state) {
    print('Pusher connection state: $state');
  });
  pusher?.onConnectionError((error) {
    print('Pusher connection error: $error');
  });
}
