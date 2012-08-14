package util {
	import flash.filters.BitmapFilterQuality;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	/**
	 * 滤镜效果类 此类为单例类
	 * @author zl
	 */
	public class FilterEffect {
		/**
		 * @private
		 */
		public function FilterEffect() {
			
		}
		/**
		 * 字体发光 用于文字说明 显目作用
		 * @param	_c 颜色
		 * @param	bXY 距离
		 * @param	strength 强度 
		 * note
		 * @return
		 */
		public static function getTextFilter(_c:Number = 0x000000, _alpha:Number = 1, bXY:Number = 2, _strength:Number = 500):Array {
			var color:Number = _c;
			var alpha:Number = _alpha
			var blurX:Number = bXY;
			var blurY:Number = bXY;
			var strength:Number = _strength;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.LOW;
			var gf:GlowFilter = new GlowFilter(color,
	                                  alpha,
	                                  blurX,
	                                  blurY,
	                                  strength,
	                                  quality,
	                                  inner,
	                                  knockout);
			var myFilters:Array = new Array();
			myFilters.push(gf);
			return myFilters;
		}
		/**
		 * 房子发光效果
		 * @param	_color 发光颜色
		 * note
		 * @return
		 */
		public static function getHouseFilter(_color:Number = 0xFF0000):Array {
			var color:Number = _color;
			var alpha:Number = .5
			var blurX:Number = 2;
			var blurY:Number = 2;
			var strength:Number = 100;
			var inner:Boolean = false;
			var knockout:Boolean = false;
			var quality:Number = BitmapFilterQuality.HIGH;
			var gf:GlowFilter = new GlowFilter(color,
	                                  alpha,
	                                  blurX,
	                                  blurY,
	                                  strength,
	                                  quality,
	                                  inner,
	                                  knockout);
			var myFilters:Array = new Array();
			myFilters.push(gf);
			return myFilters;
		}
		/**
		 * 灰 滤镜  用来灰掉一切对象
		 * note
		 * @return
		 */
		public static function get getGrayFilter():Array {
			var cl:ColorMatrixFilter = new ColorMatrixFilter([0.3, 0.6, 0.1, 0, 0, 0.3, 0.6, 0.1, 0, 0, 0.3, 0.6, 0.1, 0, 0, 0, 0, 0, 1, 0]);
			var myFilters:Array = new Array();
			myFilters.push(cl);
			return myFilters;
		}
		/**
		 * 变暗 不会灰掉
		 * note
		 * @return
		 */
		public static function get getDarkFilter():Array {
			//trace("xx")
			var cl:ColorMatrixFilter = new ColorMatrixFilter([0.5, 0.4, 0.1, 0, 0, 0.2, 0.7, 0.1, 0, 0, 0.2, 0.4, 0.4, 0, 0, 0, 0, 0, 1, 0]);
			var myFilters:Array = new Array();
			myFilters.push(cl);
			return myFilters;
		}
	}

}