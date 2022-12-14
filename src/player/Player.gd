extends RigidBody2D
class_name Player

var dir: Vector2
var vel: float

var is_landed: bool = false
var noFuel: bool = false

onready var engine_particles: CPUParticles2D = $EngineParticles
onready var engine_sfx: AudioStreamPlayer2D = $EngineSFX
onready var engine_exhaust_ray: RayCast2D = $ExhaustRay
onready var engine_exhaust_particles: Node2D = $ExhaustParticles

onready var control_engine_particles_1: CPUParticles2D = $ControlEngineParticles_1
onready var control_engine_particles_2: CPUParticles2D = $ControlEngineParticles_2
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
	self._spawn_exhaust_particles(is_engine_on)	
	
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


func _spawn_exhaust_particles(is_engine_on):
	if is_engine_on and engine_exhaust_ray.is_colliding():
		var collision_point = engine_exhaust_ray.get_collision_point()
		engine_exhaust_particles.global_position = collision_point
		
		var collision_normal = engine_exhaust_ray.get_collision_normal()
		engine_exhaust_particles.look_at(engine_exhaust_particles.global_position + collision_normal)
		
		engine_exhaust_particles.start_emitting()
		
	else:
		engine_exhaust_particles.stop_emitting()
	


func check_if_left_game_area():
	if global_position.x < -8 or global_position.x > 1288:
		GameManager.total_failure()
	
	if global_position.y < -8 or global_position.y > 648:
		GameManager.total_failure()


func are_both_legs_on_pad():
	return $LegRaycast.is_colliding() and $LegRaycast2.is_colliding()


func _on_Player_body_entered(body):
	if body is StartingPad and vel < 25:
		return

	elif body is LandingPad and are_both_legs_on_pad():
		if not is_landed:
			is_landed = true
			
			
			GameManager.landing(vel, body.stars)
	
	else:
		GameManager.total_failure()

func _onFuelEmpty():
	noFuel = true



