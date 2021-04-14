# AGproject

## Quick Overview

This is a take home coding project for the Junior Software Engineering position @ _Company_.
I chose to create this in Flutter since I was told in the interview if Flutter could be used for work projects then I'd be baptized in it.

The project is to create a mobile application that has the functionality of a profile page, following the UI guide [here](https://xd.adobe.com/view/58778ee1-0bc4-40d9-55fb-cea5b22ab1c8-2e46/). For the profile picture functionality I am using the image_cropper and image_picker packages.

## iOS

<span>
  
  <img src="https://draftbucket.s3.us-east-2.amazonaws.com/errorTextiOS.png" alt="iOS1" width="225" height="450"/>
<img src="https://draftbucket.s3.us-east-2.amazonaws.com/frodoEditPic.png" alt="iOS1" width="225" height="450"/>
<img src="https://draftbucket.s3.us-east-2.amazonaws.com/frodo_withpic.png" alt="iOS2" width="225" height="450"/></span>

### Running the project

To run this you need to install [Flutter](https://flutter.dev/docs/get-started/install). Follow the getting started guide for your operating system.
Open the iOS simulator with `open -a simulator` then from the command line run `flutter run`. To use your own images for profile pictures, simply drag and drop them into iOS simulator. They should be available in Photos.

### Issues

- If you are getting a codeSigning error when attempting to run the project, run `flutter clean` then `flutter run`.

## Android

<span>
<img src="https://draftbucket.s3.us-east-2.amazonaws.com/androidENTER.png" alt="iOS2" width="225" height="450"/>
  <img src="https://draftbucket.s3.us-east-2.amazonaws.com/androidImageCropperAG.png" alt="iOS2" width="225" height="450"/>
  <img src="https://draftbucket.s3.us-east-2.amazonaws.com/androidAG.png" alt="iOS2" width="225" height="450"/>
</span>

### Running the project

While the project runs as intended on the emulator and my physical device (moto e XT2052DL) the emulator debugger spits out a handful of warning messages which are detailed below. I am not sure how to resolve these, and I'd be grateful for any feedback you all have about it.

To use your own images for profile pictures, drag and drop them into the emulator. They should be available in Downloads.

### Issues

- If you can't exit the ImagePicker view with swipe gestures on physical devices, switch to 3 way navigation in settings.
- Focusing on any of the TextFields will give a warning message like `W/IInputConnectionWrapper( 4756): beginBatchEdit on inactive InputConnection`. As far as I can tell this is has been a known issue for some time which you can follow [here](https://github.com/flutter/flutter/issues/9471)
- The image_cropper package uses greylisted methods which you can read more about [here](https://developer.android.com/about/versions/10/non-sdk-q)
- `D/ExifInterface( 7519): No image meets the size requirements of a thumbnail image.`On cropping an image.
