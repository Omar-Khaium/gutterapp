import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/theme/theme_cubit.dart';
import 'package:gutterapp/data/model/customer.dart';
import 'package:gutterapp/utils/text_styles.dart';
import 'package:gutterapp/utils/theme_helper.dart';

class DashboardCustomerItem extends StatelessWidget {
  final Customer customer;

  DashboardCustomerItem(this.customer);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeHelper(state.value);
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        leading: Icon(Icons.person_rounded, color: theme.iconColor),
                        title: Text(
                          "${customer.firstName} ${customer.lastName}".trim(),
                          style: TextStyles.body(context: context, color: theme.textColor),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        leading: Icon(Icons.phone_rounded, color: theme.iconColor),
                        title: Text(
                          "${customer.primaryPhone}".trim(),
                          style: TextStyles.body(context: context, color: theme.textColor),
                        ),
                      ),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        leading: Icon(Icons.email_rounded, color: theme.iconColor),
                        title: Text(
                          "${customer.emailAddress}".trim(),
                          style: TextStyles.body(context: context, color: theme.textColor),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        leading: Icon(Icons.place_rounded, color: theme.iconColor),
                        title: Text(
                          "${customer.street}\n${customer.city}, ${customer.state} ${customer.zip}".trim(),
                          style: TextStyles.body(context: context, color: theme.textColor),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  splashRadius: 24,
                  icon: CircleAvatar(
                    child: Icon(Icons.delete_forever_rounded, color: theme.errorColor),
                    backgroundColor: theme.errorColor.withOpacity(.1),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
