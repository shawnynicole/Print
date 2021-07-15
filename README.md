# Print

**Print** makes ease of debugging by printing pertinent information to the console.

<p align="center">
    <a href="#requirements">Requirements</a> • <a href="#installation">Installation</a> • <a href="#usage">Usage</a> • <a href="#author">Author</a> • <a href="#license-mit">License</a>
</p>

## Requirements

- Xcode 10.2+
- Swift 5.0+

## Installation

#### Swift Package Manager
You can use [The Swift Package Manager](https://swift.org/package-manager) to install `Print` by adding the proper description to your `Package.swift` file:
```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    targets: [],
    dependencies: [
        .package(url: "https://github.com/shawnynicole/Print.git", from: "1.0.0")
    ]
)
```
For more information on [Swift Package Manager](https://swift.org/package-manager), checkout its [GitHub Page](https://github.com/apple/swift-package-manager).

#### Manually

[Download](https://github.com/shawnynicole/Print/archive/master.zip) the project and copy the `Print` folder into your project to use it in.

## Usage

```swift
import SwiftUI
import Print

struct ContentView: View, Print {
    
    var body: some View {
        
        Text("Hello, world!")
            .onAppear {
                
                // Common usage
                
                print("Hello World!")
                
                // Custom title
                // A separator with a custom title is drawn around the text in the console.
                
                print(type: .title("Custom"), "Hello World!")
                
                // Static
                
                MyStruct.sayHello()
                
                // MyStruct conforms to Print
                
                MyStruct().sayHello()
                
                // Handling errors
                // A separator is drawn around the error in the console so that errors stand out.
                
                do {
                    try getError()
                } catch {
                    print(error)
                }
                
                // Superclass
                
                AClass().sayHello()
                
                // Subclass
                // Subclass calls super. Notice Print.AClass.swift 15 and Print.BClass.swift 16 is printed to the console.
                
                BClass().sayHello()
            }
    }
    
    func getError() throws {
        throw MyError("This is my error message.")
    }
}
```

```swift


[2021-07-15 03:56:44 PM ContentView.swift ContentView.body 25] Hello World!

************************************************************** CUSTOM **************************************************************
[2021-07-15 03:56:44 PM ContentView.swift ContentView.body 30] Hello World!
***********************************************************************************************************************************

[2021-07-15 03:56:44 PM MyStruct.swift MyStruct.sayHello() 15] Hello, World!

[2021-07-15 03:56:44 PM MyStruct.swift MyStruct.sayHello() 19] Hello, World!

************************************************************** ERROR **************************************************************
[2021-07-15 03:56:44 PM ContentView.swift ContentView.body 46] MyError(message: "This is my error message.")
***********************************************************************************************************************************

[2021-07-15 03:56:44 PM AClass.swift AClass.sayHello() 15] Hello, AClass!

[2021-07-15 03:56:44 PM AClass.swift BClass.sayHello() 15] Hello, AClass!

[2021-07-15 03:56:44 PM BClass.swift BClass.sayHello() 16] Hello, BClass!

```

## Author

shawnynicole

## License

Print is available under the MIT license. See the LICENSE file for more info.
