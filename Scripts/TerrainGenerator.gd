extends Node

func get_brightness_in_range(noise_value, range_lower_bound, range_upper_bound):
	var range_length = range_upper_bound - range_lower_bound
	var shifted_noise_value = noise_value - range_lower_bound
	var raw_brightness = shifted_noise_value / range_length
	var adjusted_brightness = raw_brightness / 2.0 + 0.5
	var stepified_brightness = stepify(adjusted_brightness, 0.1)
	
	return stepified_brightness

func get_color_from_noise_value(noise_value):
	# Noise Value Range: [-1, 1]
	#   Water : <=0.2
	#   Sand  : <=0.275
	#   Grass : <=0.8
	#   Rock  : <=0.95
	#   Snow  : <=1.0
	
	noise_value += 1.0
	noise_value /= 2.0
	
	if noise_value >= 0.675:
		var brightness = get_brightness_in_range(noise_value, 0.675, 1.0)
		return Color(brightness, brightness, brightness)
	elif noise_value >= 0.6:
		var brightness = get_brightness_in_range(noise_value, 0.6, 0.675)
		return Color(0, brightness, 0)
	elif noise_value >= 0.55:
		var brightness = get_brightness_in_range(noise_value, 0.55, 0.6)
		return Color(brightness, brightness, 0)
	else:
		var brightness = get_brightness_in_range(noise_value, 0.0, 0.55)
		return Color(0, 0, brightness)

func get_texture(texture_width, texture_height, chosen_seed, octaves, period, persistence):
	# Create OpenSimplexNoise
	var open_simplex_noise = OpenSimplexNoise.new()
	open_simplex_noise.seed = chosen_seed
	open_simplex_noise.octaves = octaves
	open_simplex_noise.period = period
	open_simplex_noise.persistence = persistence
	
	# Create Image
	var image = Image.new()
	image.create(texture_width, texture_height, false, Image.FORMAT_RGBA8)
	image.lock()
	for x in range(texture_width):
		for y in range(texture_height):
			image.set_pixel(x, y, get_color_from_noise_value(open_simplex_noise.get_noise_2d(x, y)))
	
	# Create + return ImageTexture
	var image_texture = ImageTexture.new()
	image_texture.create_from_image(image, 0)
	return image_texture
