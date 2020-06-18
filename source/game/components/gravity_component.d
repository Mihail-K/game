module game.components.gravity_component;

import game_engine.ecs.component;
import game_engine.utils.vector;


class GravityComponent : Component
{
    enum ID = typeof(this).stringof;

    Vec2 magnitude;

    this()
    {
    }

    this(Vec2 magnitude)
    {
        this.magnitude = magnitude;
    }

    override string componentID() const
    {
        return ID;
    }

    ref float xMagnitude()
    {
        return magnitude.x;
    }

    ref float yMagnitude()
    {
        return magnitude.y;
    }

    @property
    bool zero() const
    {
        return magnitude.x == 0 && magnitude.y == 0;
    }
}
