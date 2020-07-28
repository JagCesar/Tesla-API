# Tesla API supports 📱 🖥 ⌚ 📺

[![Tesla-API](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg?style=flat)](https://github.com/JagCesar/Tesla-API)
[![License](https://img.shields.io/badge/license-MIT-AA8DF8.svg?style=flat)](https://github.com/JagCesar/Tesla-API/blob/master/LICENSE)

This is a Swift package that works with
- iOS
- macOS
- watchOS
- tvOS

It handles the communication with the vehicle API by Tesla and offers an easy to use interface. The implementation is based on the [Unofficial Tesla Model S API](https://docs.timdorr.apiary.io).

## Purpose

I want to be a part of the Tesla community and since I have a lot of experience with iOS engineering I decided that this was the best way to contribute.

This framework is and will always be open source. This way you can be sure there isn't anything weird going on under the hood (pun intended). And for further safety I will never precompile the framework and attach it to the release tags.

I hope that open sourcing this will also inspire people to write awesome Tesla apps and help Tesla on their mission.

## Dependencies

I want to avoid adding 3rd party dependencies to this project. Having 3rd party dependencies opens up the opportunity for someone to inject evil code into this project and makes it more difficult to start using this project. The goal is for anyone who knows Swift and Foundation to hit the ground running.

## How to get started

The best way to use this code in your project is to add is as a Swift Package dependency. [Check out this tutorial by Apple to get started.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## How to use

First thing you have to do is import `TeslaAPI` in each file where you want to use it. You do this by writing `import TeslaAPI` at the top of the file.

To sign in and receive an authentication token you write:

```
AuthenticateRequest(
    username: username,
    password: password).execute { result in
    switch result {
        case .success(let token):
            // Handle success of login here.
        case .failure(let error):
            // Handle error here. The error object might give you a hint what went wrong.
    }
}
```

The object `token` given in the `.success` case contains everything you need to make further requests as this user. Please note that this framework does not handle saving of this token. You have to persist this token in a way that you think makes sense. I suggest storing it in the keychain.

## Are there any other requests?

I'll continuously add support for more endpoints, and I encourage you to submit PR's and help me. If you want to see which endpoints are currently available [you'll find them all here](https://github.com/JagCesar/Tesla-API/tree/master/Source/Requests).

## License

This project is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.

> This project is in no way affiliated with Tesla Inc. This project is open source under the MIT license, which means you have full access to the source code and can modify it to fit your own needs.
