import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../core/viewmodels/add_book_images.dart';

class AddBook extends StatefulWidget {
  final String categoriesName;
  final String subcatname;
  const AddBook({
    Key? key,
    required this.categoriesName,
    required this.subcatname,
  }) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final TextEditingController bookTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Add Books",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<AddBookImages>(
        builder: (context, model, child) {
          return SafeArea(
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Expanded(
                      flex: 10,
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Add Details",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                height: 170,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.imageFile!.length,
                                  itemBuilder: (context, i) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: i == 0 ? 0 : 10),
                                      width: 150,
                                      child: Image.file(
                                        model.imageFile![i].imageFile,
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const Text(
                                "Catagories",
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 1, color: Colors.black38)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        widget.categoriesName,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  widget.subcatname != ""
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.black38)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              widget.subcatname,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              makeInput(
                                label: "Book Name",
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context),
                                  ],
                                ),
                                controller: bookTitle,
                              ),
                              const Text(
                                "About the Book",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              makeInput(
                                label: "Book Price",
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context),
                                  ],
                                ),
                                controller: bookTitle,
                              ),
                              makeInput(
                                label: "About Book",
                                maxLine: 7,
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context),
                                  ],
                                ),
                                controller: bookTitle,
                              ),
                              makeInput(
                                label: "Time Used",
                                validator: FormBuilderValidators.compose(
                                  [
                                    FormBuilderValidators.required(context),
                                  ],
                                ),
                                controller: bookTitle,
                              ),
                              const Text(
                                "Location Detail",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 3, left: 10, bottom: 10, right: 10),
                        child: MaterialButton(
                          minWidth: double.infinity,
                          height: 60,
                          onPressed: () {
                            if (model.subCatId != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddBook(
                                          categoriesName: model
                                              .bookCategories!
                                              .data![model.selectedCatIndex!]
                                              .name!,
                                          subcatname: model
                                              .bookCategories!
                                              .data![model.selectedCatIndex!]
                                              .subcat![
                                                  model.selectedSubCatIndex!]
                                              .name!,
                                        )),
                              );
                            }
                          },
                          color: Colors.green,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: const Text(
                            "Post Book",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
          );
        },
      ),
    );
  }
}

Widget makeInput(
    {label,
    obscureText = false,
    int maxLine = 1,
    Icon? prefixIcon,
    bool issufixIcon = false,
    required TextEditingController controller,
    required FormFieldValidator<String>? validator,
    context}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      Consumer<AddBookImages>(builder: (context, model, child) {
        return Container(
          color: Colors.grey[200],
          child: FormBuilderTextField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller,
            maxLines: maxLine,
            name: "s",
            obscureText: issufixIcon ? !model.isSelected : false,
            validator: validator,
            decoration: InputDecoration(
              hintText: label,
              suffixIcon: issufixIcon
                  ? IconButton(
                      splashRadius: 4,
                      onPressed: () {},
                      icon: Icon(model.isSelected
                          ? Icons.visibility
                          : Icons.visibility_off),
                    )
                  : const SizedBox.shrink(),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey)),
            ),
          ),
        );
      }),
      const SizedBox(
        height: 30,
      ),
    ],
  );
}
