SwiftUI’s `State` property wrapper is designed for simple data that is local to the current view, but as soon as you want to share data between views it stops being useful.

Let’s break this down with some code – here’s a struct to store a user’s first and last name:

```swift
struct User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}
```

We can now use that in a SwiftUI view by creating an `@State` property and attaching things to `$user.firstName` and `$user.lastName`, like this:

```swift
struct ContentView: View {
    @State private var user = User()

    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")

            TextField("First name", text: $user.firstName)
            TextField("Last name", text: $user.lastName)
        }
    }
}
```

![[Screen Recording 2023-05-28 at 14.20.09.mov]]

That all works: SwiftUI is smart enough to understand that one object contains all our data, and will update the UI when either value changes. Behind the scenes, what’s actually happening is that each time a value inside our struct changes the _whole_ struct changes – it’s like a new user every time we type a key for the first or last name. That might sound wasteful, but it’s actually extremely fast.

Previously we looked at the differences between classes and structs, and there were two important differences I mentioned. First, that structs always have unique owners, whereas with classes multiple things can point to the same value. And second, that classes don’t need the `mutating` keyword before methods that change their properties, because you _can_ change properties of constant classes.

In practice, what this means is that if we have two SwiftUI views and we send them both the same struct to work with, they actually each have a unique copy of that struct; if one changes it, the other won’t see that change. On the other hand, if we create an instance of a _class_ and send that to both views, they _will_ share changes.

