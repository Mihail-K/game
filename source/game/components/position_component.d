module game.components.position_component;

import game_engine.ecs.component;
import game_engine.utils.vector;


class PositionComponent : Component
{
    enum ID = typeof(this).stringof;

    Vec4 shape;
    Vec2 velocity;

    this(Vec4 shape = Vec4(0, 0, 10.0, 10.0), Vec2 velocity = Vec2(0, 0))
    {
        this.shape    = shape;
        this.velocity = velocity;
    }

    override string componentID() const
    {
        return ID;
    }

    Vec2 position()
    {
        return shape.xy;
    }

    Vec2 size()
    {
        return shape.zw;
    }

    ref float xPos()
    {
        return shape.x;
    }

    ref float yPos()
    {
        return shape.y;
    }

    ref float width()
    {
        return shape.z;
    }

    ref float height()
    {
        return shape.w;
    }

    ref float xSpeed()
    {
        return velocity.x;
    }

    ref float ySpeed()
    {
        return velocity.y;
    }

    @property
    bool moving() const
    {
        return !stationary;
    }

    @property
    bool stationary() const
    {
        return velocity.x == 0 && velocity.y == 0;
    }
}
