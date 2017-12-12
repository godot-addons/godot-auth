extends Reference

const Pair = preload("res://addons/godot-auth/pair.gd")

"""
Constructor accepting a backend repository
"""
func _init(backend):
	if backend == null:
		return Pair.new(false, "No backend provided")
