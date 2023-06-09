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

For SwiftUI developers, what this means is that if we want to share data between multiple views – if we want two or more views to point to the same data so that when one changes they all get those changes – we need to use classes rather than structs.

So, please change the `User` struct to be a class. From this:

```swift
struct User {
```

To this:

```swift
class User {
```

Now run the program again and see what you think.

Spoiler: it doesn’t work any more. Sure, we can type into the text fields just like before, but the text view above doesn’t change.

![[Screen Recording 2023-05-28 at 14.31.47.mov]]

When we use `@State`, we’re asking SwiftUI to watch a property for changes. So, if we change a string, flip a Boolean, add to an array, and so on, the property has changed and SwiftUI will re-invoke the `body` property of the view.

When `User` was a struct, every time we modified a property of that struct Swift was actually creating a new instance of the struct. `@State` was able to spot that change, and automatically reloaded our view. Now that we have a class, that behavior no longer happens: Swift can just modify the value directly.

Remember how we had to use the `mutating` keyword for struct methods that modify properties? This is because if we create the struct’s properties as variable but the struct itself is constant, we can’t change the properties – Swift needs to be able to destroy and recreate the whole struct when a property changes, and that isn’t possible for constant structs. Classes _don’t_ need the `mutating` keyword, because even if the class instance is marked as constant Swift can still modify variable properties.

I know that all sounds terribly theoretical, but here’s the twist: now that `User` is a class the property itself isn’t changing, so `@State` doesn’t notice anything and can’t reload the view. Yes, the values _inside_ the class are changing, but `@State` doesn’t monitor those, so effectively what’s happening is that the values inside our class are being changed but the view isn’t being reloaded to reflect that change.

To fix this, it’s time to leave `@State` behind. Instead we need a more powerful property wrapper called `@StateObject` – let’s look at that now…

# Sharing SwiftUI state with @StateObject

If you want to use a class with your SwiftUI data – which you _will_ want to do if that data should be shared across more than one view – then SwiftUI gives us three property wrappers that are useful: `@StateObject`, `@ObservedObject`, and `@EnvironmentObject`. We’ll be looking at environment objects later on, but for now let’s focus on the first two.

Here’s some code that creates a `User` class, and shows that user data in a view:
```swift
class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
}

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

However, that code won’t work as intended: we’ve marked the `user` property with `@State`, which is designed to track local structs rather than external classes. As a result, we can type into the text fields but the text view above won’t be updated.

To fix this, we need to tell SwiftUI when interesting parts of our class have changed. By “interesting parts” I mean parts that should cause SwiftUI to reload any views that are watching our class – it’s possible you might have lots of properties inside your class, but only a few should be exposed to the wider world in this way.

Our `User` class has two properties: `firstName` and `lastName`. Whenever either of those two changes, we want to notify any views that are watching our class that a change has happened so they can be reloaded. We can do this using the `@Published` property observer, like this:

```swift
class User {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}
```

`@Published` is more or less half of `@State`: it tells Swift that whenever either of those two properties changes, it should send an announcement out to any SwiftUI views that are watching that they should reload.

How do those views know which classes might send out these notifications? That’s another property wrapper, `@StateObject`, which is the other half of `@State` – it tells SwiftUI that we’re creating a new class instance that should be watched for any change announcements.

So, change the `user` property to this:

```swift
@StateObject var user = User()
```

I removed the `private` access control there, but whether or not you use it depends on your usage – if you’re intending to share that object with other views then marking it as `private` will just cause confusion.

Now that we’re using `@StateObject`, our code will no longer compile. It’s not a problem, and in fact it’s expected and easy to fix: the `@StateObject` property wrapper can only be used on types that conform to the `ObservableObject` protocol. This protocol has no requirements, and really all it means is “we want other things to be able to monitor this for changes.”

So, modify the `User` class to this:

```swift
class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
}
```

Our code will now compile again, and, even better, it will now actually _work_ again – you can run the app and see the text view update when either text field is changed.

As you’ve seen, rather than just using `@State` to declare local state, we now take three steps:

- Make a class that conforms to the `ObservableObject` protocol.
- Mark some properties with `@Published` so that any views using the class get updated when they change.
- Create an instance of our class using the `@StateObject` property wrapper.


# Showing and hiding views

There are several ways of showing views in SwiftUI, and one of the most basic is a _sheet_: a new view presented on top of our existing one. On iOS this automatically gives us a card-like presentation where the current view slides away into the distance a little and the new view animates in on top.

Sheets work much like alerts, in that we don’t present them directly with code such as `mySheet.present()` or similar. Instead, we define the _conditions_ under which a sheet should be shown, and when those conditions become true or false the sheet will either be presented or dismissed respectively.

Let’s start with a simple example, which will be showing one view from another using a sheet. First, we create the view we want to show inside a sheet, like this:

```swift
struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
}
```

There’s nothing special about that view at all – it doesn’t know it’s going to be shown in a sheet, and doesn’t _need_ to know it’s going to be shown in a sheet.

Next we create our initial view, which will show the second view. We’ll make it simple, then add to it:

```swift
struct ContentView: View { 
    var body: some View {
        Button("Show Sheet") {
            // show the sheet
        }
    }
}
```

Filling that in requires four steps, and we’ll tackle them individually.

First, we need some state to track whether the sheet is showing. Just as with alerts, this can be a simple Boolean, so add this property to `ContentView` now:

```swift
@State private var showingSheet = false
```

Second, we need to toggle that when our button is tapped, so replace the `// show the sheet` comment with this:

```swift
showingSheet.toggle()
```

Third, we need to attach our sheet somewhere to our view hierarchy. If you remember, we show alerts using `isPresented` with a two-way binding to our state property, and we use something almost identical here: `sheet(isPresented:)`.

`sheet()` is a modifier just like `alert()`, so please add this modifier to our button now:

```swift
.sheet(isPresented: $showingSheet) {
    // contents of the sheet
}
```

Fourth, we need to decide what should actually be in the sheet. In our case, we already know exactly what we want: we want to create and show an instance of `SecondView`. In code that means writing `SecondView()`, then… er… well, that’s it.

So, the finished `ContentView` struct should look like this:

```swift
struct ContentView: View {
    @State private var showingSheet = false

    var body: some View {
        Button("Show Sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
}
```

If you run the program now you’ll see you can tap the button to have our second view slide upwards from the bottom, and you can then drag that down to dismiss it.

When you create a view like this, you can pass in any parameters it needs to work. For example, we could require that `SecondView` be sent a name it can display, like this:

```swift
struct SecondView: View {
    let name: String

    var body: some View {
        Text("Hello, \(name)!")
    }
}
```

And now just using `SecondView()` in our sheet isn’t good enough – we need to pass in a name string to be shown. For example, we could pass in my Twitter username like this:

```swift
.sheet(isPresented: $showingSheet) {
    SecondView(name: "@twostraws")
}
```

Swift is doing a ton of work on our behalf here: as soon as we said that `SecondView` has a name property, Swift ensured that our code wouldn’t even build until all instances of `SecondView()` became `SecondView(name: "some name")`, which eliminates a whole range of possible errors.

Before we move on, there’s one more thing I want to demonstrate, which is how to make a view dismiss itself. Yes, you’ve seen that the user can just swipe downwards, but sometimes you will want to dismiss views programmatically – to make the view go away because a button was pressed, for example.

To dismiss another view we need another property wrapper – and yes, I realize that so often the solution to a problem in SwiftUI is to use another property wrapper.

Anyway, this new one is called `@Environment`, and it allows us to create properties that store values provided to us externally. Is the user in light mode or dark mode? Have they asked for smaller or larger fonts? What timezone are they on? All these and more are values that come from the environment, and in this instance we’re going to ask the environment to dismiss our view.

Yes, we need to ask the environment to dismiss our view, because it might have been presented in any number of different ways. So, we’re effectively saying “hey, figure out how my view was presented, then dismiss it appropriately.”

To try it out add this property to `SecondView`, which creates a property called `dismiss` based on a value from the environment:

```swift
@Environment(\.dismiss) var dismiss
```

Now replace the text view in `SecondView` with this button:

```swift
Button("Dismiss") {
    dismiss()
}
```

Anyway, with that button in place, you should now find you can show and hide the sheet using button presses.

# Deleting items using onDelete()

SwiftUI gives us the `onDelete()` modifier for us to use to control how objects should be deleted from a collection. In practice, this is almost exclusively used with `List` and `ForEach`: we create a list of rows that are shown using `ForEach`, then attach `onDelete()` to that `ForEach` so the user can remove rows they don’t want.

This is another place where SwiftUI does a heck of a lot of work on our behalf, but it does have a few interesting quirks as you’ll see.

First, let’s construct an example we can work with: a list that shows numbers, and every time we tap the button a new number appears. Here’s the code for that:

```swift
struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1

    var body: some View {
        VStack {
            List {
                ForEach(numbers, id: \.self) {
                    Text("Row \($0)")
                }
            }

            Button("Add Number") {
                numbers.append(currentNumber)
                currentNumber += 1
            }
        }
    }
}
```

Now, you might think that the `ForEach` isn’t needed – the list is made up of entirely dynamic rows, so we could write this instead:

```swift
List(numbers, id: \.self) {
    Text("Row \($0)")
}
```

That would also work, but here’s our first quirk: the `onDelete()` modifier only exists on `ForEach`, so if we want users to delete items from a list we must put the items inside a `ForEach`. This does mean a small amount of extra code for the times when we have only dynamic rows, but on the flip side it means it’s easier to create lists where only some rows can be deleted.

In order to make `onDelete()` work, we need to implement a method that will receive a single parameter of type `IndexSet`. This is a bit like a set of integers, except it’s sorted, and it’s just telling us the positions of all the items in the `ForEach` that should be removed.

Because our `ForEach` was created entirely from a single array, we can actually just pass that index set straight to our `numbers` array – it has a special `remove(atOffsets:)` method that accepts an index set.

So, add this method to `ContentView` now:Rar

```swift
func removeRows(at offsets: IndexSet) {
    numbers.remove(atOffsets: offsets)
} 
```

Finally, we can tell SwiftUI to call that method when it wants to delete data from the `ForEach`, by modifying it to this:

```swift
ForEach(numbers, id: \.self) {
    Text("Row \($0)")
}
.onDelete(perform: removeRows)
```

Now go ahead and run your app, then add a few numbers. When you’re ready, swipe from right to left across any of the rows in your list, and you should find a delete button appears. You can tap that, or you can also use iOS’s swipe to delete functionality by swiping further.

Given how easy that was, I think the result works really well. But SwiftUI has another trick up its sleeve: we can add an Edit/Done button to the navigation bar, that lets users delete several rows more easily.

First, wrap your `VStack` in a `NavigationView`, then add this modifier to the `VStack`:

```swift
.toolbar {
    EditButton()
}
```

# Archiving Swift objects with Codable

`@AppStorage` is great for storing simple settings such as integers and Booleans, but when it comes to complex data – custom Swift types, for example – we need to do a little more work. This is where we need to poke around directly with `UserDefaults` itself, rather than going through the `@AppStorage` property wrapper.

Here’s a simple `User` data structure we can work with:

```swift
struct User {
    let firstName: String
    let lastName: String
}
```

That has two strings, but those aren’t special – they are just pieces of text. The same goes for integer (plain old numbers), Boolean (true or false), and `Double` (plain old numbers, just with a dot somewhere in there). Even arrays and dictionaries of those values are easy to think about: there’s one string, then another, then a third, and so on.

When working with data like this, Swift gives us a fantastic protocol called `Codable`: a protocol specifically for _archiving_ and _unarchiving_ data, which is a fancy way of saying “converting objects into plain text and back again.”

We’re going to be looking at `Codable` much more in future projects, but for now we’re going to keep it as simple as possible: we want to archive a custom type so we can put it into `UserDefaults`, then unarchive it when it comes back _out_ from `UserDefaults`.

When working with a type that only has simple properties – strings, integers, Booleans, arrays of strings, and so on – the only thing we need to do to support archiving and unarchiving is add a conformance to `Codable`, like this:

```swift
struct User: Codable {
    let firstName: String
    let lastName: String
}
```

Swift will automatically generate some code for us that will archive and unarchive `User` instances for us as needed, but we still need to tell Swift _when_ to archive and what to do with the data.

This part of the process is powered by a new type called `JSONEncoder`. Its job is to take something that conforms to `Codable` and send back that object in JavaScript Object Notation (JSON) – the name implies it’s specific to JavaScript, but in practice we all use it because it’s so fast and simple.

The `Codable` protocol doesn’t require that we use JSON, and in fact other formats are available, but it is by far the most common. In this instance, we don’t actually care _what_ sort of data is used, because it’s just going to be stored in `UserDefaults`.

To convert our `user` data into JSON data, we need to call the `encode()` method on a `JSONEncoder`. This might throw errors, so it should be called with `try` or `try?` to handle errors neatly. For example, if we had a property to store a `User` instance, like this:

```swift
@State private var user = User(firstName: "Taylor", lastName: "Swift")
```

```swift
Button("Save User") {
    let encoder = JSONEncoder()

    if let data = try? encoder.encode(user) {
        UserDefaults.standard.set(data, forKey: "UserData")
    }
}
```

That accesses `UserDefaults` directly rather than going through `@AppStorage`, because the `@AppStorage` property wrapper just doesn’t work here.

That `data` constant is a new data type called, perhaps confusingly, `Data`. It’s designed to store any kind of data you can think of, such as strings, images, zip files, and more. Here, though, all we care about is that it’s one of the types of data we can write straight into `UserDefaults`.

When we’re coming back the other way – when we have JSON data and we want to convert it to Swift `Codable` types – we should use `JSONDecoder` rather than `JSONEncoder()`, but the process is much the same.

That brings us to the end of our project overview, so go ahead and reset your project to its initial state ready to build on.






