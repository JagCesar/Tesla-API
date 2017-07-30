# Tesla API

[![Build Status](https://www.bitrise.io/app/b4c6282d36e95749/status.svg?token=Uko7wcLVPmPuUDLSLr3stg&branch=master)](https://www.bitrise.io/app/b4c6282d36e95749)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Tesla-API](https://img.shields.io/badge/platform-iOS%20%7C%20macOS%20%7C%20watchOS%20%7C%20tvOS-lightgrey.svg?style=flat)](https://github.com/JagCesar/Tesla-API)
[![License](https://img.shields.io/badge/license-MIT-AA8DF8.svg?style=flat)](https://github.com/JagCesar/Tesla-API/blob/master/LICENSE)
[![Language](https://img.shields.io/badge/language-Swift%203-E05C43.svg?style=flat)](https://swift.org)
[![Twitter](https://img.shields.io/badge/twitter-@JagCesar-00ACED.svg?style=flat)](http://twitter.com/JagCesar)

This is a universal framework that works with:

- iOS 📱
- macOS 🖥
- watchOS ⌚
- tvOS 📺

It handles the communication with the vehicle API offered by Tesla and offers an easy to use interface. The implementation is based on [Unofficial Tesla Model S API](https://docs.timdorr.apiary.io).

## Purpose

I want to be a part of the Tesla community and since I have a lot of experience with iOS engineering I decided that this was the best way to contribute.

This framework is and will always be open source. This way you can be sure there isn't anything weird going on under the hood (pun intended). And for furthery safety I will never precompile the framework and attach it to the release tags.

I hope that open sourcing this will also inspire people to write awesome Tesla apps and help Tesla on their mission.

## Requirements

Because of safety reasons this repo will never use 3rd party frameworks. I want people to use this codebase without being worried that someone will steal their credentials (which can lead to someone stealing your car). This was one of the reasons I decided to write this from scratch rather than using one of the existing implementations.

## Status

Please keep in mind that this project is on-going and I haven't had time to add or verify all functionality yet. If you have a Tesla and are willing to try out this implementation drop me a note on Twitter [@JagCesar](https://twitter.com/jagcesar) or open an Issue here on GitHub and I'll quickly throw together an example project.

## How to get started

The best way to use this code in your project is by using [Carthage](https://github.com/carthage/carthage). If you haven't used [Carthage](https://github.com/carthage/carthage) before, follow the [Readme](https://github.com/Carthage/Carthage/blob/master/README.md) in their repo to get it up and running on your machine.

Once you have [Carthage](https://github.com/carthage/carthage) installed on your machine, add `github "JagCesar/Tesla-API"` to your `Cartfile`.

When you've done this, [follow the instructions](https://github.com/carthage/carthage#getting-started) on how to compile your dependencies and add them to your project.

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

Copyright (c) 2017 César Pinto Castillo

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
