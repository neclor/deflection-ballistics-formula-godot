@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("Deflection", "res://addons/deflection_ballistics_formula/deflection_ballistics_formula.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("Deflection")
