import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github/pages/issue/issue.dart';

class IssuePageFilter extends StatefulWidget {
  const IssuePageFilter({super.key, required this.user, required this.onRefetch, required this.variables});

  final String user;
  final VoidCallback onRefetch;
  final IssueFilter variables;

  @override
  State<StatefulWidget> createState() {
    return _IssuePageFilterState();
  }
}

class _IssuePageFilterState extends State<IssuePageFilter> {
  Widget _buildStatesSelector() {
    return DropdownMenu(
      initialSelection: IssueFilterViaStates.all,
      inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(),
      ),
      dropdownMenuEntries: [
        ...IssueFilterViaStates.values.map((e) {
          return DropdownMenuEntry(value: e, label: e.label);
        }),
      ],
      onSelected: (value) {
        // 过滤掉“全部”
        if (value == IssueFilterViaStates.all) {
          widget.variables.states = null;
        } else {
          widget.variables.states = [value!];
        }
        widget.onRefetch();
      },
    );
  }

  Widget _buildFilterBySelector() {
    return DropdownMenu(
      initialSelection: IssueFilterViaFiltersKey.createdBy,
      inputDecorationTheme: const InputDecorationTheme(
        border: UnderlineInputBorder(),
      ),
      dropdownMenuEntries: [
        ...IssueFilterViaFiltersKey.values.map((e) {
          return DropdownMenuEntry(value: e, label: e.label);
        }),
      ],
      onSelected: (value) {
        if (value == IssueFilterViaFiltersKey.viewerSubscribed) {
          widget.variables.filterBy = IssueFilterViaFilters().setValue(value!.value, true);
        } else {
          widget.variables.filterBy = IssueFilterViaFilters().setValue(value!.value, widget.user);
        }
        widget.onRefetch();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildStatesSelector(),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: _buildFilterBySelector(),
            ),
          ],
        ),
      ),
    );
  }
}
