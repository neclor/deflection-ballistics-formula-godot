@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("Deflection", "res://addons/deflection-ballistics-formula/deflection-ballistics-formula.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("Deflection")
