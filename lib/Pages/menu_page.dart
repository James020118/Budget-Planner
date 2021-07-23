import 'package:flutter/material.dart';
import 'package:beyond_helpers/beyond_helpers.dart';

import 'package:budget_planner/models/rounded_corner_button.dart';
import 'menu_page_view_model.dart';

class MenuPage extends StatelessWidget {
  final MenuPageViewModel viewModel;

  MenuPage(this.viewModel);

  @override
  Widget build(BuildContext context) {
    return ViewModelRoot(
      viewModel: viewModel,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: _buildAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  PreferredSize _buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          color: Colors.grey[900],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(viewModel.allExpenseCategories);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                'Options',
                style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(width: MediaQuery.of(context).size.width / 9, height: 0.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RoundedCornerButton(
              'Clear Month',
              buttonBorderColor: Colors.red,
              buttonColor: Colors.red,
              textColor: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: _buildDialogBody,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDialogBody(BuildContext dialogContext) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Are you sure to clear month?',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RoundedCornerButton(
                    'Clear',
                    buttonColor: Colors.grey[800]!,
                    isTextBold: true,
                    onPressed: () {
                      viewModel.clearCategoriesAndPop(dialogContext);
                    },
                  ),
                  RoundedCornerButton(
                    'Cancel',
                    buttonColor: Colors.grey[800]!,
                    buttonBorderColor: Colors.red,
                    textColor: Colors.red,
                    isTextBold: true,
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
