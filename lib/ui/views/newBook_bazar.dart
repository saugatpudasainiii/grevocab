import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../../core/viewmodels/add_book_images.dart';
import 'chooseCategories.dart';

class NewPosts extends StatefulWidget {
  final ScrollController? scrollCtr;
  final bool isFromNew;

  const NewPosts({
    Key? key,
    this.isFromNew = false,
    this.scrollCtr,
  }) : super(key: key);

  @override
  _NewPostsState createState() => _NewPostsState();
}

class _NewPostsState extends State<NewPosts> with TickerProviderStateMixin {
  List<Widget> mediaList = [];

  bool imageP = true;

  int currentPage = 0;
  int? lastPage;

  final ImagePicker imagePicker = ImagePicker();
  File? imageFile;

  Future<void> _getFromCamera() async {
    var image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
      imageQuality: 85,
    );
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
        isSelected = !isSelected;
      });
    }
    if (imageFile != null) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //       builder: (context) => SelectedPost(image: Image.file(imageFile))),
      // );
    }
  }

  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchNewMedia();

    dateInput.text = "";
  }

  String? newpath;
  Future getPath(int index) async {
    String path = await media![index].file.then((value) => value!.path);
    newpath = path;
  }

  List<AssetEntity>? media;

  _fetchNewMedia() async {
    lastPage = currentPage;
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.isAuth) {
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: const RequestType(1),
        onlyAll: true,
      );

      media = await albums[index!]
          .getAssetListPaged(size: 1500, page: currentPage); //preloading files
      List<Widget> temp = [];

      for (var asset in media!) {
        temp.add(
          FutureBuilder(
            future: asset.thumbnailDataWithSize(
              const ThumbnailSize(
                320,
                320,
              ),
            ),
            builder:
                (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Stack(
                  children: <Widget>[
                    AspectRatio(
                      aspectRatio: 1,
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                      ),
                    ),
                    if (asset.type == AssetType.video)
                      const Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 5, bottom: 5),
                          child: Icon(
                            Icons.videocam,
                            color: Colors.black,
                          ),
                        ),
                      ),
                  ],
                );
              }
              return Container();
            },
          ),
        );
      }

      setState(() {
        mediaList.addAll(temp);

        currentPage++;
      });
    }
  }

  bool isSelected = false;
  bool isFileSelected = false;
  bool isLongSelected = false;

  int? index = 0;
  final snackBar = const SnackBar(content: Text('Image is tapped.'));

  OverlayEntry? _popupDialog;

  double width(int selectedIndex, int index) {
    if (index == selectedIndex) {
      return 3.0;
    } else {
      return 0.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Exit App'),
              content: const Text('Do you want to exit the App?'),
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  //return false when click on "NO"
                  child: const Text('No'),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  //return true when click on "Yes"
                  child: const Text('Yes'),
                ),
              ],
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return Scaffold(body: Consumer<AddBookImages>(
      builder: (context, model, child) {
        return SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scroll) {
                  return false;
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                          const Text(
                            'ADD POST',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                              onTap: () {
                                _getFromCamera();
                              },
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Stack(
                        children: [
                          GridView.builder(
                              controller: widget.scrollCtr,
                              itemCount: mediaList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                              itemBuilder: (context, int index) {
                                return GestureDetector(
                                  onLongPress: () {
                                    Provider.of<AddBookImages>(context,
                                            listen: false)
                                        .changeOnlongTabEvent(index);
                                    _popupDialog = _createPopupDialog(index);

                                    Overlay.of(context).insert(_popupDialog!);
                                  },
                                  onLongPressEnd: (details) =>
                                      _popupDialog?.remove(),
                                  onTap: () async {
                                    await getPath(index);
                                    // ignore: use_build_context_synchronously
                                    Provider.of<AddBookImages>(context,
                                            listen: false)
                                        .changeOnTabEvent(index);
                                    // ignore: use_build_context_synchronously
                                    Provider.of<AddBookImages>(context,
                                            listen: false)
                                        .isSelectFile(true);

                                    // ignore: use_build_context_synchronously
                                    Provider.of<AddBookImages>(context,
                                            listen: false)
                                        .addImageWithFile(
                                            index, File(newpath!));
                                    ;
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: model.selectedIndex
                                                          .contains(index)
                                                      ? 2
                                                      : 0,
                                                  color: model.selectedIndex
                                                          .contains(index)
                                                      ? Colors.green
                                                      : Colors.transparent)),
                                          child: mediaList[index]),
                                      model.selectedIndex.contains(index)
                                          ? const Icon(
                                              Icons.circle,
                                              size: 20,
                                              color: Colors.green,
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  ),
                                );
                              }),
                          Positioned(
                            bottom: 40,
                            left: 60,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ChooseCategories()),
                                  );
                                },
                                child: Container(
                                  height: 53,
                                  padding: const EdgeInsets.only(
                                      top: 17, bottom: 17),
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red),
                                  child: Center(
                                    child: Text(
                                      'NEXT ${model.imageFile!.isEmpty ? "" : model.imageFile!.length}',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20),
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    ));
  }

  OverlayEntry _createPopupDialog(int index) {
    return OverlayEntry(
      builder: (context) => AnimatedDialog(
        child: _createPopupContent(index),
      ),
    );
  }

  imageCheck(int index) {
    return mediaList[index];
  }

  Widget _createPopupContent(int index) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: imageCheck(index),
        ),
      );
}

class AnimatedDialog extends StatefulWidget {
  const AnimatedDialog({required this.child});

  final Widget child;

  @override
  State<StatefulWidget> createState() => AnimatedDialogState();
}

class AnimatedDialogState extends State<AnimatedDialog>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? opacityAnimation;
  Animation<double>? scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 400));
    scaleAnimation =
        CurvedAnimation(parent: controller!, curve: Curves.easeOutExpo);
    opacityAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: controller!, curve: Curves.easeOutExpo));

    controller!.addListener(() => setState(() {}));
    controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(opacityAnimation!.value),
      child: Center(
        child: FadeTransition(
          opacity: scaleAnimation!,
          child: ScaleTransition(
            scale: scaleAnimation!,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
