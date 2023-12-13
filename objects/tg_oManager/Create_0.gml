// Camera
mainCamera = view_get_camera(0);

// Shader
uniPlayerPos = shader_get_uniform(tg_shGrass, "playerPos");
uniPlayerRadius = shader_get_uniform(tg_shGrass, "playerRadius");
uniCollisionBend = shader_get_uniform(tg_shGrass, "bend");
uniYOffset = shader_get_uniform(tg_shGrass, "yOffset");