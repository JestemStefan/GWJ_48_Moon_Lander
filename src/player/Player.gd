extends RigidBody2D
class_name Player

var dir: Vector2
var vel: float

var is_landed: bool = false
var noFuel: bool = false

onready var engine_particles: Particles2D = $EngineParticles
onready var engine_sfx: AudioStreamPlayer2D = $EngineSFX


onready var control_engine_particles_1: Particles2D = $ControlEngineParticles_1
onready var control_engine_particles_2: Particles2D = $ControlEngineParticles_2
onready var control_engine_sfx: AudioStreamPlayer2D = $ControlEginesSFX

signal emitFuel

# Called when the node enters the scene tree for the first time.
func _ready():
	GameManager.player = self
	$AnimatedSprite.play("Idle")


func _process(delta):
	self.check_if_left_game_area()
	
	dir = Vector2.ZERO
	vel = linear_velocity.length()
	$Label.text = "Vel = " + str(stepify(vel, 0.1))
	
	var input = self._get_input()
	var is_engine_on: bool = input.y > 0 and not noFuel
	
	dir = Vector2.UP.rotated(rotation) * 60 if is_engine_on else Vector2.ZERO
	engine_particles.emitting = is_engine_on
	self._play_engine_sfx(is_engine_on)
	

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
	var is_rotating = bool(rotation)
	
	control_engine_particles_1.emitting = is_rotating
	control_engine_particles_2.emitting = is_rotating
	
	control_engine_particles_1.rotation_degrees = 0 if rotation <= 0 else 180
	control_engine_particles_2.rotation_degrees = 0 if rotation <= 0 else 180
	
	if is_rotating:
		if not control_engine_sfx.is_playing():
			control_engine_sfx.play(0.0)
	else:
		control_engine_sfx.stop()
	
func _play_engine_sfx(is_engine_on):
	if is_engine_on:
		if not engine_sfx.is_playing():
			engine_sfx.play(0.0)
	else:
		engine_sfx.stop()


func check_if_left_game_area():
	if global_position.x < -8 or global_position.x > 1288:
		GameManager.total_failure()
	
	if global_position.y < -8 or global_position.y > 648:
		GameManager.total_failure()


func _on_Player_body_entered(body):
	if body is StartingPad and vel < 25:
		return

	elif body is LandingPad:
		if not is_landed:
			is_landed = true
			GameManager.landing(vel)
	
	else:
		GameManager.total_failure()

func _onFuelEmpty():
	noFuel = true


