import std.stdio;

import game_engine;

import game.components.gravity_component;
import game.components.position_component;
import game.components.sprite_component;

import game.systems.gravity_system;
import game.systems.position_system;
import game.systems.utils;

immutable FontConfig frameRateFontConfig = {
	path: "../game_engine/assets/consola.ttf",
	height: 20
};

class TestGameState : GameState
{
	private Font font;
	private Font frameRateFont;
	private float frameRate;

	private TextConfig frameRateTextConfig()
	{
		TextConfig frameRateTextConfig = {
			font:     frameRateFont,
			position: Vec2(10, 550),
			color:    Vec3(1, 0, 0)
		};

		return frameRateTextConfig;
	}

	override GameStateID gameStateID() const
	{
		return defaultGameStateID;
	}

	override void setup(GameContainer container)
	{
		import bindbc.opengl;
        TextureConfig textureConfig = { internalFormat: GL_RGBA };
        container.resourceManager.createTexture("test", "assets/face.png", textureConfig);

		container.systemManager.addSystem(new GravitySystem());
		container.systemManager.addSystem(new PositionSystem());

		auto spriteComponent   = new SpriteComponent("test");
		auto gravityComponent  = new GravityComponent(Vec2(0, -9.81 * 25));
		auto positionComponent = new PositionComponent(Vec4(400, 300, 100, 100), Vec2(55, 0));

		container.entityManager.createEntity(spriteComponent, positionComponent, gravityComponent);

		FontConfig fontConfig = {
			path: "../game_engine/assets/consola.ttf",
			width: 10,
			height: 10
		};

		font = new Font(fontConfig);
		frameRateFont = new Font(frameRateFontConfig);

		foreach (ch; 0..128)
		{
			font.loadChar(cast(char) ch);
		}

		foreach (ch; 0..128)
		{
			frameRateFont.loadChar(cast(char) ch);
		}
	}

	override void update(GameContainer container, float delta)
	{
		frameRate = 1000 / delta;

		container.systemManager.update(container, delta);
	}

	override void render(GameContainer container)
	{
		import std.conv;
		import std.range;

		foreach (x; iota(0, 800).stride(10))
		{
			foreach (y; iota(0, 600).stride(10))
			{
				TextConfig textConfig = {
					font:     font,
					position: Vec2(x, y)
				};

				container.renderer.drawText(".", textConfig);
			}
		}

		foreach (entityID; container.entityManager.getEntities(SpriteComponent.ID))
		{
			auto spriteComponent   = container.getSingletonComponent!(SpriteComponent)(entityID);
			auto positionComponent = container.getSingletonComponent!(PositionComponent)(entityID);

			SpriteConfig config = {
				texture:  container.resourceManager.fetchTexture("test"),
				position: positionComponent.position,
				size:     positionComponent.size,
				rotate:   spriteComponent.rotation,
				color:    spriteComponent.colorMask
			};

			container.renderer.drawSprite(config);
		}

		container.renderer.drawText("FPS: " ~ frameRate.to!(string), frameRateTextConfig);
	}
}

void main()
{
	auto game = new Game();

	game.initWindow(windowConfig);
	game.initGraphicsLibrary();
	game.initGameEngine();

	game.addGameState(new TestGameState());
	game.setGameState(defaultGameStateID);

	game.start();
}

private WindowConfig windowConfig()
{
	WindowConfig config = {
		title:  "Test Game",
		width:  800,
		height: 600
	};

	return config;
}
