module game.systems.utils;

import game_engine.core;
import game_engine.ecs;

T getSingletonComponent(T : Component)(GameContainer container, EntityID entityID)
{
    auto components = container.entityManager.getComponents(entityID, T.ID);
    assert(components.length == 1, "Entity has unsupported number of Components!");

    auto component = cast(T) components[0];
    assert(component, "Component has incorrect Component ID!");

    return component;
}
