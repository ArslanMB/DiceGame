extends RigidBody3D

@export var force_lancer: float = 12.0
@export var force_rotation: float = 25.0

# Gestion de la position sur le banc
@export var position_repos: Vector3 = Vector3.ZERO
var is_idle: bool = true
var time_passed: float = 0.0

func _ready():
	gravity_scale = 3.0
	# On initialise la position de repos à la position actuelle au départ
	position_repos = global_position
	entrer_en_idle()
	
func _input(event):
	if event.is_action_pressed("ui_accept") or (event is InputEventMouseButton and event.pressed):
		sortir_de_idle()
		lancer_le_de()

func lancer_le_de():
	is_idle = false
	freeze = false 
	sleeping = false
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	# On ajoute un petit décalage pour que les dés ne partent pas tous pile au même endroit
	var direction = Vector3(randf_range(-0.5, 0.5), 2.0, randf_range(-0.5, 0.5)).normalized()
	apply_central_impulse(direction * force_lancer)
	
	var rot_aleatoire = Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
	apply_torque_impulse(rot_aleatoire * force_rotation)

func entrer_en_idle():
	is_idle = true
	freeze = true 
	# On remet le dé à SA position assignée sur le banc
	global_position = position_repos

func sortir_de_idle():
	is_idle = false
	freeze = false

func _process(delta):
	if is_idle:
		time_passed += delta
		# Lévitation autour de SA position de repos
		var offset_y = sin(time_passed * 2.0) * 0.2
		global_position.y = position_repos.y + offset_y
		global_position.x = position_repos.x + sin(time_passed) * 0.05
		
		rotation.y += delta * 0.5
	else:
		# Sécurité si chute
		if global_position.y < -5:
			entrer_en_idle()
	print(get_value())
			
func get_value():
	#the orientation [0,1]
	var orientation = self.global_basis
	
	#values
	var faces = {
	"4": orientation.y.y,
	"1": -orientation.y.y,
	"5": orientation.x.y,
	"3": -orientation.x.y,
	"2": orientation.z.y,
	"6": -orientation.z.y
}
	
	var max_val = -1.0
	var value = ""

	for face in faces:
		if faces[face] > max_val:
			max_val = faces[face]
			value = face
	
	return int(value)
