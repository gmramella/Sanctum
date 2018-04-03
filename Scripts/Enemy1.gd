extends Sprite

var speed = 150
var nav = null setget set_nav
var path = []
var goal = Vector2()
var points

func _ready():
	pass

func set_nav(new_nav):
	nav = new_nav
	update_path()
	
# procurar caminho
func update_path():
	path = nav.get_simple_path(get_position(), goal,false)

func _physics_process(delta):
	if path.size() > 1:
		var d = get_position().distance_to(path[0])
		if d > 2:
			set_position(get_position().linear_interpolate(path[0], (speed * delta)/d))
		else: 
			path.remove(0)