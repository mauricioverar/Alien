extends RigidBody2D

export (int) var velocidad_min
export (int) var velocidad_max
var tipo_roca = ["azul", "yellow"]


func _ready():
	$AnimatedSprite.animation = tipo_roca[randi() % tipo_roca.size()] # random
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() #eliminar roca
	
