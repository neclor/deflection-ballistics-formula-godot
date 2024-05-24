@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_autoload_singleton("Equation", "res://addons/equation_real_solver/equation_real_solver.gd")


func _exit_tree() -> void:
	remove_autoload_singleton("Equation")
