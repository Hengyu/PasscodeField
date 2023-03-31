# PasscodeField

![](https://img.shields.io/badge/iOS-13.0%2B-green)
![](https://img.shields.io/badge/tvOS-14.0%2B-green)
![](https://img.shields.io/badge/macOS-11.0%2B-green)
![](https://img.shields.io/badge/Swift-5-orange?logo=Swift&logoColor=white)
![](https://img.shields.io/github/last-commit/hengyu/PasscodeField)

<img width=320 src="preview.png"/>

**PasscodeField** provides a passcode field written in SwiftUI.
1. Digit length is customizable;
2. Digit box style is customizable;
3. Support for hide/unhide digits.

## Table of contents

* [Requirements](#requirements)
* [Installation](#installation)
* [Usage](#usage)
* [Core Ideas](#core-ideas)
* [License](#license)

## Requirements

- iOS 13.0+, tvOS 14.0+, macOS 11.0+
- SwiftUI

## Usage

In the Swift file you want to use, just import the package and then:

```swift
import PasscodeField

// ... some code ...

PasscodeField { digits, action in
    if candidatePasscodes.contains(digits.concat) {
        withAnimation {
            isPresentingPasscode = false
        }
        action(true)
    } else {
        withAnimation {
            isShowingAlert = true
        }
        action(false)
    }
} label: {
    VStack(alignment: .center, spacing: 8) {
        Text("Security Number")
        .font(.title)
        .foregroundColor(Color(.label))

        Text("4 digits")
        .font(.footnote)
        .foregroundColor(Color(.secondaryLabel))
    }
}
.alert(
    "Wrong Passcode",
    isPresented: $isShowingAlert,
    confirmationText: "Retry",
    confirmationAction: {
        isShowingAlert = false
    },
    cancellationText: "Quit",
    cancellationAction: {
        isShowingAlert = false
        dismissAction()
    }
)
```

## Installation

### Swift Package Manager

[PasscodeField](https://github.com/hengyu/PasscodeField.git) could be installed via [Swift Package Manager](https://www.swift.org/package-manager/). Open Xcode and go to **File** -> **Add Packages...**, search `https://github.com/hengyu/PasscodeField.git`, and add the package as one of your project's dependency.

### Manual

1. Download code from [GitHub](https://github.com/hengyu/PasscodeField);
2. Drag & drop the `Sources` folder into your project.

## Core Ideas

To provide the system input keyboard to user when they interacting the `PasscodeField`, we use a system text field as the receiver while making it visually invisible. When user is about to input digits, we first make the text field as the first responder. At this time, the system keyboard will show. Then we listen to the input event, when any input arrives, we validate the input and then update the state of the `PasscodeField` (e.g., set a gray background on the digit box to indicate user they have added one digit). Also, we listen to the text deletion event, and update the `PasscodeField` correspondingly.

## License

**PasscodeField** is available under the [MIT License](LICENSE).
