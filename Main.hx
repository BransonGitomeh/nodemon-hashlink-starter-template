import src.Logger;
import easylog.EasyLogger;
import haxe.*;
import tweenx909.TweenX;
import echo.Echo;

class Main extends hxd.App {
	var bmp:h2d.Bitmap;

	override function init() {
		// allocate a Texture with red color and creates a 100x100 Tile from it
		var tile = h2d.Tile.fromColor(0x0DA856, 100, 100);
		// create a Bitmap object, which will display the tile
		// and will be added to our 2D scene (s2d)
		bmp = new h2d.Bitmap(tile, s2d);
		// modify the display position of the Bitmap sprite
		bmp.x = s2d.width * 0.8;
		bmp.y = s2d.height * 0.5;

		Timer.delay(function delayCB() {
			TweenX.to(bmp, {x: 360});
		}, 2000);

		var myLogger:EasyLogger = new EasyLogger("./app_[logType].log");

		myLogger.consoleOutput = true;
		myLogger.log(EasyLogger.Error, "Uh oh!");
		myLogger.log("CustomLogType", "Custom log types are allowed, too!");
	}

	// on each frame
	override function update(dt:Float) {
		// increment the display bitmap rotation by 0.1 radians
		// bmp.rotation += 0.3;
	}

	static function main() {
    new Main();
    
     // Create a World to hold all the Physics Bodies
    // Worlds, Bodies, and Listeners are all created with optional configuration objects.
    // This makes it easy to construct object configurations, reuse them, and even easily load them from JSON!
    var world = Echo.start({
      width: 64, // Affects the bounds for collision checks.
      height: 64, // Affects the bounds for collision checks.
      gravity_y: 20, // Force of Gravity on the Y axis. Also available for the X axis.
      iterations: 2 // Sets the number of Physics iterations that will occur each time the World steps.
    });

    // Create a Body with a Circle Collider and add it to the World
    var a = world.make({
      elasticity: 0.2,
      shape: {
        type: CIRCLE,
        radius: 16,
      }
    });

    // Create a Body with a Rectangle collider and add it to the World
    // This Body will have a Mass of zero, rendering it as unmovable
    // This is useful for things like platforms or walls.
    var b = world.make({
      mass: 0, // Setting this to zero makes the body unmovable by forces and collisions
      y: 48, // Set the object's Y position below the Circle, so that gravity makes them collide
      elasticity: 0.2,
      shape: {
        type: RECT,
        width: 10,
        height: 10
      }
    });

    // Create a listener and attach it to the World.
    // This listener will react to collisions between Body "a" and Body "b", based on the configuration options passed in
    world.listen(a, b, {
      separate: true, // Setting this to true will cause the Bodies to separate on Collision. This defaults to true
      enter: (a, b, c) -> trace("Collision Entered"), // This callback is called on the first frame that a collision starts
      stay: (a, b, c) -> trace("Collision Stayed"), // This callback is called on frames when the two Bodies are continuing to collide
      exit: (a, b) -> trace("Collision Exited"), // This callback is called when a collision between the two Bodies ends
    });

    // Set up a Timer to act as an update loop (at 60fps)
    new haxe.Timer(16).run = () -> {
      // Step the World's Physics Simulation forward (at 60fps)
      world.step(16 / 1000);
      // Log the World State in the Console
      echo.util.Debug.log(world);
    }
	}
}
