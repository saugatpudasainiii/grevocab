import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/enum/selection_purpose.dart';
import '../../core/viewmodels/add_book_images.dart';
import '../form/addBook.dart';

class ChooseCategories extends StatefulWidget {
  const ChooseCategories({super.key});

  @override
  State<ChooseCategories> createState() => _ChooseCategoriesState();
}

class _ChooseCategoriesState extends State<ChooseCategories> {
  @override
  void initState() {
    Provider.of<AddBookImages>(context, listen: false).getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 45,
        width: 100,
        child: Consumer<AddBookImages>(
          builder: (context, model, child) {
            return FloatingActionButton(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(1)),
                backgroundColor:
                    model.catId != null && model.selectionStatus != null
                        ? Colors.green
                        : Colors.black54,
                child: const Text("NEXT"),
                onPressed: () {
                  if (model.bookCategories!.data![model.selectedCatIndex!]
                      .subcat!.isNotEmpty) {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        context: context,
                        builder: (builder) {
                          return const SubCatButtonSheet();
                        });
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddBook(
                                categoriesName: model.bookCategories!
                                    .data![model.selectedCatIndex!].name!,
                                subcatname: "",
                              )),
                    );
                  }
                });
          },
        ),
      ),
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
          "Choose a Categories",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Consumer<AddBookImages>(builder: (context, model, child) {
        return SafeArea(
            child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Selected Images",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                        margin: EdgeInsets.only(left: i == 0 ? 0 : 10),
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
                  height: 40,
                ),
                const Text(
                  "Select Status",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        model.changeStatus(SelectionPurpose.exchange);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        decoration: BoxDecoration(
                            color: model.selectionStatus ==
                                    SelectionPurpose.exchange
                                ? Colors.green
                                : Colors.black38,
                            borderRadius: BorderRadius.circular(5)),
                        height: 40,
                        child: const Center(
                            child: Text(
                          "Exchange",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        model.changeStatus(SelectionPurpose.sale);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 4,
                        height: 40,
                        decoration: BoxDecoration(
                            color:
                                model.selectionStatus == SelectionPurpose.sale
                                    ? Colors.green
                                    : Colors.black38,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Center(
                            child: Text(
                          "Sale",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Select Categories",
                  style: TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                model.loading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: model.bookCategories!.data!.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              model.setCaiId(
                                  model.bookCategories!.data![i].sId!, i);
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Text(
                                    model.bookCategories!.data![i].name!,
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        color: model.bookCategories!.data![i]
                                                    .sId ==
                                                model.catId
                                            ? Colors.green
                                            : Colors.black),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 17,
                                    color: model.bookCategories!.data![i].sId ==
                                            model.catId
                                        ? Colors.green
                                        : Colors.black,
                                  ),
                                )),
                          );
                        },
                      ),
              ],
            ),
          ),
        ));
      }),
    );
  }
}

class SubCatButtonSheet extends StatelessWidget {
  const SubCatButtonSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent, //could change this to Color(0xFF737373),
        //so you don't have to change MaterialApp canvasColor
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 8.0, left: 8),
                child: Text(
                  "Select Sub Categories",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Expanded(
              flex: 11,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child:
                      Consumer<AddBookImages>(builder: (context, model, child) {
                    return Column(
                      children: [
                        ...model.bookCategories!.data![model.selectedCatIndex!]
                            .subcat!
                            .map((e) {
                          var index = model.bookCategories!
                              .data![model.selectedCatIndex!].subcat!
                              .indexOf(e);
                          return InkWell(
                            onTap: () {
                              model.setSubCaiId(e.sId!, index);
                            },
                            child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: ListTile(
                                  title: Text(
                                    e.name!,
                                    style: TextStyle(
                                        fontFamily: "Helvetica",
                                        color: e.sId == model.subCatId
                                            ? Colors.green
                                            : Colors.black),
                                  ),
                                  trailing: Icon(Icons.arrow_forward_ios,
                                      size: 17,
                                      color: e.sId == model.subCatId
                                          ? Colors.green
                                          : Colors.black),
                                )),
                          );
                        }),
                      ],
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Consumer<AddBookImages>(builder: (context, model, child) {
                return Container(
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
                                    categoriesName: model.bookCategories!
                                        .data![model.selectedCatIndex!].name!,
                                    subcatname: model
                                        .bookCategories!
                                        .data![model.selectedCatIndex!]
                                        .subcat![model.selectedSubCatIndex!]
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
                      "Next",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 18),
                    ),
                  ),
                );
              }),
            )
          ],
        ));
  }
}
