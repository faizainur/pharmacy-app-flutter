// import 'package:flutter/material.dart';

// import 'package:pharmacy_app/services/shared_preferences_service.dart';

// import 'package:graphql_flutter/graphql_flutter.dart';

// class Config {
//   static final HttpLink httpLink = HttpLink(
//     uri: 'http://34.226.136.197/v1/graphql',
//   );

//   static final AuthLink authLink =
//       AuthLink(getToken: () async => await sharedPreferenceService.token);

//   static final WebSocketLink websocketLink = WebSocketLink(
//     url: 'wss://34.226.136.197/v1/graphql',
//     config: SocketClientConfig(
//       autoReconnect: true,
//       inactivityTimeout: Duration(seconds: 30),
//     ),
//   );

//   static final Link link =
//       authLink.concat(httpLink as Link).concat(websocketLink);

//   static ValueNotifier<GraphQLClient> initailizeClient() {
//     ValueNotifier<GraphQLClient> client = ValueNotifier(
//       GraphQLClient(
//         cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
//         link: link,
//       ),
//     );

//     return client;
//   }
// }


import "package:flutter/material.dart";
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfiguration {
  static HttpLink httpLink = HttpLink(
    uri: "http://34.226.136.197/v1/graphql",
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink as Link,
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    ),
  );

  GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
      link: httpLink as Link,
    );
  }
}
