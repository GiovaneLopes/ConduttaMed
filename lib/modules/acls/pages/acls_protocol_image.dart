import 'package:flutter/material.dart';
import 'package:condutta_med/modules/shared/resources/images.dart';
import 'package:condutta_med/modules/shared/components/default_page.dart';

class AclsProtocolImage extends StatelessWidget {
  const AclsProtocolImage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultPage.withBackButton(
      title: 'Protocolo ACLS',
      body: InteractiveViewer(
        child: Image.asset(
          Images.aclsFlow,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
