extends Node
class_name AudioManager
@export var sfxPlayerCount = 10
@export var musicStream:AudioStream
@export var fireBulletStream:AudioStream
@export var bulletHitStream:AudioStream
@export var playerHitStream:AudioStream
@export var playerDeathStream:AudioStream

@export var maxSfxSpeedFactor = 1.01
@export var minSfxSpeedFactor = 0.99
var musicPlayer:AudioStreamPlayer
var availableSfxPlayers:Array[AudioStreamPlayer2D] = []
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	musicPlayer = AudioStreamPlayer.new()
	musicPlayer.stream = musicStream
	musicPlayer.bus = "music"
	add_child(musicPlayer)
	musicPlayer.play()
	for i in range(0,sfxPlayerCount):
		var player = AudioStreamPlayer2D.new()
		add_child(player)
		player.finished.connect(streamFinished.bind(player))
		player.bus="sfx"
		availableSfxPlayers.push_back(player)	

func playMusic():
	musicPlayer.play()

func pauseMusic():
	musicPlayer.playing = false

func playFireBulletStream(position:Vector2):
	playStream(fireBulletStream,position,1)

func playBulletHitStream(position:Vector2):
	playStream(bulletHitStream,position,1)

func playPlayerHitStream(position:Vector2):
	playStream(playerHitStream,position,1)

func playPlayerDeathStream(position:Vector2):
	playStream(playerDeathStream,position,1)

func playStream(stream:AudioStream, position:Vector2, volume:float):
	var player = availableSfxPlayers.pop_front() as AudioStreamPlayer2D
	
	if(player != null):
		var pscale = rng.randf_range(minSfxSpeedFactor,maxSfxSpeedFactor)
		player.pitch_scale = pscale
		player.global_position = position
		player.stream = stream
		player.volume_db = volume
		player.play()
	else:
		print_debug("skipped sfx due to lack of players")

func streamFinished(sfxPlayer:AudioStreamPlayer2D):
	availableSfxPlayers.push_back(sfxPlayer)