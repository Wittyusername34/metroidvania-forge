class_name Player extends CharacterBody2D

const DEBUG_JUMP_INDICATOR = preload("uid://1n5lkptfbcul")


#region /// Export Variables
@export var move_speed : float = 100
#endregion

#region /// State Machine Variables
var states : Array[ PlayerState ]
var current_state : PlayerState : 
	get : return states.front()
var previous_state : PlayerState :
	get : return states[ 1 ]
#endregion

#region /// Standard Variables
var direction : Vector2 = Vector2.ZERO
var gravity : float = 980
var gravity_multiplier : float = 1.0
#endregion



func  _ready() -> void:
	initialize_states()
	pass



func _unhandled_input( event: InputEvent ) -> void:
	change_state( current_state.handle_input( event ) )
	pass



func _process( _delta: float ) -> void:
	update_direction()
	change_state( current_state.process( _delta ) )
	pass



func _physics_process( _delta: float ) -> void:
	move_and_slide()
	velocity.y += gravity * _delta * gravity_multiplier
	change_state( current_state.physics_process( _delta ) )
	pass



func initialize_states() -> void:
	states = []
	for c in $States.get_children():
		if c is PlayerState:
			states.append( c )
			c.player = self
		pass
	
	if states.size() == 0:
		return
	
	for state in states:
		state.init()
	
	change_state( current_state )
	current_state.enter()
	$Label.text = current_state.name
	pass



func change_state( new_state : PlayerState ) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	states.push_front( new_state )
	current_state.enter()
	
	states.resize( 3 )
	$Label.text = current_state.name
	pass



func update_direction() -> void:
	#var prev_direction : Vector2 = direction
	var x_axis = Input.get_axis( "left", "right" )
	var y_axis = Input.get_axis( "up", "down" )
	direction = Vector2( x_axis, y_axis )
	#do more stuff?
	pass



func add_debug_indicator( color : Color = Color.RED ) -> void:
	var d : Node2D = DEBUG_JUMP_INDICATOR.instantiate()
	get_tree().root.add_child( d )
	d.global_position = global_position
	d. modulate = color
	await get_tree().create_timer( 3.0 ).timeout
	d.queue_free()
	pass
