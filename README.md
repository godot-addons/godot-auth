# godot-auth
Godot Engine (v3.0) Authentication System

## Running the example

1. Click start menu, type `Command Prompt`
1. Right-click `Command Prompt` and click on `Run as Administrator`
1. Run the commands below, assuming you checked out the repo into a `Documents\src\godot-auth` directory.

```powershell
cd c:\Users\YOUR_USERNAME\Documents\src\godot-auth\example
mklink /D addons c:\Users\YOUR_USERNAME\Documents\src\godot-auth\addons
```

If you check out the main.gd, as of this writing, there's probably a good bit of cleanup that can be done to avoid DRY.

## File Backend

It seems that the `user://` path resolves to `C:\Users\YOUR_USERNAME\AppData\Roaming\Godot\app_userdata\Godot Auth`.

## Links

* https://coffeecoderblog.wordpress.com/2016/07/03/creating-a-save-system-in-godot/
* https://godotengine.org/qa/6491/read-&-write
* https://godotengine.org/qa/315/saving-loading-files-there-any-build-file-parsing-can-use-how
