import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_editor/component/main_app_bar.dart';
import 'package:image_editor/component/emoticon_sticker.dart';
import 'package:image_editor/model/sticker_model.dart';
import 'package:image_editor/component/footer.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'dart:typed_data';
import '../component/footer.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? image;
  Set<StickerModel> stickers = {};
  String? selectedId;
  GlobalKey imgKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            renderBody(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MainAppBar(
                  onPickImage: onPickImage,
                  onSaveImage: onSaveImage,
                  onDeleteItem: onDeleteItem),
            ),
            if (image != null)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Footer(
                  onEmoticonTap: onEmoticonTap,
                ),
              )
          ],
        ));
  }

  Widget renderBody() {
    if (image != null) {
      return RepaintBoundary(
          key: imgKey,
          child: Positioned.fill(
            child: InteractiveViewer(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(
                    File(image!.path),
                    fit: BoxFit.cover,
                  ),
                  ...stickers.map((sticker) =>
                      Center(
                        child: EmotionSticker(
                          key: ObjectKey(sticker.id),
                          onTransform: () {
                            onTransform(sticker.id);
                          },
                          imgPath: sticker.imgPath,
                          isSelected: selectedId == sticker.id,
                        ),
                      )),
                ],
              ),
            ),
          )
      );
    } else {
      return Center(
        child: TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.grey,
          ),
          onPressed: onPickImage,
          child: Text('choose image'),
        ),
      );
    }
  }

  void onEmoticonTap(int index) async {
    setState(() {
      stickers = {
        ...stickers,
        StickerModel(
          id: Uuid().v4(),
          imgPath: 'asset/img/$index.png',
        )
      };
    });
  }

  void onPickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      this.image = image;
    });
  }

  void onSaveImage() async{
    void onSaveImage() async {
      try {
        // 캡처한 위젯의 렌더링 바운더리 가져오기
        RenderRepaintBoundary boundary = imgKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
        print('Render boundary acquired');

        // 이미지 변환
        ui.Image image = await boundary.toImage();
        print('Image created');

        ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
        print('ByteData created');

        Uint8List pngBytes = byteData!.buffer.asUint8List();
        print('PNG Bytes created: ${pngBytes.length} bytes');

        // 갤러리에 이미지 저장
        final result = await ImageGallerySaver.saveImage(pngBytes, quality: 100);
        print('Saved result: $result');

        // 저장 완료 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Saved successfully!')),
        );
      } catch (e) {
        print('Error occurred: $e');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save image: $e')),
        );
      }
    }
  }

  void onDeleteItem() async {
    setState(() {
      stickers = stickers.where((sticker) => sticker.id != selectedId)
          .toSet(); //선택되지 않은 것들을 살려!
    });
  }

  void onTransform(String id) {
    setState(() {
      selectedId = id;
    });
  }
}
