extends CharacterBody2D
# FIX: Movimiento a la izquierda, se queda como bloqueado hasta que se salta y se vuelve a bloquear
# TODO: Smooth movement
	# - Suavizar la caida	
# TODO: Dash
# TODO: Wall jumping y sliding

var speed := 280
var direccion := 0.0
var jump := 950
var current_jump := 1
var max_jump := 2
const gravity := 30

# Smooth movement
var acc = 50 
var friccion = 20

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D

func _physics_process(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	#velocity.x = direccion * speed

	var input_dir: Vector2 = input()

	# Condicional de movimiento
	if input_dir != Vector2.ZERO:
		aceleracion(input_dir)
	else:
		agregar_friccion()

	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
	
	#esta monda es para el primer salto desde el piso
	if Input.is_action_just_pressed("ui_accept"):
		if current_jump < max_jump:
			velocity.y -= velocity.y + jump
			current_jump = current_jump + 1
	#esto resetea el saltiño
	if is_on_floor():
		current_jump = 1
		
	#pal segundo salto o para saltar desde el aire
	if !is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		if current_jump != max_jump:
			velocity.y -= velocity.y + jump 
			current_jump = current_jump + 1
	if is_on_floor():
		current_jump = 1

	if !is_on_floor():
		velocity.y += (gravity + acc) - (friccion)
	
	if is_on_floor():	
		if direccion != 0:
			anim.play("Run")
		else:		
			anim.play("Idle")
	else:
		if current_jump == 1: 		
			if velocity.y < 0:
				anim.play("Jump")
			else:
				anim.play("high")
		if current_jump == 2:
			if velocity.y < 0:
				anim.play("Jump2")
			else:
				anim.play("high")
				
	movimiento_jugador()

func input() -> Vector2:
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	input_dir = input_dir.normalized()
	return input_dir
	
func aceleracion(direcccion):
	velocity = velocity.move_toward(speed * direcccion, acc - friccion)

func agregar_friccion():
	velocity = velocity.move_toward(Vector2.ZERO, friccion)

func movimiento_jugador():
	move_and_slide()
