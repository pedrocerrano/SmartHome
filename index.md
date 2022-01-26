# Smart Home: Part 1

In this project, you will use your knowledge of Swift and Interface Builder to build an app that allows users to create a list of devices for their smart home. These `devices` will be able to be switched on and off from the list that displays them.  The user will create the `devices` for their Smart Home via an `Alert Controller`.

We want to focus on the `delegate` and `protocol` patterns. With that in mind, there is no detail screen for these objects and the `CRUD` functions are slimed down. The UI will be fairly straight forward but the way you handle the data will be the main challenge. 

Students who complete this project independently or as a pairing will showcase their understanding of the following principles:

* Basic Storyboard constraints
* UITableviews
* Creating Custom `class` objects
* Constants, Variables, and Basic Data Types
* Collections
* Functions
* Control Flow
* IBActions && IBOutlets
* Alert Controller
* Local Persistence
---

## Design
Our Smart Home app will display `Device` objects in a `UITableView`. Once you create a `Device`  you can toggle the device on and off.

 It's gonna be great! Let's get started…
Initial screen:
![Inital Screen](/SmartHomeInitial.png)

We feel confident that you will be able to create this design on your own. A Few notes:

* There is no segue
* The `+` button will present an alert
* This is a custom cell and will require a  class to manage it
Once you created the necessary files along with the necessary `IBOutlets` and `IBActions` please run the app, and make a commit.

---

## Model - Create a `Device` model with
* name
* isON

Create the member-wise initializer

At this time, the instructions will not be allowing our users to delete `Device` Objects. You as a developer may choose to build in this feature if you wish

---
Each `Model` will need a file to manage its properties and functions. Many of these methods will be familiar to you. Let’s start with our `Person` Model.

##  Device Controller
Create the necessary file to hold your `DeviceController` file. Once you have that step done, along with creating the actual `class` define the following method signatures:
* create
* toggleIsOn
* save
* load

Make a mark for your properties and create the following properties:
* A singleton
* A source of truth


Make a mark under the properties titled `Initializers` and write the following code that matches the following description. 

 Capture the initialization of the `DeviceController`  class. Whenever this file is initialized we will load the data from the disk. 

<details>
<summary>How do I write this?</summary>
<br>
init() {
<br>
Load()
<br>
}
<br>	
</details>

Jump into the `create` function and define one parameter for the `name`
Complete this function. 
Be sure to call `save`

Now,  to complete the `toggleIsOn`  we need to know what `Device` the user is toggling. Within the body:
* Toggle the `isOn` of the `device`
* save

Okay! Well done! At this time you should have your `properties`, `singleton`, and `CRUD` functions completed. The `save` and `load` functions should just be method signatures at this time.

---

#### Save, Load, and the URL it all goes to
Before we start filling out the `save` and `load` functions there is one final property we need. For readability, we recommend creating this under the `load` function.

Define a `private` variable with the name `sevicesURL` that is of the type `URL` optional. This will be a `computed property`, which means the value will be the result of some computation. You define a computed property by opening a scope following the type.
``` swift
private var devicesURL: URL? {
// Computed Property
}
```

##### Url
Within the body of the `devicesURL` computed property, we need to accomplish a few goals….

First - We need to locate a file where we can save the data for this application. Because the data will be saved onto the phone the file path will be a URL. The best place to save basic data is directly in the `Documents` directory on the phone.
* guard while creating a new constant named `documentsDirectory`
	* Assign this constant the value of the FIRST `URL`  for the `.documentsDirectory`, in `.userDomainMask`from the collection of `urls` that are accessible via the `default` singleton from the `FileManger` class.
		* return nil if you can’t create this value ^

Secondly - we need to assign the proper `Path Comment` so we can locate this file again.  We recommend `devices.json`
*  create a new constant named `url` and assign it the value of the `documentsDirectory` you created earlier amended with the proper `Path Component`
 
Finally - when all is said and done we can return a `url` that we can use over and over.
* return the url

We mark this computed property as private because we don’t want any other class to have access to this property. It's, well, private property haha. 
* It's okay to re-use jokes, right?

##### Save
Save, and load, will seem intimidating at the start but as we break into the code and practice, it will become more approachable. The best news is that the format we will use for today's project is the SAME for every project going forward.

Within the body of the `save` function, we need to accomplish a few goals. 

We need:
*  A location to save the data. Luckily we’ve already created this we just need to ensure it's not `nil`
	* Hint, it needs to be a `URL`
* Next, we need to take all of the content we want to save `Objects`, `Strings`, `Everything`, and encode it into a `data` type the computer can read and store.
* The most common data type to read and write with is called `JSON` - JavaScript Object Notation.
* Once the data is in a savable format we need to `write` the data to the `url`, or file path we created earlier. 

``` swift
 /// Persists the device controllers array of Devices to disk
    func save() {
        // 1. Get the address to save a file to
        guard let devicesURL = devicesURL else { return }
        do {
            // 2. Convert the swift class into JSON data
            let data = try JSONEncoder().encode(devices)
            // 3. Save the data to the URL from step 1
            try data.write(to: devicesURL)
        } catch {
            print("Error Saving Devices", error)
        }
    }
```

Nice work! Let’s finish the load function and party.

##### Load
Within the body of the `loadContactFromDisk` function, we need to do the opposite of `save`. Let's outline the goals of a `load` function

* We first need to guard against the `devicesURL`  being  `nil`
* With that file not being `nil` we need to pull the contents, or `Data` on that `file`
* Then we need to try and convert, or `Decode` the `Data` that we pulled from the `file` to the proper data types for the app to use and display
* And finally we can set the newly loaded data to our `Source of Truth`
* Party

``` swift
  /// Loads  devices that are persist to the local disk and updates the model controllers `devices` property
    func load() {
        // 1. Get the address to save a file to
        guard let devicesURL = devicesURL else { return }
        do {
            // 2. Load the raw data from the url
            let data = try Data(contentsOf: devicesURL)
            // 3. Convert the raw data into our Swift class
            let devices = try JSONDecoder().decode([Device].self, from: data)
            self.devices = devices
        } catch {
            print("Error Loading Devices", error)
        }
    }
```

This rounds out your controller! Great work. Study and reflect on the code for the last three functions we wrote. Take a break and commit all your hard work to your remote repo.

---

## Wire Up the Views
All we have left to do is wire up the views with the proper functions. What’s exciting about this is that you’ve had a full week of practicing these steps and they will be relatively the same from now and for the duration of your career.

##### Devices Table View Controller
To give you a build guide we will list out the steps you’ll need to complete for this file to function as intended. As always, let’s start from the top down. Take a moment and write out the necessary `//MARK: - ` to give yourself a roadmap to follow.

Number Of Rows
* Set your number of rows to how many `devices` are on the `DeviceController`

Cell For Row
Because we want this to use the custom cell type you created and not a regular, old-and-busted, basic `UITableViewCell`. We will need to optionally `Type Cast` the cell that will be used.  If we are unable to optionally

* Retrieve the `device` object from the `Source of Truth` that has a matching `indexPath.row` as the cell being reused.
	* Don’t forget the cells `identifier`
Make a `//TODO: -` that reminds you to update the cell once that function is created.

### Alert Controller

We will create and present a `UIAlertController` when the user presses the `+` button. Let’s create a private helper function to accomplish this task. We will not need any additional information for this to work, so handle the parameters accordingly.

Within the body of your new `presentNewDeviceAlertController` function, we have a few goals. We need to first initialize a `UIAlertController` with the `title` and `message` we want. 

We need to add a `UITextField` to this `alertController` that the user can use to add the `name` of their device. 

We need two `UIAlertActions`.  One for is the user cancels, in which case we should dismiss the alert. And one for when the user `confirms`. When the user `confirms` we need to take the `text` from the `TextField` and initialize a new `Device` object. Then reload the `tableView`

Once the `UIAlertController` is formatted we need to present.


Challenge yourself to write the code necessary with the goals we just laid out. We will list more detailed instructions below.

AlertController:
* Create a new constant named `alertController` and assign the value of a `UIAlertController` initialized with the `title` of `”New Device"`, and `message` of `”Enter the name of your device below”`. We would prefer the style to be `.alert`.

* Using the `alertController` you just initialized add a UITextField. This should have a placeholder of `”New Device Name”`

``` swift
alertController.addTextField { textField in
            textField.placeholder = "New Device Name"
        }
```

Now we can create the two `UIAlertAction`s we need. Let's start with dismissing

* Create a new constant named `dismissAction` and assign the value of a `UIAlertAction` initialized with the `title` of `”Cancel"`, the style should be `.cancel`, and we can set the `handler` to `nil`.

* Access the `alertController` and add this action.

* Create a new constant named `confirmAction` and assign the value of a `UIAlertAction` initialized with the `title` of `”Create"`, the style should be `.default` 
* When you get to the `handler` press `enter, or return... I don’t what key your keyboard has. I’m a readMe…` to auto-complete / open up the `closure` . Within the body of the `closure` you just opened we need to:
	*  guard create a constant named `contentTextField` and assign the value of the `first` textField in the optional collection of `textFields`from the `alertController.
	* within the same `guard` create a constant named `name` and assign the value of the `text` from the `contentTextField` you just created.
	* Call the `create` method from your `DeviceController` and pass in the required data
	* Reload the tableView.
* Now you can add this `confirmAction` to the `alertController`
* Preset the `alertController` with an animation

```swift
/// Presents the create new device alert controller
    private func presentNewDeviceAlertController() {
        let alertController = UIAlertController(title: "New Device", message: "Enter the name of your device below", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "New Device Name"
        }
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(dismissAction)
        let confirmAction = UIAlertAction(title: "Create", style: .default) { _ in
            guard let contentTextField = alertController.textFields?.first,
                    let name = contentTextField.text  else { return }
            DeviceController.shared.createDevice(name: name)
            self.tableView.reloadData()
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
```

Call the `UIAlertContoller` helper function in the `IBAction` of the `addButton`

We have just a few more items before this file is complete... but for now, we should…. 

• A - Always
• B - Be
• C - Committing

Build. Run. Commit. Party

---

### Custom Cell

Okay, so now all we need to do is write the code for our custom cell to update its views. We also need a way to have the cell inform the tableView that it should handle the action of the user pressing the `deviceIsOnSwitch` switch. 

Let’s start with the logic for the `Custom Cell` and the `Protocol && Delegate` it will need.

To have the custom cell update its views we need to:
* Have `IBOutlets` for the view elements
* Helper function
	* One parameter of type `Device`
	* Set the `text` of the `label` to the value of the `name` property of the `device` passed in
	* Set the `isOn` of the `switch` to the value of the `isOn` property of the `device` passed in
	* Now would be a great time to navigate back to the `cellForRow(at:)` and complete the `TODO` you set up earlier
Welcome back

Build. Run. Commit. Take a well-deserved  15 min break.

---

###  Protocol and the Delegate that will perform the action

With our focus on separating the concerns of our files. Our goal is to have a way for the `cell` to manage its updating. However, the `cell` will not know what `device` object to display or update without the `TableView` providing that information. So what we need is a set of instructions (Protocol) that the `TableView` (Delegate) can follow at a given time. 

These instructions will provide all the necessary information for the `cell` to update accordingly.

We start this process by defining the `protocol`. Convention dictates that the `protocol` should be declared above the `class`

Declare a `protocol` named `DeviceTableViewCellDelegate`
	* Yes, it's the convention for the `protocol` name to have the word Delegate.
	* Using a `:` after the declaration allow this `protocol` to interact with `AnyObject`
	* Within the body of the `protocol` ; you *ONLY* define the `function` the `delegate` will perform. You do not add the body, or any additional information on *HOW* the delegate will perform the task.
		* Declare a function named `isOnSwitchToggled`
		* This function should have a parameter of type `DeviceTableViewCell`. We only want to update cells with that type.


To complete the `cell`s set up we only need to declare a property named `delegate`  of type `DeviceTableViewCellDelegate` optional. This property must be set to `weak`


In the body of the `IBAction` for the button ->  call the `delegate`, and it’s `delegate method`. Because we are on the file `DeviceTableViewCell` we can pass `self` into the parameter.

All the work we just completed lays the groundwork for our `Protocol` and `Delegate` to work together... We created the protocol and defined the `task` we need the delegate to perform.  We created a property named `delegate` that we will assign later. Whatever class we mark to be the delegate will need to define `how` it will accomplish the `task` we defined in the `protocol` body.

We completed the setup by calling our `delegate method` when the user toggles the `deviceIsOnSwitchButton`. That will be the trigger that starts the whole process.

Build. Run. Dance. Commit. Slay.

---

### Assign the God Damn Delegate

*( Everyone forgets this step… )*

Now that we have created our `protocol` and defined a `delegate` property we need to *hire* or assign a `class` to be the `delegate` and perform all the actions we need. 

In this case, we will be assigning the `DeviceListTableViewController` to be the `delegate` of the `DeviceTableViewCellDelegate` protocol.

Navigate to the `DeviceListTableViewController`. As is the convention, at the bottom of the file, extend this `class` to adopt the `DeviceTableViewCellDelegate` protocol.

Use the error to quickly add the `protocol stubs`

Now we can finally define *how* the `delegate` is to perform the action we need. 
* What `indexPath` the cell is on
* Retrieve the `device` object from the `Source of Truth` that has a matching `indexPath.row` as the cell.
* Call the `toggleIsOn(device:)` function from the `DeviceController`
* Have the cell update its views

Be sure to navigate to the `tableView(_ tableView: UITableView, cellForRowAt` function and assign the `delegate` property from the cell to `self`. Self, in this case, is the  `DeviceListTableViewController`

Boom! That's it! You nailed it. The protocol and its delegate are all set up.


Great work! The app should be in its final, working state. Be sure to test the functionality and resolve any bugs that may be present.

Build. Run. Commit. Take a break.

---
