extends Sprite2D

var boostGainScale: float = 1.0


func _process(delta):
	if !Global.startCrasher && !Global.crashStarted && !Global.softCam && Global.crashTime < 6.3:
		Global.crashTime += delta * Global.gameTimeScale * boostGainScale
		Global.canDeployCrasher = false
		material.set_shader_parameter("gaining_boost",true)
		
	
	if Global.crashTime >= 6.3:
		Global.crashTime = 6.3
		Global.canDeployCrasher = true
		material.set_shader_parameter("gaining_boost",false)
	
	material.set_shader_parameter("boost_value",Global.crashTime)
