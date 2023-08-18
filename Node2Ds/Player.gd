extends CharacterBody2D

var speed := 280
var direccion := 0.0
var jump := 700
var current_jump := 1
var max_jump := 2
const gravity := 30

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
func _physics_process(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
		
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
		velocity.y += gravity
	
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
				
	move_and_slide()
	




