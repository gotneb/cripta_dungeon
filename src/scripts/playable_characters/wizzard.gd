class_name Wizzard
extends KinematicBody2D

# Constantes
const fire_ball_path := preload("res://scenes/projectiles/wizzard/fire.tscn")
const basic_spell_lighting_path := preload("res://scenes/projectiles/wizzard/weak_lighting_spell.tscn")
# Variaveis
var visible_enemies = []
var enemy_index = 0

# Variaveis
var speed := 40
var _velocity := Vector2.ZERO
var fire_ball_damage := 4
var basic_attack_damage := 2
var _flip_h := false

func _ready():
	$AnimatedSprite.play("idle")
	$AnimatedSprite.flip_h = _flip_h


func _process(delta):
	_move(delta)
	verify_can_attack()


func verify_can_attack() -> void:
	# Somente ataca se estiver algum inimigo no raio de alcance
	if visible_enemies.size() >= 1:
		if Input.is_action_just_pressed("z_attack"):
			throw_basic_spell()
		elif visible_enemies.size() >= 1 and Input.is_action_just_pressed("x_attack"):
			throw_fire_ball()

# Esssa funcao faz o personagem se mover
func _move(delta: float) -> void:
	# determina se move-se na direita ou equerda. Em seguida, determina se em cima ou em baixo
	_velocity = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	# Aplica a velocidade no jogador
	_velocity = move_and_slide(_velocity * speed * delta * 100)
	
	_play_animation()
	$AnimatedSprite.flip_h = _need_flip()
	
	select_enemy()


# Escolhe a animacao com base na velocidade
func _play_animation() -> void:
	var anim : String
	if _velocity.x == 0:
		anim = "idle"
	else:
		anim = "run"
	
	if $AnimatedSprite.animation != anim:
		$AnimatedSprite.play(anim)


# Verifica se "flipa" a direcao do mago
func _need_flip() -> bool:
	if _velocity.x < 0:
		_flip_h = true
		return true
	elif _velocity.x > 0:
		_flip_h = false
		return false
	else:
		return _flip_h


# Lanca uma bola de fogo
func throw_fire_ball() -> void:
	# Define a direcao de tiro
	if enemy_index >= visible_enemies.size():
		_change_enemy_index()
	$SpellsPosition.look_at(visible_enemies[enemy_index].position)
	# Cria a bola de fogo e adiciona no mapa
	var fire := fire_ball_path.instance()
	fire.position = $SpellsPosition/Position.global_position
	fire.direction =  visible_enemies[enemy_index].position - position
	fire.rotate($SpellsPosition.rotation)
	fire.damage = fire_ball_damage
	get_parent().add_child(fire)


# Lanca uma magia basica
func throw_basic_spell() -> void:
	# Define a direcao de tiro
	if enemy_index >= visible_enemies.size():
		_change_enemy_index()
	$SpellsPosition.look_at(visible_enemies[enemy_index].position)
	var instance = basic_spell_lighting_path.instance()
	var basic_spell = instance.create_magic(
		$SpellsPosition/Position.global_position,
		visible_enemies[enemy_index].position - position,
		$SpellsPosition.rotation,
		basic_attack_damage
	)
	get_parent().add_child(basic_spell)


# Funcao auxiliar para trocar o index do inimigo para intervalos validos
func _change_enemy_index() -> void:
	enemy_index += 1
	if enemy_index >= visible_enemies.size():
		enemy_index = 0


# Seleciona um inimigo "visivel" para o player exibindo um alvo abaixo do inimigo
func select_enemy() -> void:
	if visible_enemies.size() == 1:
		visible_enemies[0].set_aim_visible_to(true)
	elif visible_enemies.size() >= 1:
		if Input.is_action_just_pressed("change_enemy"):
			_change_enemy_index()
			visible_enemies[enemy_index - 1].set_aim_visible_to(false)
			visible_enemies[enemy_index].set_aim_visible_to(true)


func _on_Vision_body_entered(body):
	if body is OrcShaman:
		visible_enemies.append(body)
		select_enemy()


func _on_Vision_body_exited(body):
	if body is OrcShaman:
		visible_enemies.pop_at(visible_enemies.find(body))
		body.set_aim_visible_to(false)
