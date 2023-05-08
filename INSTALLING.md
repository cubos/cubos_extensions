# Use this package as a library

1. Depend on it

    Add this to your package's pubspec.yaml file:

    ```flutter
    dependencies:
        rubik_utils: ^0.0.2
    ```

2. Install it

    You can install packages from the command line:
    with Flutter:

    ```bash
    flutter pub get
    ```

    Alternatively, your editor might support flutter pub get. Check the docs for your editor to
    learn more.

3. Import it
    Now in your Dart code, you can use:

    ```flutter
    import 'package:rubik_utils/rubik_utils.dart';

    void main(){
        print('hello'.isNull); // Hello world!
        print('rubik'.isInstanceOf<int>()); // false
        print('hello word!'.capitalize()); // Hello world!

        final schema = RubikValidationsBuilder.strings().minLength(3).maxLength(10);
        print(schema.validate('rubik')); // null

        print(RString().minLength(3).maxLength(10).validate('rubik')) // null
    }
    ```
