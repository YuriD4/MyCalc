# MyCalc app!

It was quite interesting task from different perspectives, I'll try to briefly describe my thoughts below.

## General summary
It was a challenge from a general perspective, as I've never created a real world product that supports SwiftUI only and iOS15+. No app or scene delegate, no visual info.plist, that was interesting.
So I decided to use this opportunity to experiment a little bit with architecture and different lightweight but flexible and generic solutions. 

In total I've spend around 10 hours. Around 60-70% of time was spent for general architecture. Because in real life when we speak about "features" - in most cases it's something atomic, not complex, something quite common, but flexible architecture always pays off a lot. 

## Architecture

I chose modular architecture. So the rule is: 1 feature (or major flow) = 1 package. Also I wanted to break business logic into packages, starting from relatively independent components like networking layer, logging, analytics, etc.

Also I chose MVVM as the main pattern. There are many debates and nice approaches to handle SwiftUI app. Also there are many articles telling that with SwiftUI we don't need view models and we should just communicate with services without any middleware. I don't agree with that. If we speak about simple home project that may work, but not further.

Also, something like VIPER is quite debatable. That can and will work nice with something complex, but as the practice shows in most cases....there's no many benefits of breaking the logic into interactions and presenters. So I choose MVVM as the best balanced option between complexity and maintainability. Also, if needed, View implementation may be changed for UIKit quite quickly.

Several classes were covered with unit tests. I didn't have enough time, chatgpt did that work for me, with my help.

**APPEnvironment SPM**
This is a low level spm that may be used by any other package. It contains only one enum:
```swift
public enum APPEnvironment {
    case dev
    case prod
}
```
So we can pass current env across the whole app.

**MCCoordinator SPM**
```swift
public protocol Coordinator: AnyObject, ObservableObject {

    var children: [AnyCoordinator] { get set }

    associatedtype Output: View

    func start() -> Output

}
```
Simple and still nice solution to maintain basic navigation across the swiftUI app. Had to research a little bit and google to make inheritance work in a proper way, thanks to chatgpt final version works well.

**Networking SPM**
NetworkReachabilityManager + APIManager.

Simple APIManager, that uses Request as input and returns response.
Of course, there are thousands of right ways to implement networking layer. We may use something like Moya as an orchestrator and a main assembler of requests, api versioning, etc. 

I didn't want to add any third party dependency here so I created a light-weight solution. 
We should just use Request entity in other SPMs, that will handle different base urls for different featuers, etc.

**MCSharedUI SPM**
Standard package that includes shared UI components, color palette (schemes), ui wrappers, etc.

**Feature SPMs**
Every feature is wrapped in a separated spm, so it can be tested and launched (in a preview mode) without main app.
The best possible case for future - almost every feature may be launched as an independent app.

## Not finished features
User Interface. Unfortunately, didn't have time to adapt it for landscape and iPad. It's a common task for UIKit, this evening will research for an efficient way in SwiftUI.

Feature toggling. Applied basic manager that returnes active offline features. For example, we can add loading screen at the beginning of app launch + firebase remote config (their API is quite slow but free) and we will have a complete remote feature toggling mechanism for released app.

Error feedback. Connection errors and basic errors are shown to user via standard mechanism. It would be nice to create an Analytics SPM to track basic events and user generated (and system generated) errors and push (Amplitude, firebase, whatever). Also it would be nice to implement system logging and something like Pulse app for user-friendly networking debugging.

Color Schemes. Settings tab was planned to be a holder of this feature. It's quite a common one, didn't have time at the end to implement.

Crashlytics. May be implemented via Firebase following their tutorial.

Pipelines. We may add a basic Fastlane pipeline even on a local machine.
It may look like:

```ruby
private_lane :build_upload do |options, bundle_id, scheme|
    retrieve_api_key # Retrieves the API key from the App Store Connect API
    check_certificates(bundle_id) # Checks if certificates are valid
    scan # Run tests
    update_sigh(bundle_id, options[:testflight]) # Updates the provisioning profiles
    increment_build(options, bundle_id) # Increments the build number
    build_app_scheme(scheme, options[:testflight]) # Builds the app
    distribute_build(options) # Distributes the build to the App Store or Firebase
    clean_reset_artifacts # Cleans the build artifacts and resets the git repo
    send_slack_notification(scheme) # Sends a notification to the team
  end
```
If it is allowed by security policy I would always choose drag-and-drop bitrise pipelines. 
