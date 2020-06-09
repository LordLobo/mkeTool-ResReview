# Resturant Review

### Notes/Known issues:
* I am a bit rusty on Core Data so this isn't my best work. I also used an example to build the `CoreDataSource` class that helps create observable objects for SwiftUI. I'm not a fan of the Apple-provided method of using Core Data in SwiftUI and my opinion is ObservableObjects are both more portable and desirable.

* Sometimes running the tests fail because I'm using the on-device core data stack instead of a memory based one. I took a stab at making the Core Data stack having an option to choose but didn't have much luck. When I re-downloaded the project to test, running a single test class at a time seemed to work correctly, but running all tests at once fails.

* I didn't implement the 'Swipe to Edit' option on the Resturant Rows because SwiftUI currently doesn't support that style. I did find a solution that was kinda heavy handed https://stackoverflow.com/questions/57112426/swiftui-custom-swipe-actions-in-list . While I could have spent the time implementing it, I do demonstrate UIViewRepresentable in other places (namely in the MultiLineTextView control)

* I can't really share the code for my current app work on bLinkup however I can screenshare with you during my tech screen. bLinkup is almost entirely in SwiftUI and can showcase a series of other iOS skills I posess.
