import 'package:firebase_sample/apis/users_api/models/user_model.dart';
import 'package:firebase_sample/utilities/extensions.dart';
import 'package:firebase_sample/widgets/widget_spacer.dart';
import 'package:flutter/material.dart';

class ReadOnlyFields extends StatelessWidget {
  const ReadOnlyFields({
    this.reporter,
    this.creationDate,
    this.spacing = 15.0,
    Key? key,
  }) : super(key: key);

  final UserModel? reporter;
  final DateTime? creationDate;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VerticalSpacer(25),
        Text(
          '${creationDate!.format('yMMMMd')}, ${creationDate!.format('jm')}',
          style: textTheme.bodyText2,
        ),
        VerticalSpacer(5),
        Text(
          'Created',
          style: textTheme.subtitle1,
        ),
        VerticalSpacer(spacing),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '${reporter!.fullName}(',
                style: textTheme.bodyText2,
              ),
              TextSpan(
                text: '${reporter!.email}',
                style: textTheme.bodyText2!.copyWith(color: Colors.green),
              ),
              TextSpan(
                text: ')',
                style: textTheme.bodyText2,
              ),
            ],
          ),
        ),
        VerticalSpacer(5),
        Text(
          'Reporter',
          style: textTheme.subtitle1,
        ),
      ],
    );
  }
}
