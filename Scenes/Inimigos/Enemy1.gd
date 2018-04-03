extends KinematicBody2D

onready var timer = $Timer
onready var rc = $RayCast2D
onready var spr = $Sprite
var object_hit
var dir = 1

func _ready():
	rc.cast_to = Vector2(0,100)
	pass

func _physics_process(delta):
	#Visão inimigo
	if rc.is_colliding():
		object_hit = rc.get_collider()
		if object_hit.get_name() == "Player":
			get_tree().change_scene("res://Scenes/main.tscn")

func _on_Timer_timeout():
	#Virar sprite e raycast
	#Esquerda
	if dir == 1:
		dir = 0
		spr.texture = load("res://Sprites/Inimigos/Enemy1Temp2.png")
		rc.cast_to = Vector2(-150,0)
	#Frente
	else:
		dir = 1
		rc.cast_to = Vector2(0,100)
		spr.texture = load("res://Sprites/Inimigos/Enemy1Temp1.png")