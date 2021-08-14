extends Node
export(PackedScene) var Roca
var Score  # = 0  record en 0

func _ready(): # funcion godo
	randomize()
	
func nuevo_juego(): # funcion creada
	Score = 0
	$Player.inicio($PositionDeInicio.position) # pos de inicio
	$InicioTimer.start()
	$Interfaz.mostrar_mensaje("Listo!")
	$Interfaz.update_score(Score)
	$Musica.play()

func Game_over():
	$ScoreTimer.stop()
	$RocaTimer.stop()
	$Interfaz.game_over()
	$Audiofin.play()
	$Musica.stop()


func _on_InicioTimer_timeout():
	$RocaTimer.start()
	$ScoreTimer.start()
	


func _on_ScoreTimer_timeout():
	Score += 1
	$Interfaz.update_score(Score)


func _on_RocaTimer_timeout():
	$Path2D/RocaPosicion.set_offset(randi()) # pos al azar
	
	var R = Roca.instance() # var temporal 
	add_child(R) # crear roca
	
	# seleccionar una direccion
	var d = $Path2D/RocaPosicion.rotation + PI /2
	
	R.position = $Path2D/RocaPosicion.position
	
	d += rand_range(-PI /4, PI /4) # godo usa radianes No grados ej: 45º=0.0174533radianes
	R.rotation = d
	R.set_linear_velocity(Vector2(rand_range(R.velocidad_min, R.velocidad_max), 0).rotated(d))
	
