# FJSImageViewController
Show Image, and can pan and pinch the image.
You can save effort to make ImageViewController.

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Features
- Show Image, and can pan and pinch the image.

![fjsimageviewcontroller](https://cloud.githubusercontent.com/assets/4578511/11917589/4956cf06-a751-11e5-9edb-2f1c6a572f32.gif)

## How to use

Create `FJSImageViewController` instance where you want.

```Swift
let imageVC = FJSImageViewController()
imageVC.image = UIImage(named: "sample.jpg")
presentViewController(imageVC, animated: false, completion: nil)
```

## Runtime Requirements

- iOS8.0 or later
- Xcode 7.0 - Swift2.0

## Installation and Setup

### Installing with Carthage

Just add to your Cartfile:

```ogdl
github "fuji2013/FJSImageViewController"
```

### Manual Installation

To install FJSAlertController without a dependency manager, please add `FJSImageViewController.swift` to your Xcode Project.

## Contribution

Please file issues or submit pull requests for anything you’d like to see! We're waiting! :)

## License
FJSImageViewController.swift is released under the MIT license. Go read the LICENSE file for more information.
