extends RigidBody2D
class_name Player

var dir: Vector2
var vel: float

var is_landed: bool = false
var noFuel: bool = false

onready var engine_particles: Particles2D = $EngineParticles
onready var control_engine_particles_1: Particles2D = $ControlEngineParticles_1
onready var control_engine_particles_2: Particles2D = $ControlEngineParticles_2

signal emitFuel

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player = self
	$AnimatedSprite.play("Idle")


func _process(delta):
	dir = Vector2.ZERO
	vel = linear_velocity.length()
	$Label.text = "Velocity = " + str(int(vel))
	
	var input = self._get_input()
	var is_engine_on: bool = input.y > 0 and not noFuel
	
	dir = Vector2.UP.rotated(rotation) * 60 if is_engine_on else Vector2.ZERO
	engine_particles.emitting = is_engine_on

	self._rotate(input.x)
	
	apply_central_impulse(dir)
	
	if is_engine_on:
		emit_signal("emitFuel")

func _get_input():
	if is_landed:
		return Vector2.ZERO
		
	return Input.get_vector("ui_left", "ui_right", "ui_down", "ui_up")

func _rotate(rotation):
	apply_torque_impulse(rotation * deg2rad(90) * 100)
	
	control_engine_particles_1.emitting = bool(rotation)
	control_engine_particles_2.emitting = bool(rotation)
	
	control_engine_particles_1.rotation_degrees = 0 if rotation <= 0 else 180
	control_engine_particles_2.rotation_degrees = 0 if rotation <= 0 else 180
	
		
	

func _on_Player_body_entered(body):
	if body is StartingPad:
		return
			
	if not is_landed:
		is_landed = true
		print(vel)
		
		if body is LandingPad:
			GameManager.landing(vel)
		
		else:
			GameManager.total_failure()

func _onFuelEmpty():
	noFuel = true
