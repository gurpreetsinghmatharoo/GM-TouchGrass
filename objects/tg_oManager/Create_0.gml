gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);

// Camera
mainCamera = view_get_camera(0);

// Shader
uniPlayerPos = shader_get_uniform(tg_shGrass, "playerPos");
uniPlayerRadius = shader_get_uniform(tg_shGrass, "playerRadius");
uniCollisionBend = shader_get_uniform(tg_shGrass, "bend");
uniYOffset = shader_get_uniform(tg_shGrass, "yOffset");

uniWind1Power = shader_get_uniform(tg_shGrass, "wind1Power");
uniWind1Speed = shader_get_uniform(tg_shGrass, "wind1Speed");
uniWind1Scale = shader_get_uniform(tg_shGrass, "wind1Scale");
uniTime = shader_get_uniform(tg_shGrass, "time");