module game.systems.position_system;

import game_engine.core;
import game_engine.ecs;

import game.components.position_component;
import game.systems.utils;

class PositionSystem : System
{
    override void update(GameContainer container, float delta)
    {
        foreach (entityID; container.entityManager.getEntities(PositionComponent.ID))
        {
            auto component = container.getSingletonComponent!(PositionComponent)(entityID);

            if (component.moving)
            {
                component.xPos += component.xSpeed * delta;
                component.yPos += component.ySpeed * delta;

                if (component.yPos <= 0)
                {
                    component.yPos = 0;
                    component.ySpeed *= -1;
                }
                if (component.xPos <= 0)
                {
                    component.xPos = 0;
                    component.xSpeed *= -1;
                }
                else if (component.xPos + component.width >= 800)
                {
                    component.xPos = 800 - component.width;
                    component.xSpeed *= -1;
                }
            }
        }
    }
}
