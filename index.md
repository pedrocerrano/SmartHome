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

We feel confident that you will be able to create this design independently. A Few notes:

- There is no segue
- The `+` button will present an alert
- This is a custom cell and will require a class to manage it

Once you have created the necessary files and the necessary `IBOutlets`and `IBActions` please run the app, and make a commit.

---

## **Model**

Each `Model` will need a file to manage its properties and functions. Many of these methods will be familiar to you. Let’s start with our `Device` Model.

1.  ****Create a `Device` model with the following properties
    - name
    - isON
2. Create the member-wise initializer

> At this time, the instructions will not allow our users to delete `Device` Objects. You as a developer may choose to build in this feature if you wish.
> 

Nice work! Make a commit now that your Model is created. Be sure to drink some water.

---

## **Device Controller**

Create the necessary file to hold your `DeviceController` class. Once you have that step done, along with creating the actual `class` define the following `method signatures`:

- create
- toggleIsOn
- save
- load

Make a mark for your `properties` and create the following `properties`:

- A singleton
    - Complete the creation of the singleton
- A source of truth
    - Complete the source of truth creation.
    - Be sure to use the right types

Make a mark under the properties titled: `Initializers` and write the following code that matches the following description.

1. Capture the initialization of the `DeviceController` class. Whenever this file is initialized we will load the data from the disk.
- **Spoiler: How do I write this?**
    
    ```swift
    init() {
            load()
        }
    ```
    
1. Jump into the `create` function and define one parameter for the `name` 
    - Complete this function.
        - Be sure to call `save`
2. To complete the `toggleIsOn` we need to know what `Device` the user is toggling. 
    - Within the body:
        - Toggle the `isOn` of the `device`
        - save

Okay! Well done! At this time you should have your `properties`, `singleton`, and `CRUD` functions completed. The `save` and `load` functions should just be method signatures at this time.

> Make a commit.
> 

---

## **Save, Load, and the URL it all goes to**

Before we start filling out the `save` and `load` functions there is one final property we need. For readability, we recommend creating this under the `load` function.

1. Define a `private` variable with the name `sevicesURL` that is of the type `URL` optional. 
2. This will be a `computed property`, which means the value will result from some computation. You define a computed property by opening a scope following the type.
- **Spoiler: How do I write this?**
    
    ```swift
    private var devicesURL: URL? {
    // Computed Property
    }
    ```
    

### **Url**

Within the body of the `devicesURL` computed property, we need to accomplish a few goals….

We need to locate a file where we can save the data for this application. Because the data will be saved onto the phone the file path will be a URL. The best place to save basic data is directly in the `Documents` directory on the phone.

1. guard while creating a new constant named `documentsDirectory`
- Assign this constant the value of the FIRST `URL` for the `.documentsDirectory`, in `.userDomainMask`from the collection of `urls` accessible via the `default` singleton from the `FileManger` class.
    - return nil if you can’t create this value
1. Secondly - we need to assign the proper `Path Comment` to locate this file again. We recommend `devices.json`
    - create a new constant named `url` and assign it the value of the `documentsDirectory` you created earlier, appended with the proper `Path Component`
    - Finally - when all is said and done we can return a `url` that we can use repeatedly.
        - return the url

We mark this computed property as private because we don’t want any other class to have access to this property. It's, well, private property haha.

- It's okay to re-use jokes, right?

---

### **Save**

Save, and load, will seem intimidating at the start but as we break into the code and practice, it will become more approachable. The best news is that the format we will use for today's project is the SAME for every project going forward.

Within the body of the `save` function, we need to accomplish a few goals.

1. We need a location to save the data. Luckily we’ve already created this we just need to ensure it's not `nil`
    1. Hint, it needs to be a `URL`
2. Next, we need to take all of the content we want to save `Objects`, `Strings`, and  `Everything`, and encode it into a `data` type the computer can read and store.
    1. The most common data interchange format used to read and write is `JSON` - JavaScript Object Notation.
3. Once the data is in a savable format we need to `write` the data to the `url`, or file path we created earlier.
- **Spoiler: How do I write this?**
    
    ```swift
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

---

### **Load**

Within the body of the `loadContactFromDisk` function, we need to do the opposite of `save`. Let's outline the goals of a `load` function.

1. We first need to guard against the `devicesURL` being  `nil`
2. With that file not being `nil` we need to pull the contents, or `Data` on that `file`
3. Then we need to try and convert or `Decode` the `Data` that we pulled from the `file` to the proper data types for the app to use and display.
    1. Don’t forget to add `.self` to the datatype.
4. And finally, we can set the newly loaded data to our `Source of Truth`
5. Party
- **Spoiler: How do I write this?**
    
    ```swift
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
    

> This rounds out your controller! Great work. Study and reflect on the code for the last three functions we wrote. Take a break and commit your hard work to your remote repo.
> 

---

## **Wire Up the Views**

All we have left to do is wire up the views with the proper functions. What’s exciting about this is that you’ve had a full week of practicing these steps and they will be relatively the same from now and for the duration of your career.

### **Devices Table View Controller**

To give you a build guide we will list the steps you’ll need to complete for this file to function as intended. As always, let’s start from the top down. Take a moment and write out the necessary `//MARK: -` to give yourself a roadmap to follow.

**Number Of Rows**

1. Set your number of rows to how many `devices` are on the `DeviceController`

**Cell For Row**

1. Because we want this to use the custom cell type you created and not a regular, old-and-busted, basic `UITableViewCell`. We will need to “optionally `Type Cast`  “ the cell used.
    1. If the `typecast` was unsuccessful return a `UITableViewCell` initialized.
2. Retrieve the `device` object from the `Source of Truth` with a matching `indexPath.row` as the cell being reused.
3. Don’t forget the cell `identifier`.
4. Make a `//TODO: -` that reminds you to update the cell once that function is created.

**Alert Controller**

We will create and present a `UIAlertController` when the user presses the `+` button.

1. Let’s create a `private` helper function to accomplish this task. We will not need any additional information for this to work, so handle the parameters accordingly.

Within the body of your new `presentNewDeviceAlertController` function, we have a few goals.

1. We need to initialize a `UIAlertController` with the `title` and `message` we want.
2. We need to add a `UITextField` to this `alertController` that the user can use to add the `name` of their device.
3. We need two `UIAlertActions`. 
4. One for the user to cancel.
    1. In which case we should dismiss the alert.
5. One for when the user `confirms`. 
    1. When the user `confirms` we need to take the `text` from the `TextField` and initialize a new `Device` object.
6. Then reload the `tableView`
7. Once the `UIAlertController` is formatted we need to present it.

> Challenge yourself to write the code necessary with the goals we just laid out. We will list more detailed instructions below.
> 

### AlertController

1. Create a new constant named `alertController` and assign the value of a `UIAlertController` initialized with the `title` of `”New Device"`, and the `message` of `”Enter the name of your device below”`.
    1. We would prefer the style to be `.alert`.
2. Using the `alertController` you just initialized add a UITextField. This should have a placeholder of `”New Device Name”`
    - Spoiler: How do I write this?
        
        ```swift
        alertController.addTextField { textField in
                    textField.placeholder = "New Device Name"
                }
        ```
        
3. Now we can create the two `UIAlertAction`s we need.
4. Let's start with dismissing.
5. Create a new constant named `dismissAction` and assign the value of a `UIAlertAction` initialized with the `title` of `”Cancel"`, the style should be `.cancel`, and we can set the `handler` to `nil`.
6. Access the `alertController` and add this action.
7. Create a new constant named `confirmAction` and assign the value of a `UIAlertAction` initialized with the `title` of `”Create"`, the style should be `.default`
8. When you get to the `handler` press `enter or return... I don’t what key your keyboard has. I’m a readMe…` to auto-complete / open up the `closure`. 
9. Within the body of the `closure` you just opened we need to `guard` create a constant named `contentTextField` and assign the value of the `first` text field in the optional collection of `text` f`ields` from the `alertController.
10. Within the same `guard` create a constant named `name` and assign the value of the `text` from the `contentTextField` you just created.
11. Call the `create` method from your `DeviceController` and pass in the required data.
12. Reload the tableView.
13. Now you can add this `confirmAction` to the `alertController`
14. Preset the `alertController` with an animation
15. Call the `UIAlertContoller` helper function in the `IBAction` of the `addButton`
- Spoiler: How do I write this?
    
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
    

> We have just a few more items before this file is complete... but for now, we should….
> 
- A - Always
- B - Be
- C - Committing

> Build. Run. Commit. Party
> 

---

### **Custom Cell**

Okay, so now all we need to do is write the code for our custom cell to update its views. We also need a way to have the cell inform the `tableView` that it should handle the user's action of pressing the `deviceIsOnSwitch` switch. Let’s start with the logic for the `Custom Cell` and the `Protocol && Delegate` it will need.

**To have the custom cell update its views we need to:**

1. Have `IBOutlets` for the view elements
2. Helper function
    - One parameter of the type `Device`
    - Set the `text` of the `label` to the value of the `name` property of the `device` passed in
    - Set the `isOn` of the `switch` to the value of the `isOn` property of the `device` passed in.
    - Now would be a great time to navigate back to the `cellForRow(at:)` and complete the `TODO` you set up earlier.
3. Welcome back

> Build. Run. Commit. Take a well-deserved 15 min break.
> 

---

### **Protocol and the Delegate that will perform the action**

With the focus on separating the concerns of our files. Our goal is to have a way for the `cell` to manage its updating. However, the `cell` will not know what `device` object to display or update without the `TableView` providing that information. So what we need is a set of instructions (Protocol) that the `TableView` (Delegate) can follow at a given time. These instructions will provide all the necessary information for the `cell` to update accordingly.

We start this process by defining the `protocol`. Convention dictates that the `protocol` should be declared above the `class`

1. Declare a `protocol` named `DeviceTableViewCellDelegate` 
    - Yes, it's the convention for the `protocol` name to have the word Delegate.
    - Using a`:` after the declaration allow this `protocol` to interact with `AnyObject`
2. Within the body of the `protocol`; you *ONLY* define the `function` the `delegate` will perform. You do not add the body or any additional information on *HOW* the delegate will perform the task.
3. Declare a protocol method named `isOnSwitchToggled`
4. This function should have a parameter of type `DeviceTableViewCell`. We only want to update cells with that type.
5. To complete the `cell`s set up we only need to declare a property named `delegate` of type `DeviceTableViewCellDelegate` optional.
    - This property must be set to `weak`
6. In the body of the `IBAction` for the button, -> call the `delegate`, and its `delegate method`. Because we are on the file `DeviceTableViewCell` we can pass `self` into the parameter.

> All the work we just completed lays the groundwork for our `Protocol` and `Delegate` to work together. We created the protocol and defined the `task` we needed the delegate to perform. We created a property named `delegate` that we will assign later. Whatever class we mark as the delegate will need to define `how` it will accomplish the `task` we defined in the `protocol` body. We completed the setup by calling our `delegate method` when the user toggles the `deviceIsOnSwitchButton`. That will be the trigger that starts the whole process.
> 

> Build. Run. Dance. Commit. Slay.
> 

---

### **Assign the God Damn Delegate**

*( Everyone forgets this step… )*

Now that we have created our `protocol` and defined a `delegate` property we need to *hire* or assign a `class` to be the `delegate` and perform all the actions we need. In this case, we will be assigning the `DeviceListTableViewController` to be the `delegate` of the `DeviceTableViewCellDelegate`protocol.

1. Navigate to the `DeviceListTableViewController`.
2. As is the convention, at the bottom of the file, extend this `class` to adopt the `DeviceTableViewCellDelegate` protocol.
3. Use the error to add the `protocol stubs` quickly.
4. We can finally define *how* the `delegate` is to perform the action we need.
5. To accomplish this we need…
    1. To find what `indexPath` the cell has.
    2. Retrieve the `device` object from the `Source of Truth` with a matching `indexPath.row` as the cell.
    3. Call the `toggleIsOn(device:)` function from the `DeviceController`
    4. Have the cell update its views

> Be sure to navigate to the `tableView(_ tableView: UITableView, cellForRowAt` function and assign the `delegate` property from the cell to `self`. Self, in this case, is the  `DeviceListTableViewController` this is the act of assigning the GD delegate.
> 

Boom! That's it! You nailed it. The protocol and its delegate are all set up. Great work! The app should be in its final, working state. Be sure to test the functionality and resolve any bugs present.

---

# Build. Run. Commit. Take a break.

Submit your completed project to LearnUpon with your GitHub link.


# **Smart Home: Part 2**

In this project you will be starting from a completed version of part one of the smart home app. If you do not have a completed `Part 1` version please switch to the branch `Day2-Starter`

```bash
  git switch Day2-Starter
```

If you are using the `Part2-Starter` project then we have provided you with the UI for this part of the project. All you have to do is hook up the `Notifications` that will allow the user to toggle on or off all of their smart devices. 

If you are working from your completed day 1 branch please begin at the `ToggleAllViewController` section.

Students who complete this project independently or as a pairing will showcase their understanding of the following principles:

- IBActions
- Global Properties
- Notifications
- Observers
- Selectors

---

## **ToggleAllViewController**

For those that need to build the UI please

- Create a new `UIViewController` called `ToggleAllViewController`.
- Hook it up to the view that looks like this.

![https://github.com/Stateful-Academy/SmartHome/raw/Day2-Starter/toggleVCScreenShot.png](https://github.com/Stateful-Academy/SmartHome/raw/Day2-Starter/toggleVCScreenShot.png)

### Okay, now that the UI is built

1. Please create a `ToggleAllDevicesViewController` and subclass the proper `View Controller`
2. Create two `IBActions` 
    1. One from the top button called `turnAllOnButtonTapped`
    2. One from the bottom button called `turnAllOffButtonTapped`.

Next I want you to create something called a `Global Property`. A `Global Property` is a property declared outside of any `class` that allows global access to it.

1. Create a Constant Global Property called `TurnOnAllNotificationName`
2. Assign `TurnOnAllNotificationName` a value of `Notification.Name(rawValue: “TurnOnAllDevicesNotification”)`

This is creating a global Notification name that will allow us to create notifications and observers without having to worry about typos.

1. Create another Global Constant called `TurnAllOffNotificationName`
2. Assign `TurnAllOffNotificationName` a value of `Notification.Name(rawValue: “TurnOffAllDevicesNotification”)`

Inside the `turnAllOnButtonTapped` action create a Notification using the `TurnAllOnNotificationName` .

1. To do so we will type `NotificationCenter.default.post(name: TurnAllOnNotificationName, object: nil)`
2. This is creating a notification that will post to the rest of the app when ever it is called, any `Observers` listening to the same name will then run the code in their `Selectors`.

Following the same steps above, create a second notification so we can turn all of our smart home devices off.

1. In the `turnOffAllButtonTapped` action create a `Notification` just like the one above, but this time use the `TurnAllOffNotificationName` instead.

Great work! Make a commit this work to Github

---

# **DevicesTableViewController**

The first thing we need to do on our `DevicesTableViewController` is add some `Observers` to listen for the `TurnAllOnNotificationName` notification and the `TurnAllOffNotificationName`

1. Create an observer that listens for `TurnAllOnNotificationName` in our `ViewDidLoad`

### Spoiler: How do I write this?

```swift
NotificationCenter.default.addObserver(self, selector: "leave this blank for now", name: TurnAllOnNotificationName, object: nil)
```

You might notice that we left the `selector` blank. This is because we haven’t built out the function that it’s going to call yet.

1. On `DevicesTableViewController` create a function called `turnAllDevicesOn` that takes in no parameters,
    1. print `Turning All Devices On` inside `turnAllDevicesOn`s implementation
2. pass `turnAllDevicesIOn` into the selector of the Notification in our `viewDidLoad`. To do this you type `#selector(turnAllDevicesOn)`

Your going to get an error that looks like this:

![Screen Shot 2022-05-18 at 4.34.57 PM.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3985bd99-2c27-461a-a374-0dadcecab93f/Screen_Shot_2022-05-18_at_4.34.57_PM.png)

This error is saying that our `turnAllDevicesOn`function is not exposed to objective-C *apples original iOS language*. To solve this all we need to do is:

1. Add `@objc` the the front of `turnAllDevicesOn` so it looks like this `@objc func turnAllDevicesOn()` to expose it to Objective-C
2. Repeat these steps but for `TurnAllOffNotificationName` this time.

Run the app and press `Turn All On` on the `All` tab. You should see a message in your Log saying `Turning All Devices On`, and when you press `Turn All Off` you should see a message saying `Turning All Devices Off`. 

> “If it’s not working… debug it”
-Karl, Stateful 2022
> 

---

# **DeviceController**

Lets create a helper function to either Enable of Disable all of our smart home devices

1. Open the `DeviceController.swift` file
2. Create a new function called `toggleAllDevicesOn` that takes in a `boolean` called `on`
3. Inside the function loop through the `devices` property and set all of the `isOn` properties equal too `on`.
4. Open `DevicesTableViewController`
5. Inside the `turnAllDevicesOn` and `turnAllDevicesOff` functions call `deviceController.toggleAllDevices(on: true)` and `deviceController.toggleAllDevices(on: false)`respectively.

> Run your app and make sure that your `Turn All On` and `Turn All Off` buttons enable and disable all of the devices in your Smart Home
> 

# Build. Run. Commit. Take a break.

Submit your completed project to LearnUpon with your GitHub link.
