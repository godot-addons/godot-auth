extends Reference

const Pair = preload("res://addons/godot-auth/pair.gd")

var id
var username
var password
var status
var _valid_statuses = ["active", "inactive"]

func _init(id_, username_, password_, status_ = Status.ACTIVE):
	id = int(id_)
	username = str(username_)
	password = str(password_)
	set_status(status_)

func set_status(status_):
	if status_ == null:
		status_ = "active"

	if status_ in _valid_statuses:
		status = status_
	else:
		return Pair.new(false, str("Invalid status: status=", status_))

func to_json():
	return to_json({id = id, username = username, password = password, status = status})
