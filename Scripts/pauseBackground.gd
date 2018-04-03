extends Sprite

#https://godotengine.org/qa/4109/get-button-node-in-click-event
#onready var game_background_sprite = $gameBackground
onready var pause_background_sprite = $pauseBackground

onready var resume_button = $resume
onready var options_button = $options
onready var quit_button = $quit

onready var confirm_menu = $confirm

onready var yes_button = $confirm/yes
onready var no_button = $confirm/no

func _ready():
	resume_button.connect("pressed", self, "resume_game")
	options_button.connect("pressed", self, "show_options", [options_button])
	quit_button.connect("pressed", self, "show_confirm_menu")
	
	yes_button.connect("pressed", self, "quit_game")
	no_button.connect("pressed", self, "hide_confirm_menu")
	
	set_process(true)
	pass

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if confirm_menu.visible:
			hide_confirm_menu()
		elif !pause_background_sprite.visible:
			show_pause_background_sprite()
		elif pause_background_sprite.visible:
			hide_pause_background_sprite()
			hide_confirm_menu()
	if Input.is_action_just_pressed("ui_accept"):
		if confirm_menu.visible:
			quit_game()

func resume_game():
	hide_pause_background_sprite()

func show_options(target):
	print("Clicou no botão " + target.get_name())

func show_pause_background_sprite():
	pause_background_sprite.show()

func hide_pause_background_sprite():
	pause_background_sprite.hide()

func show_confirm_menu():
	confirm_menu.show()

func hide_confirm_menu():
	confirm_menu.hide()

func quit_game():
	get_tree().quit()