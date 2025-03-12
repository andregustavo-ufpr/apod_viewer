
import "package:flutter/material.dart";
import "package:nasa_apod_viewer/core/data/local/colors.dart";

class InteractiveImageViewer extends StatelessWidget {
  const InteractiveImageViewer({
    required this.image, 
    super.key
  });

  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height,
      width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: BLACK.withOpacity(0.8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
      ),
      body: InteractiveViewer(
        maxScale: 5,
        minScale: 0.5,
        child: Container(
          height: height,
          width: width,
          padding: EdgeInsets.all(8),
          alignment: Alignment.center,
          child: Column(
            children: [
              Flexible(
                flex: 20, 
                child: InkWell(
                  onTap: ()=>Navigator.of(context).pop(),
                  child: const SizedBox.expand()
                )
              ),
              Flexible(
                flex: 60,
                child: Image(
                  image: image,
                  errorBuilder: (context, exception, trace) {
                    return Container();
                  },
                  loadingBuilder: (
                    BuildContext context, 
                    Widget child, 
                    ImageChunkEvent? loadingProgress
                  ) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null ? 
                          // ignore: lines_longer_than_80_chars
                          loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                      ),
                    );
                  },
                ),
              ),
              Flexible(
                flex: 20, 
                child: InkWell(
                  onTap: ()=>Navigator.of(context).pop(),
                  child: const SizedBox.expand()
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}
