class_name PlayerStateRun extends PlayerState



# what happens when this state is initialized?
func init() -> void:
	pass


# What happens when we enter this state?
func enter() -> void:
	#Play the animation gronk!
	pass


# What happens when we enter this state?
func exit() -> void:
	pass


# what happens when an input is pressed?
func handle_input( _event : InputEvent ) -> PlayerState:
	#handle ya input
	return next_state
  

#what happens each process tick in this state?
func process( _delta: float ) -> PlayerState:
	if player.direction.x == 0:
		return idle
	return next_state


#what happens each physics_process tick in this state?
func physics_process( _delta: float ) -> PlayerState:
	player.velocity.x = player.direction.x * player.move_speed
	return next_state
