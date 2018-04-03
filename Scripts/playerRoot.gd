extends KinematicBody2D

var speed = 80
var rayCastSize = 15
onready var rayCast = $RayCast2D
onready var spr = $Sprite
var object_hit 
var key = 0

func _ready():
	pass

func _physics_process(delta):
	var left = 0
	var right = 0
	var up = 0
	var down = 0
	var horizontal = 0
	var vertical = 0
	
	# Movimentacao por WASD
	if Input.is_action_pressed("ui_left"):
		left = -1
		rayCast.cast_to = Vector2(-rayCastSize,0)
		spr.texture = load("res://Sprites/Player/PlayerTemp3.png")
	if Input.is_action_pressed("ui_right"):
		right = 1
		rayCast.cast_to = Vector2(rayCastSize,0)
		spr.texture = load("res://Sprites/Player/PlayerTemp2.png")
	if Input.is_action_pressed("ui_up"):
		up = -1
		rayCast.cast_to = Vector2(0, -rayCastSize)
		spr.texture = load("res://Sprites/Player/PlayerTemp4.png")
	if Input.is_action_pressed("ui_down"):
		down = 1
		rayCast.cast_to = Vector2(0, rayCastSize)
		spr.texture = load("res://Sprites/Player/PlayerTemp1.png")
	
	# Avoid faster movement when in diagonal
	horizontal = left + right
	vertical = up + down
	var sum = sqrt(abs(horizontal)+abs(vertical))
	if sum == 0:
		sum = 1
	
	# Colisão com raycast
	if rayCast.is_colliding():
		object_hit = rayCast.get_collider()
		# Pegar chave
		if Input.is_action_just_pressed("ui_accept") && object_hit.get_name() == "Key":
			object_hit.queue_free()
			key += 1
		# Abrir porta
		if Input.is_action_just_pressed("ui_accept") && object_hit.get_name() == "PortaLvl1" && key > 0:
			get_tree().change_scene("res://Scenes/Salas/Level2.tscn")
		if Input.is_action_just_pressed("ui_accept") && object_hit.get_name() == "PortaLvl2":
			get_tree().change_scene("res://Scenes/main.tscn")
	
	# Set position
	move_and_collide(Vector2(speed * delta * horizontal/sum, speed * delta * vertical/sum))
