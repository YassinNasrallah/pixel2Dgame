extends CharacterBody2D
var player = null
var speed = 30.0
var player_chase = false
var health = 100
var enemy_alive = true
var enemy_attack_cooldown = true
var player_inattack_zone = false
var attack_ip = false
var damage_timer_cooldown = true
func _physics_process(delta):


	if !enemy_alive:
		return
	
	attack()
	deal_with_damage()
	
	if attack_ip:
		return
	
	

	if player_chase:
		position += (player.position - position) / speed

		if $AnimatedSprite2D.animation != "walk":
			$AnimatedSprite2D.play("walk")

		if player.position.x < position.x:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false

	else:
		if $AnimatedSprite2D.animation != "idle":
			$AnimatedSprite2D.play("idle")


func _on_deatactionarea_body_entered(body: Node2D) -> void:
	player = body
	player_chase = true


func _on_deatactionarea_body_exited(body: Node2D) -> void:
	player = null
	player_chase = false

func enemy():
	pass


func _on_enemyhit_box_body_entered(body: Node2D) -> void:
	if body.has_method('player'):
		player_inattack_zone = true
	


func _on_enemyhit_box_body_exited(body: Node2D) -> void:
	if body.has_method('player'):
		player_inattack_zone = false

func deal_with_damage():
	if player_inattack_zone and Global.player_current_attack == true and damage_timer_cooldown:
		health = health - 20
		$AnimatedSprite2D.play("take_damage")
		print('enemy take damage')
		damage_timer_cooldown = false
		$damage_timer.start()
	if health <= 0:
		health = 0
		enemy_alive = false
		$AnimatedSprite2D.play("death")
		self.queue_free()
		
func _on_damage_timer_timeout() -> void:
	damage_timer_cooldown = true
	  
func attack():
	if player_inattack_zone and !attack_ip:
		#Global.player_is_damaged = true
		attack_ip = true
		Global.player_health -= 10
		$deal_attack_timer.start()
		$AnimatedSprite2D.play('attack')
		print('player get damage ')

func _on_deal_attack_timer_timeout() -> void:
	attack_ip = false
	$deal_attack_timer.stop()
