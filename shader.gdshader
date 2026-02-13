shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
// 1.0 = image normale. 2.0 = pixels doublés. 1.5 = léger flou pixelisé.
uniform float pixel_size : hint_range(1.0, 10.0) = 2.0; 

void fragment() {
    // On récupère la résolution réelle de la fenêtre
	vec2 size = vec2(textureSize(screen_texture, 0));
	
	// On calcule la taille d'un "bloc" de pixels
	vec2 pixel_grid = pixel_size / size;
	
	// On arrondit les UV pour qu'elles collent à cette grille
	vec2 uv = floor(SCREEN_UV / pixel_grid) * pixel_grid;
	
	COLOR = texture(screen_texture, uv);
}