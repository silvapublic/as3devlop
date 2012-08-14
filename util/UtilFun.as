package util {

	/**
	 * 功能函数集
	 * @author zl
	 */
	public class UtilFun {
		public static const FORMAT:String = "format";
		public static const SECOND:String = "second";
		public function UtilFun() { };
		/**
		 * 创建文本框按钮
		 * @param	tarStr 显示内容
		 * @param	eventType 事件类型
		 * @return 	html	字符
		 */
		public static function createLink(tarStr:String, eventType:String):String {
			var link:String = "";
			link += "<u>";
			link += "<a href='event:" + eventType + "'>" + tarStr + "</a>";
			link += "</u>";
			return link;
		}
		/**
		 * 替换字符串中与正则配对的字符  （用于写死了的定义）
		 * @param	reg 替换的正则
		 * @param	to 替换成的字符
		 * @param	repl 指定需要替换字符串
		 * @return String
		 */ 
		public static function ReplaceString(reg:RegExp, to:String, repl:String):String {
			if (repl == null) {
				trace("ReplaceString:替换源为null");
				return "";
			}
			return repl.replace(reg, to);
		}
		/**
		 * 修改字符串中与正则配对的字符 （用于服务器返回的定义）
		 * @param	reg 替换的正则
		 * @param	repl 指定替换字符串
		 * @return
		 */
		public static function ChangeString(reg:RegExp, repl:String):String {
			return repl.replace(reg, replFun);
		}
		/**
		 * 
		 * @return
		 */
		static private function replFun():String {
			return createLink("<span class='link'>" + arguments[1] + "</span>", arguments[2]);
		}
		/**
		 * 随机给定范围数
		 * @param	min 起始值
		 * @param	max 终止值
		 * @return
		 */
		public static function randRange(min:Number, max:Number):Number {
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min; 
			return randomNum; 
		}
		/**
		 * 时间计算 以电脑现在的时间为基础 计时过去 与未来的时差
		 * @param	_time 格式为字符型： "2010-08-17 15:0:0" 或是秒数据 数字型：1281888000
		 * @param	_returnType 返回的类型 format 返回时间格式 second返回秒数 
		 * @return 
		 */
		public static function CalculateTimer(_time:*, _returnType:String = FORMAT):String {
			var StarTim:Number;
			var nowTim:Date = new Date();
			if (_time is String){
				StarTim = resolveTimeFormat(_time);
			}else if (_time is Number){
				StarTim = _time;
			}
			var StartTime:Number = StarTim / 1000;
			var EndTime:Number = Math.floor((Number(nowTim)/1000));
			var JobTime:Number = EndTime - StartTime;
			
			if (_returnType == FORMAT){
				return ConvertTime(JobTime);
			}else if (_returnType == SECOND){
				//负数为倒数 正数为正数
				return JobTime.toString();
			}
			return "";
		}
		/**
		 * DATE格式时间转化成字符串时间 
		 * 2000-10-05 
		 * @param	_date
		 * @param	_type day -> 2000-10-05  all -> 2000-10-05 10:20:13
		 * @return
		 */
		public static function dateToString(_date:Date, _type:String = "day"):String {
			var dayStr:String = _date.getUTCFullYear().toString() + "-" + (pad((_date.getUTCMonth() + 1).toString(), 2)) + "-" + pad(_date.getUTCDate().toString(), 2) + " ";
			if(_type == "all") {
				dayStr += pad(_date.getUTCHours().toString(), 2) + ":" + pad(_date.getUTCMinutes().toString(), 2) + ":" + pad(_date.getUTCSeconds().toString(), 2);
			}
			return dayStr;
		}
		/**
		 * 指定的秒数据 返回天数+小时
		 * @param	_time
		 * @return
		 */
		public static function CalculateDay(_time:Number):String {
			var JobDay:Number = Math.floor(_time / 86400);
			var JobHous:Number = Math.floor((_time / 3600 % 24));
			//var JobMin:Number=Math.floor((JobTime/60%60));
			//var JobSec:Number=Math.floor((JobTime%60));
			if(JobDay > 0) {
				return JobDay.toString() + "天" + JobHous.toString() + "时";
			}
			return JobHous.toString() + "时";
		}
		/**
		 * 解析字符串时间格式 转换成国际通用时间格式
		 * @param	_timeFormat 字符时间格式
		 * @return
		 */
		public static function resolveTimeFormat(_timeFormat:String):Number {
			var returnNumber:Number;
			var serDate:Date;
			var tempArr1:Array = _timeFormat.split(" ");
			var tempArr2:Array = (tempArr1[0] as String).split("-");
			var tempArr3:Array = (tempArr1[1] as String).split(":");
			var Year:Number = Number(tempArr2[0]);
			var Moon:Number = Number(tempArr2[1]) - 1;
			var Day:Number = Number(tempArr2[2]);
			//var Hous:Number = Number(tempArr3[0]) == 0?0:Number(tempArr3[0]) % 12 + 12;
			var Hous:Number = Number(tempArr3[0]) 
			var Min:Number = Number(tempArr3[1]);
			var second:Number = Number(tempArr3[2]);
			serDate = new Date(Year, Moon, Day, Hous, Min, second);
			serDate.setTime(Date.UTC(Year, Moon, Day, Hous, Min, second));
			returnNumber = Number(serDate);
			return returnNumber;
		}
		/**
		 * 获取本地国际通用时间 毫秒
		 * @return
		 */
		public static function getLocaltimer():Number {
			var localDate:Date = new Date();
			localDate.setTime(Date.UTC(localDate.fullYear, localDate.month, localDate.date, localDate.hours, localDate.minutes, localDate.seconds));
			return Number(localDate);
		}
		/**
		 * 将秒数据格式转化为 00:00:00格式
		 * @param	_timeNum
		 * @return String
		 */
		public static function ConvertTime(_timeNum:int, _formatType:String = "number"):String {
			var returnStr:String;
			if(_formatType == "number") {
				returnStr = ( pad(Math.abs(int(_timeNum / 3600)).toString(), 2) + ":" + pad(Math.abs(int(_timeNum % 3600 / 60)).toString(), 2) + ":" +  pad(Math.abs(int(_timeNum % 3600 % 60)).toString(), 2) + "");
			}else if(_formatType == "string") {
				var JobDay:Number = Math.floor(_timeNum / 86400);
				if(JobDay > 0) {
					returnStr = JobDay.toString() + "天" + pad(Math.abs(int(_timeNum / 3600 % 24)).toString(), 2) + " 时 " + pad(Math.abs(int(_timeNum % 3600 / 60)).toString(), 2) + "分" +  pad(Math.abs(int(_timeNum % 3600 % 60)).toString(), 2) + "秒";
				}else {
					returnStr = ( pad(Math.abs(int(_timeNum / 3600)).toString(), 2) + " 时 " + pad(Math.abs(int(_timeNum % 3600 / 60)).toString(), 2) + " 分 " +  pad(Math.abs(int(_timeNum % 3600 % 60)).toString(), 2) + "秒";
				}
			}
			return returnStr;
		}
		/**
		 * 数位不够向前补0
		 * @param	num 输入的数字
		 * @param	n	数位
		 * @return String
		 */
		public static function pad(num:String, n:int):String {
			if ((num + "").length >= n) return num
			return pad("0" + num, n);
		}
	}
}