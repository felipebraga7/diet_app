import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class SearchInputField extends StatefulWidget {
  final double width;
  final String hint;
  final int debounceDuration;
  final bool emitSameValue;
  final bool emitEmpty;
  final Function(String) onText;
  final TextEditingController? textController;

  const SearchInputField({
    super.key,
    this.width = double.infinity,
    this.hint = '',
    this.debounceDuration = 250,
    this.emitSameValue = false,
    this.emitEmpty = true,
    this.textController,
    required this.onText,
  });

  @override
  State<SearchInputField> createState() => _SearchInputFieldState();
}

class _SearchInputFieldState extends State<SearchInputField> {
  late TextEditingController searchController;
  late StreamSubscription<String> subscription;

  @override
  void initState() {
    super.initState();
    searchController = widget.textController == null ? TextEditingController() : widget.textController!;

    final subject = BehaviorSubject<String>();
    subscription = subject.stream
        .debounceTime(Duration(milliseconds: widget.debounceDuration))
        .where((value) => value.isNotEmpty || widget.emitEmpty)
        .distinct((previous, next) => previous == next && !widget.emitSameValue)
        .listen(widget.onText);

    searchController.addListener(() {
      subject.add(searchController.text);
    });
  }

  @override
  void dispose() {
    if (widget.textController == null) searchController.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: widget.width,
      child: TextFormField(
        controller: searchController,
        keyboardType: TextInputType.text,
        style: textTheme.titleMedium!.copyWith(
          fontWeight: FontWeight.w500,
        ),
        cursorColor: colorScheme.onSecondary,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          filled: true,
          fillColor: colorScheme.surface,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.surface),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: colorScheme.surface),
          ),
          prefixIcon: Icon(
            Icons.search,
            color: colorScheme.inverseSurface,
          ),
          suffixIcon: GestureDetector(
              child: Icon(
                Icons.close,
                color: colorScheme.inverseSurface,
              ),
              onTap: () => searchController.text = ''),
          hintText: widget.hint,
          hintStyle: textTheme.labelMedium!.copyWith(
            color: colorScheme.inverseSurface,
          ),
        ),
      ),
    );
  }
}
