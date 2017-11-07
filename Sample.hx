import flash.Lib;
import flash.display.BitmapData;
import flash.display.Sprite;
import flash.events.Event;

#if !flash
import flash.display.FPS;
#end

class Sample extends Sprite 
{
	private var singleFill:Bool = false;
	private var sprite:Sprite;

	public function new()
	{
		super();

		#if !flash
		Lib.current.stage.addChild(new FPS(8, Lib.current.stage.stageHeight - 24, 0xffffff));
		#end

		onLoaded(openfl.Assets.getBitmapData("nme.jpg"));
	}

	function onLoaded(bd:BitmapData)
	{
		sprite = new Sprite();
		addChild(sprite);

		if (singleFill)
			sprite.graphics.beginBitmapFill(bd, null, true, true);

		for (i in 0...10000)
		{
			draw(sprite, bd);
		}

		if (singleFill)
			sprite.graphics.endFill();

		sprite.x = Lib.current.stage.stageWidth / 2;
		sprite.y = Lib.current.stage.stageHeight / 2;

		stage.addEventListener( Event.ENTER_FRAME, function(_) { doUpdate(); } );
	}

	function doUpdate()
	{
		sprite.rotation += 1;
	}

	function draw(sprite:Sprite, bd:BitmapData)
	{
		var originX:Float = (Math.random() * Lib.current.stage.stageWidth * 2) - Lib.current.stage.stageWidth;
		var originY:Float = (Math.random() * Lib.current.stage.stageHeight * 2) - Lib.current.stage.stageHeight;

		if (!singleFill)
			sprite.graphics.beginBitmapFill(bd, null, true, false);

		sprite.graphics.moveTo(originX - 10, originY - 10);
		sprite.graphics.lineTo(originX + 10, originY - 10);
		sprite.graphics.lineTo(originX + 10, originY + 10);
		sprite.graphics.lineTo(originX - 10, originY + 10);

		if (!singleFill)
			sprite.graphics.endFill();
	}
}

