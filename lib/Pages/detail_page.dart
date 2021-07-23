import 'package:budget_planner/Pages/detail_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:beyond_helpers/beyond_helpers.dart';

import 'package:budget_planner/models/detail_card.dart';
import 'package:budget_planner/models/transaction_dialog.dart';

class ExpenseDetailPage extends StatefulWidget {
  final DetailPageViewModel viewModel;

  ExpenseDetailPage(this.viewModel);

  @override
  _ExpenseDetailPageState createState() => _ExpenseDetailPageState(viewModel);
}

class _ExpenseDetailPageState extends State<ExpenseDetailPage> {
  final DetailPageViewModel viewModel;

  _ExpenseDetailPageState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ViewModelRoot(
      viewModel: viewModel,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(viewModel.allExpense);
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
            Observer(
              builder: (_) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: viewModel.titleColor,
                          shape: BoxShape.circle,
                        ),
                        child: viewModel.titleIcon,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          '${viewModel.selectedCategory.name} \$${viewModel.selectedCategory.expense.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GestureDetector(
                onTap: () {
                  addTransactionDialog(context).then((value) {
                    if (value != null) {
                      viewModel.addTransaction(value);
                    }
                  });
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Row(
              children: <Widget>[
                Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Observer(builder: (_) {
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Slidable(
                    key: ValueKey(index),
                    actionPane: SlidableDrawerActionPane(),
                    dismissal: SlidableDismissal(
                      child: SlidableDrawerDismissal(),
                    ),
                    secondaryActions: [
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          viewModel.removeTransaction(index);
                        },
                      ),
                    ],
                    child: GestureDetector(
                      child: DetailCard(
                        details: viewModel.selectedCategory.dets,
                        index: index,
                      ),
                    ),
                  );
                },
                itemCount: viewModel.selectedCategory.dets.length,
              ),
            );
          }),
        ],
      ),
    );
  }
}
