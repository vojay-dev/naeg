extends Node2D

var coins = 0
var coin_goal = 0

var start_time_msec = 0

func start_timer():
	start_time_msec = OS.get_ticks_msec()
	
func stop_timer():
	var stop_time_msec = OS.get_ticks_msec()
	var time_passed_sec = round((stop_time_msec - start_time_msec) / 1000)

func update_timer():
	var stop_time_msec = OS.get_ticks_msec()
	var time_passed_sec = round((stop_time_msec - start_time_msec) / 1000)
	$UI/TimerLabel.text = str(time_passed_sec)

func _on_Area2D_body_entered(body):
	get_tree().reload_current_scene()

func _process(delta):
	update_timer()

func _ready():
	$UI/CoinLabel.text = str(coins)
	$UI/CoinLabel.text = str(start_time_msec)
	start_timer()

	var coins_nodes = get_tree().get_nodes_in_group("coins")

	coin_goal = coins_nodes.size()
	for coin in coins_nodes:
		coin.connect("coin_collected", self, "_on_Coin_collected")

func _on_Coin_collected(coin):
	coins += 1
	$UI/CoinLabel.text = str(coins)
	
	if coins == coin_goal:
		stop_timer()
		get_tree().reload_current_scene()
