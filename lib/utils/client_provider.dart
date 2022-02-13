 import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:zp_assignment/utils/graphql_client_provider.dart';

class ClientProvider extends StatelessWidget {
  ClientProvider({Key? key, 
    required this.child,
    required String uri,
    String? subscriptionUri,
  }) : client = clientFor(
          uri: uri,
          subscriptionUri: subscriptionUri,
        ), super(key: key);

  final Widget child;
  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: child,
    );
  }
}