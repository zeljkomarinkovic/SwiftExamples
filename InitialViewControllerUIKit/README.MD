# Programaticaly call view controller instad of storyboard

If we want to go this way and remove all storyboard files and use our own UIViewController to
be inital view, make sure to delete all .storyboard files and remove `xcodeporj.pbxproj` values

```
INFOPLIST_KEY_UILaunchStoryboardName = "";
INFOPLIST_KEY_UIMainStoryboardFile = "";
```
and remove from `info.plist`
```XML Property List
<key>UISceneStoryboardFile</key>
<string>Main</string>
```
After that do changes in SceneDelegate and initialize ViewController
