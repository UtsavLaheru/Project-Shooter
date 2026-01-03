extends Node2D
class_name RandomPowerUpComponent
var Speed_Increase: int = 20
var FireRate_Decreases: int = 0.05
var Randomize = 1

func MovementIncrease(powerup: PowerUp):
	powerup.Increase_Speed = Speed_Increase

func FireSpeedIncrease(powerup : PowerUp):
	powerup.Decrease_FireRate = FireRate_Decreases

	if Randomize == 1:
		pass              #Currently Working On.
