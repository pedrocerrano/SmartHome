# Smart Home: Part 2
In this project you will be completing part one of the smart home app. We will provide you with the UI for this part of the project so all you have to do is hook up the `Notifications` that will allow the user to toggle on or off all of their smart devices

Students who complete this project independently or as a pairing will showcase their understanding of the following principles:

* IBActions
* Global Properties
* Notifications
* Observers
* Selectors
---
# ToggleAllViewController
For this app we only need you to wire up one view

Lets start by creating a new `UIViewController` called `ToggleAllViewController`.  After you have created said `ViewController` hook it up to the view that looks like this.
[image:AC09555B-DAD0-4662-9B76-46EA63BCCF0A-2882-00001A457994D962/Screen Shot 2022-01-26 at 5.24.32 PM.png]

After you have finished hooking your `ToggleAllViewController` up to the `ViewController` shown above, create two `IBActions` ; One from the top button called `turnAllOnButtonTapped`, and one from the bottom button called `turnAllOffButtonTapped`.

Next I want you to create something called a `Global Property`. A `Global Property` is a property declared outside of any class that allows global access to it. In our case I want you to create a Constant Global Property called `TurnOnAllNotificationName` that is equal to `Notification.Name(rawValue: “TurnOnAllDevicesNotification”)`

This is creating a global Notification name that will allow us to create notifications and observers without having to worry about  typos.

Lets create a second one called `TurnAllOffNotificationName` that is equal to `Notification.Name(rawValue: “TurnOffAllDevicesNotification”)`

Inside our `turnAllOnButtonTapped` action lets create a Notification using the `TurnAllOnNotificationName` . To do so we will type `NotificationCenter.default.post(name: TurnAllOnNotificationName, object: nil)`

This is creating a notification that will post to the rest of the app when ever it is called, any `Observers` listening to the same name will then run the code in their `Selectors`.

Lets create a second notification so we can turn all of our smart home devices off. In the `turnOffAllButtonTapped` action create a `Notification` just like the one above, but this time use the `TurnAllOffNotificationName` instead.

---

# DevicesTableViewController
The first thing we need to do on our `DevicesTableViewController` is add some `Observers` to listen for the `TurnAllOnNotificationName` notification and the `TurnAllOffNotificationName`

In our `ViewDidLoad`  lets create an observer that listens for `TurnAllOnNotificationName`

`NotificationCenter.default.addObserver(self, selector: *leave this blank for now*, name: TurnAllOnNotificationName, object: nil)`

You might notice that we left the `selector` blank. This is because we haven’t built out the function that its going to call yet.

On our `DevicesTableViewController`  create a function called `turnAllDevicesOn` that takes in no parameters, for now just have it print `Turning All Devices On`. 

Next lets head back up to our Notification and try to pass `turnAllDevicesIOn` into the selector. But typing `#selector(turnAllDevicesOn)`

Your going to get an error that looks like this
[image:070CF87F-2139-4C8A-827A-F9EF661A96E6-2882-00001B6FEF1220EB/Screen Shot 2022-01-26 at 5.54.27 PM.png]
This error is saying that our `turnAllDevicesOn` function is not exposed to objective-C *apples original iOS language*. To do this we simply add `@objc` the the front of our function so it looks like this `@objc func turnAllDevicesOn()`

Lets repeat these steps but for `TurnAllOffNotificationName` this time.

Run the app and press `Turn All On` on the `All` tab. You should see a message in your Log saying `Turning All Devices On`, and when you press `Turn All Off` you should see a message saying `Turning All Devices Off`. If you don’t something isn’t working… debug that I guess.

---

# DeviceController
If you app is in working condition head on over to the `DeviceController.swift` file and create a new function that will toggle toggle all our devices either On or Off.

To do that lets create a function called `toggleAllDevicesOn` that takes in a `boolean` called `on`. Inside the function loop through the `devices` property and set all of the `isOn` properties equal too `on`.

Head back to the `DevicesTableViewController` and go to your `turnAllDevicesOn` and `turnAllDevicesOff`  functions. Inside of their implementations call `deviceController.toggleAllDevices(on: true)` and `deviceController.toggleAllDevices(on: false)` respectively. 

Run you app and make sure that your `Turn All On` and `Turn All Off` buttons enable and disable all of the devices in your Smart Home


