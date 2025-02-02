class_name State extends Node

signal transition_to_state(caller : State, state: String, msg: Dictionary)

func on_enter(_msg):
	pass

func on_exit(_msg):
	pass

func on_update(_delta: float):
	pass

func on_physical_update(_delta: float):
	pass
