import 'package:flutter/material.dart';
import 'package:flutter_my_own_first_app/data/cities.dart';

class AutocompleteBasic extends StatelessWidget {
  const AutocompleteBasic({Key? key}) : super(key: key);

  static final List<String> _kOptions = cities;

  @override
  Widget build(BuildContext context) {
    print(_kOptions);
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        // print(textEditingValue.text);
        var newText = textEditingValue.text.toLowerCase();
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        debugPrint('You just selected $selection');
      },
    );
  }
}
