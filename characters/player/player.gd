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

# Wall Jumping y Sliding
const wall_jump_pb = 400
const wall_slide_gravity = 100
var wall_sliding = false

# Dash
@export var can_dash: bool
var dash: bool

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D

			
func _physics_process(_delta):
	direccion = Input.get_axis("ui_left","ui_right")
	#velocity.x = direccion * speed

	var input_dir: Vector2 = input()

	# Condicional de movimiento
	if input_dir != Vector2.ZERO:
		aceleracion(input_dir)
	else:
		agregar_friccion()

	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
		
	match dash:
		true:
			input_dir.x = input_dir.x * (speed * 2) 
			
			if anim.play() == "Jump" or anim.play() == "Jump2":
				velocity.y += gravity
		false:
			velocity.y += gravity
			input_dir.x = input_dir.x * (speed * 2)
			
	#esta monda es para el primer salto desde el piso
	if Input.is_action_just_pressed("ui_accept"):
		if current_jump < max_jump:
			velocity.y -= velocity.y + jump
			current_jump = current_jump + 1	
			
	#esto resetea el saltiño
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
				
		if is_on_wall_only():
			sprite.flip_h = direccion > 0 if direccion != 0 else sprite.flip_h
			anim.play("Grab")		
				
		if current_jump == 2:
			if velocity.y < 0:
				anim.play("Jump2")
			else:
				anim.play("high")
				
	wall_slide_movement()
	movimiento_jugador()
	dash_movement()
	

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
	

func wall_slide_movement():
	
	if is_on_floor() and is_on_wall() and (Input.is_action_just_pressed("ui_up") or Input.is_action_pressed("ui_up")) and (Input.is_action_just_pressed("ui_left")):
		velocity.y += velocity.y
	
	if is_on_floor() and is_on_wall() and (Input.is_action_just_pressed("ui_up") or Input.is_action_pressed("ui_up")) and (Input.is_action_just_pressed("ui_right")):
		velocity.y += velocity.y
		
	if is_on_wall_only():
			velocity.y -= velocity.y - 100
			current_jump = 1
			if Input.is_key_pressed(KEY_SHIFT):
				velocity.y -= velocity.y

func dash_movement():
	if can_dash and Input.is_action_just_pressed("Dash"):
		dash = true
		can_dash = true
		$Dash.play()
		$Timers/Dash.start()

func _on_dash_timeout():
	dash = false
	$Timers/CanDash.start()

func _on_can_dash_timeout():
	can_dash = true
