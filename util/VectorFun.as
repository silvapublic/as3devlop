package util {
	import flash.display.Shape;
	/**
	 * 矢量功能类
	 * @author silva
	 */
	public class VectorFun {
		
		public function VectorFun() {
			
		}
		/**
		 * 绘制一个方块空心的方块结构矢量对象
		 * @param	_x 空心的x坐标
		 * @param	_y 空心的y坐标
		 * @param	_w 空心的宽
		 * @param	_h 空心的高
		 * @return
		 */
		public static function drawSquareVector(_x:Number, _y:Number, _w:Number, _h:Number):Shape {
			var sp:Shape = new Shape();
			var star_commands:Vector.<int >  = new Vector.<int > (8, true);
			star_commands[0] = 2;
			star_commands[1] = 2;
			star_commands[2] = 2;
			star_commands[3] = 2;
			star_commands[4] = 1;
			star_commands[5] = 2;
			star_commands[6] = 2;
			star_commands[7] = 2;
			var star_coord:Vector.<Number >  = new Vector.<Number > (16, true);
			star_coord[0] = 0;//x
			star_coord[1] = 0;//y 
			//
			star_coord[2] = 1000;
			star_coord[3] = 0;
			//
			star_coord[4] = 1000;
			star_coord[5] = 600;
			//
			star_coord[6] = 0;
			star_coord[7] = 1000;
			//
			star_coord[8] = _x;
			star_coord[9] = _y;
			//
			star_coord[10] = _x + _w;
			star_coord[11] = _y;
			//
			star_coord[12] = _x + _w;
			star_coord[13] = _y + _h;
			//
			star_coord[14] = _x;
			star_coord[15] = _y + _h;
			sp.graphics.beginFill(0x000000, 0);
			sp.graphics.drawPath(star_commands, star_coord);
			sp.graphics.endFill();
			return sp;
		}
	}
}