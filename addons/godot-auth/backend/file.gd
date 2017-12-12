extends "res://addons/godot-auth/backend.gd"

const Pair = preload("res://addons/godot-auth/pair.gd")
const User = preload("res://addons/godot-auth/user.gd")

const AUTH_DIR = "user://auth"

var auth_dir

"""
Constructor accepting directory to store auth files
"""
func _init(auth_dir_ = AUTH_DIR):
	auth_dir = str(auth_dir_)

	# If the auth directory doesnt exist, create it
	var dir = Directory.new()
	if !dir.dir_exists(auth_dir):
		dir.open("user://")
		dir.make_dir(auth_dir)

func create(user):
	var filename = str(auth_dir, "/", user.id, ".json")

	var dir = Directory.new()
	if dir.file_exists(filename):
		return Pair.new(false, str("Auth file already exists for user: id=", user.id))

	var file = File.new()
	file.open(filename, File.WRITE)
	if file.is_open(): file.store_line(user.to_json())
	file.close()

	return Pair.new(true, str("Successfully created auth file for user: id=", user.id))

func find(id):
	var filename = str(auth_dir, "/", id, ".json")

	var dir = Directory.new()
	if !dir.file_exists(filename):
		return Pair.new(false, str("Auth file does not exist for user: id=", id))

	# User variable to return back after hydrating from file
	var user

	# Open file and read the data in
	var file = File.new()
	file.open(filename, File.READ)
	var t = parse_json(file.get_as_text())
	file.close()

	# Debug output
	print(t)

	return User.new(t.id, t.username, t.password, t.status)

func update(user):
	var filename = str(auth_dir, "/", user.id, ".json")

	var dir = Directory.new()
	if !dir.file_exists(filename):
		return Pair.new(false, str("Auth file does not exist for user: id=", user.id))

	var file = File.new()
	file.open(filename, File.WRITE)
	if file.is_open(): file.store_line(user.to_json())
	file.close()

	return Pair.new(true, str("Successfully updated auth file for user: file=", filename))

func remove(id):
	var filename = str(auth_dir, "/", id, ".json")

	var dir = Directory.new()
	if !dir.file_exists(filename):
		return Pair.new(false, str("Auth file does not exist for user: id=", id))

	dir.remove(filename)

	return Pair.new(true, str("Successfully removed auth file for user: file=", filename))

func disable(id):
	var user = find(id)

	user.set_status("inactive")
	update(user)
