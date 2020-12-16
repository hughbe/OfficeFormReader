# OfficeFormReader

Swift definitions for structures, enumerations and functions defined in [MS-OFORMS](https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-oforms/)


## Example Usage

Add the following line to your project's SwiftPM dependencies:
```swift
.package(url: "https://github.com/hughbe/OfficeFormReader", from: "1.0.0"),
```

```swift
import CompoundFileReader
import MsgReader

let data = Data(contentsOfFile: "<path-to-file>.doc")!
let parentFile = try CompoundFile(data: data)
var rootStorage = parentFile.rootStorage
var macros = rootStorage.children["Macros"]!
let form = try UserForm(storage: macros.children["UserForm1"]!)
for site in form.formControl.siteData.sites {
    print(site)
}
for control in form.objectData.embeddedControls {
    print(control)
}
```
