import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gutterapp/business_logic/dashboard/customers_cubit.dart';
import 'package:gutterapp/business_logic/theme/theme_cubit.dart';
import 'package:gutterapp/business_logic/user/user_cubit.dart';
import 'package:gutterapp/data/model/customer.dart';
import 'package:gutterapp/presentation/widget/dashboard/widget_item.dart';
import 'package:gutterapp/utils/app_router.dart';
import 'package:gutterapp/utils/text_styles.dart';
import 'package:gutterapp/utils/theme_helper.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    final UserState userState = BlocProvider.of<UserCubit>(context).state;
    BlocProvider.of<CustomersCubit>(context).refresh(userState.token!);

    scrollController.addListener(() {
      if (scrollController.position.atEdge && scrollController.position.pixels != 0) {
        BlocProvider.of<CustomersCubit>(context).paginate(userState.token!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final theme = ThemeHelper(state.value);
        return Scaffold(
          backgroundColor: theme.backgroundColor,
          appBar: AppBar(
            title: Text("Dashboard", style: TextStyles.title(context: context, color: theme.accentColor)),
            actions: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.search_rounded, color: theme.accentColor),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.manage_accounts_rounded, color: theme.accentColor),
              ),
              IconButton(
                onPressed: () {
                  BlocProvider.of<UserCubit>(context).logout();
                  Navigator.of(context).pushReplacementNamed(AppRouter.LOGIN);
                },
                icon: Icon(Icons.logout_rounded, color: theme.accentColor),
              ),
            ],
          ),
          body: BlocBuilder<CustomersCubit, CustomersState>(
            builder: (_, state) {
              if (state is CustomersNetworking && state.isFirstPage) {
                return Center(child: CircularProgressIndicator());
              }
              List<Customer> customers = [];
              bool isLoading = false;
              if (state is CustomersNetworking) {
                customers = state.data;
                isLoading = true;
              } else if (state is CustomersSuccess) {
                customers = state.data;
              }

              return ListView.separated(
                controller: scrollController,
                separatorBuilder: (_, index) {
                  return Divider();
                },
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  if (index < customers.length) {
                    final Customer customer = customers[index];
                    return DashboardCustomerItem(customer);
                  } else {
                    Future.delayed(Duration(milliseconds: 1), () {
                      scrollController.jumpTo(scrollController.position.maxScrollExtent);
                    });
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
                itemCount: customers.length + (isLoading ? 1 : 0),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: AlwaysScrollableScrollPhysics(),
              );
            },
          ),
        );
      },
    );
  }
}
