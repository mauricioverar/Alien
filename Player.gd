extends Area2D
export (int) var velocidad
var Movimiento = Vector2() # al estar vacio () es 0,0 x,y
var limite # de pantalla(640x960)
signal golpe # evento golpe

func _ready():
	hide() # ocultar player
	limite = get_viewport_rect().size

func _process(delta):
	Movimiento = Vector2()
	
	if Input.is_action_pressed("ui_right"):
		Movimiento.x += 1
		$Fuego.position.y = 0 # pos de inicio
	if Input.is_action_pressed("ui_left"):
		Movimiento.x -= 1
		$Fuego.position.y = 0 # pos de inicio
	if Input.is_action_pressed("ui_down"):
		Movimiento.y += 1 # 
		if !Input.is_action_pressed("ui_left") && !Input.is_action_pressed("ui_right"):
			$Fuego.position.y = -20 # pixeles en -120 se ve mas lejos la particula al bajar
	if Input.is_action_pressed("ui_up"):
		Movimiento.y -= 1
		$Fuego.position.y = 0 # pos de inicio
		
	if Movimiento.length() > 0: # si se mueve
		Movimiento = Movimiento.normalized() * velocidad # normalizar para mantener velocidad

	position += Movimiento * delta # * tiempo real, actualizar movimiento
	position.x = clamp(position.x, 0, limite.x) # para q no salga de pantalla
	position.y = clamp(position.y, 0, limite.y)
	
	if Movimiento.x != 0:
		$Sprite_player.animation = "lado" # signo $ para llamar a un Nodo
		$Sprite_player.flip_h = Movimiento.x < 0 # solo si va a izquierda
		$Sprite_player.flip_v = false # para q no quede de cabeza
	elif Movimiento.y != 0:
		$Sprite_player.animation = "espalda"
		$Sprite_player.flip_v = Movimiento.y > 0
	else :
		$Sprite_player.animation = "frente"


func _on_Player_body_entered(body): # cuando colision
	hide()
	emit_signal("golpe")
	$CollisionShape2D.disabled = true
	
func inicio(pos):
	position = pos
	show() # mostrar al player
	$CollisionShape2D.disabled = false
	
	
	
	
	
	
	
	
	
	
	
