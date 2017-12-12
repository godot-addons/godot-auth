extends Node

const Auth = preload("res://addons/godot-auth/auth.gd")
const FileBackend = preload("res://addons/godot-auth/backend/file.gd")
const Pair = preload("res://addons/godot-auth/pair.gd")
const User = preload("res://addons/godot-auth/user.gd")

onready var backend = FileBackend.new("user://auth2")
onready var auth = Auth.new(backend)

var user

func _on_find_pressed():
	var id = $ui/panel/line_container/id.text

	# Lookup user in the backend by id
	user = backend.find(id)

	if user.has_method("first"):
		$ui/panel/info.text = user.second
		return

	$ui/panel/line_container/username.text = user.username
	$ui/panel/line_container/password.text = user.password

func _on_create_user_pressed():
	var id = $ui/panel/line_container/id.text.to_int()
	var username = $ui/panel/line_container/username.text
	var password = $ui/panel/line_container/password.text

	if id <= 0:
		$ui/panel/info.text = "Must enter a user ID"
		return

	if username == "":
		$ui/panel/info.text = "Username cannot be empty"
		return

	if password == "":
		$ui/panel/info.text = "Password cannot be empty"
		return

	var user = User.new(id, username, password, "active")
	var status = backend.create(user)
	if status.has_method("second"):
		$ui/panel/info.text = status.second
	else:
		$ui/panel/info.text = "Created user"

func _on_update_user_pressed():
	var id = $ui/panel/line_container/id.text.to_int()
	var username = $ui/panel/line_container/username.text
	var password = $ui/panel/line_container/password.text

	if id <= 0:
		$ui/panel/info.text = "Must enter a user ID"
		return

	if username == "":
		$ui/panel/info.text = "Username cannot be empty"
		return

	if password == "":
		$ui/panel/info.text = "Password cannot be empty"
		return

	var user = User.new(id, username, password, "active")
	var status = backend.update(user)
	if status.has_method("second"):
		$ui/panel/info.text = status.second
	else:
		$ui/panel/info.text = "Updated user"

func _on_remove_user_pressed():
	var id = $ui/panel/line_container/id.text.to_int()

	if id <= 0:
		$ui/panel/info.text = "Must enter a user ID"
		return

	var status = backend.remove(id)
	if status.has_method("second"):
		$ui/panel/info.text = status.second
	else:
		$ui/panel/info.text = "Removed user"

func _on_quit_pressed():
	get_tree().quit()
