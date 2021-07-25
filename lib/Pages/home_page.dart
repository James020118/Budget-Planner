import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/services.dart';

import 'package:budget_planner/Pages/menu_page.dart';
import 'package:budget_planner/models/expense_card.dart';
import 'detail_page.dart';
import 'package:budget_planner/models/custom_dialog.dart';
import 'package:budget_planner/models/rounded_corner_button.dart';
import 'package:budget_planner/Pages/menu_page_view_model.dart';
import 'package:budget_planner/Pages/home_page_view_model.dart';
import 'package:budget_planner/Pages/detail_page_view_model.dart';
import '../util.dart';

class HomePage extends StatefulWidget {
  final HomePageViewModel viewModel;

  HomePage(this.viewModel);

  @override
  _HomePageState createState() => _HomePageState(viewModel);
}

class _HomePageState extends State<HomePage> {
  final HomePageViewModel viewModel;

  _HomePageState(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 12,
            ),
            _buildBudgetDetail1(),
            _buildBudgetDetail2(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              child: Text(
                'Details',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildExpenseCardList(),
            _buildBottomButtonRow(),
          ],
        ),
      ),
    );
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(55),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey[900]!,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width / 9, height: 0.0),
              Text(
                'Budget Planner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuPage(
                        MenuPageViewModel(
                            allExpenseCategories: viewModel.categoryList),
                      ),
                    ),
                    // ignore: unnecessary_lambdas
                  ).then((value) {
                    viewModel.setMenuPageAndDetailPageReturn(value);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBudgetDetail1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Observer(
        builder: (_) {
          return RichText(
            text: TextSpan(
              text: '\$${viewModel.totalExpense.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 25,
                color: viewModel.totalExpense > viewModel.totalBudget
                    ? Colors.red
                    : Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Avenir Next Rounded',
              ),
              children: [
                TextSpan(
                  text: ' / \$${viewModel.totalBudget}',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[400],
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Avenir Next Rounded',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBudgetDetail2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Observer(
        builder: (_) {
          return RichText(
            text: TextSpan(
              text: 'remaining: ',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
                fontFamily: 'Avenir Next Rounded',
              ),
              children: [
                TextSpan(
                  text: '\$${viewModel.moneyLeft.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 25,
                    color: viewModel.moneyLeft >= 0 ? Colors.white : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Avenir Next Rounded',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExpenseCardList() {
    return Observer(
      builder: (_) {
        return Expanded(
          child: viewModel.isLoadingData
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
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
                            viewModel.deleteCategory(index);
                          },
                        ),
                      ],
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExpenseDetailPage(
                                DetailPageViewModel(
                                  allExpense: viewModel.categoryList,
                                  index: index,
                                  selectedCategory:
                                      viewModel.categoryList[index],
                                  titleIcon: Util.getIcon(index),
                                  titleColor: Util.getColor(index),
                                ),
                              ),
                            ),
                            // ignore: unnecessary_lambdas
                          ).then((value) {
                            viewModel.setMenuPageAndDetailPageReturn(value);
                          });
                        },
                        onLongPress: () {
                          createCustomDialogWithTextField(
                            context: context,
                            title: 'Change Name',
                            button1Text: 'Change',
                            button2Text: 'Cancel',
                            controller: viewModel
                                .changeCategoryNameTextEditingController,
                            textFieldLabelText: 'Category Name',
                            textFieldPrefilledString:
                                viewModel.categoryList[index].name,
                            createReturnObject: viewModel.chaneNameDialogReturn,
                          ).then((value) {
                            viewModel.setChangeCategoryNameDialogReturn(
                                value, index);
                          });
                        },
                        child: ExpenseCard(
                          categoryList: viewModel.categoryList,
                          index: index,
                        ),
                      ),
                    );
                  },
                  itemCount: viewModel.categoryList.length,
                ),
        );
      },
    );
  }

  Widget _buildBottomButtonRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RoundedCornerButton(
            'Add Category',
            buttonColor: Colors.grey[800]!,
            onPressed: () {
              createCustomDialogWithTextField(
                context: context,
                title: 'New Category',
                button1Text: 'Add',
                button2Text: 'Cancel',
                controller: viewModel.newCategoryTextEditingController,
                textFieldLabelText: 'Category Name',
                createReturnObject: viewModel.newCategoryDialogReturn,
                // ignore: unnecessary_lambdas
              ).then((value) {
                viewModel.setAddCategoryDialogReturn(value);
              });
            },
          ),
          RoundedCornerButton(
            'Modify Budget',
            buttonColor: Colors.grey[800]!,
            onPressed: () {
              createCustomDialogWithTextField(
                context: context,
                title: 'Enter New Budget',
                button1Text: 'Modify',
                button2Text: 'Cancel',
                controller: viewModel.budgetTextEditingController,
                textFieldLabelText: 'Budget',
                textFieldHintText: 'Numbers Only',
                textFieldInputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                ],
                createReturnObject: viewModel.modifyBudgetDialogReturn,
                // ignore: unnecessary_lambdas
              ).then((value) {
                viewModel.setChangeBudgetDialogReturn(value);
              });
            },
          )
        ],
      ),
    );
  }
}
