extends CharacterBody2D

var speed := 280
var direccion := 0.0
var jump := 670
const gravity := 30

@onready var anim := $AnimationPlayer
@onready var sprite := $Sprite2D
func _physics_process(delta):
	direccion = Input.get_axis("ui_left","ui_right")
	velocity.x = direccion * speed
		
	sprite.flip_h = direccion < 0 if direccion != 0 else sprite.flip_h
	
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y -=jump
				
	if!is_on_floor():
		velocity.y += gravity	
	
	if is_on_floor():	
		if direccion != 0:
			anim.play("Run")
		else:		
			anim.play("Idle")
	else:		
		if velocity.y < 0:
			anim.play("Jump")
		else:
			anim.play("high")

	move_and_slide()
	




