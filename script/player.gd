extends CharacterBody2D
@onready var animation = $Sprite2D
const SPEED = 300.0
var enemy_inattack_range = false
var enemy_attack_cooldown = true
var player_alive = true
var attack_ip = false
var current_direction = 'none'


func _physics_process(delta: float) -> void:
	if Global.d_active:
		return
	
	if Global.player_health <= 0: #show replay screen
		player_alive = false
		Global.player_health = 0
		self.queue_free()
		print('you died')

	#acharacter movement
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.y >0:
		current_direction = 'down'
		animation.play("down")
	elif direction.y <0:
		current_direction = 'up'
		animation.play("up")
	elif direction.x > 0:
		current_direction = "right"
		animation.play("right")
		animation.flip_h = false
	elif direction.x < 0:
		current_direction = 'left'
		animation.play('right')
		animation.flip_h = true


	elif  direction ==  Vector2.ZERO and attack_ip == false:
		if current_direction == 'right':
			animation.play("idle_right")
			animation.flip_h = false
		elif current_direction == 'left':
			animation.flip_h = true
			animation.play("idle_right")
		elif current_direction == 'up':
			animation.play("idle_up")
		elif current_direction == 'down':
			animation.play('idle')
		
		  
	velocity = direction.normalized() * SPEED
	
	attack()
	#player_gethit()
	move_and_slide()
func player():
	pass

func _on_playerhit_box_body_entered(body: Node2D) -> void:
	if body.has_method('enemy'):
		enemy_inattack_range = true


func _on_playerhit_box_body_exited(body: Node2D) -> void:
	if body.has_method('enemy'):
		enemy_inattack_range = false
		

func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true
	
func attack():
	var dir = current_direction
	if Input.is_action_just_pressed("attack"):
		Global.player_current_attack = true
		attack_ip = true
		if dir == 'right':
			animation.flip_h = false
			animation.play("side_attack")
			$deal_attack_timer.start()
		if dir == 'left':
			animation.flip_h = true
			animation.play("side_attack")
			$deal_attack_timer.start()
		if dir =='down':
			animation.play("front_attack")
			$deal_attack_timer.start()
		if dir =='up':
			animation.play("back_attack")
			$deal_attack_timer.start()
		   

func _on_deal_attack_timer_timeout() -> void:
	Global.player_current_attack = false
	attack_ip = false
	$deal_attack_timer.stop()
	
#func player_gethit():
#	if Global.player_is_damaged:
#		Global.player_is_damaged = false
#		animation.play('get_hit')
	
	
	
