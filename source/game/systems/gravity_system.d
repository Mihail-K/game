module game.systems.gravity_system;

import game_engine.core;
import game_engine.ecs;

import game.components.gravity_component;
import game.components.position_component;
import game.systems.utils;

class GravitySystem : System
{
    override void update(GameContainer container, float delta)
    {
        foreach (entityID; container.entityManager.getEntities(GravityComponent.ID))
        {
            auto gravityComponent = container.getSingletonComponent!(GravityComponent)(entityID);

            if (!gravityComponent.zero)
            {
                auto positionComponent = container.getSingletonComponent!(PositionComponent)(entityID);

                positionComponent.xSpeed += gravityComponent.xMagnitude * delta;
                positionComponent.ySpeed += gravityComponent.yMagnitude * delta;
            }
        }
    }
}
