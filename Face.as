﻿package  {		import flash.display.MovieClip;	import flash.display.Loader;	import flash.net.URLRequest;	import flash.events.MouseEvent;	import flash.text.TextField;	import flash.text.TextFormat;	import flash.display.BitmapData;	import flash.geom.Point;		public class Face extends MovieClip	{		private var makeuplist:Array;  // list of makeup items that need to be exported along with the rest of the image		private var makeuplist_mc:MovieClip;				public var info_text:String;		public var info_title:String;		private var faceElementInfo:String;		private var mc:Loader;		private var piecetextInfo:TextField;				public function Face(faceinfo:XML) 		{						this.makeuplist = new Array();					var imglist:XMLList = faceinfo.imageS;						piecetextInfo = new TextField();			//addChild(piecetextInfo);			piecetextInfo.x = 150;			piecetextInfo.y = 550;			piecetextInfo.width = 150;			piecetextInfo.height = 150;			piecetextInfo.wordWrap = true;									for (var i=0; i<imglist.length(); i++){				//var mc = new Loader(imglist[i]);				//renew a makeup				//mc  mi是底圖的臉								var mi = new Makeup(imglist[i]);				mi.clickable = false;				addChild(mi);								if (imglist[i].clickable != 0)				{					var m = new Makeup(imglist[i]);					addChild(m);					makeuplist.push(m);									}			}					    this.info_text = faceinfo.infoS;			this.info_title = faceinfo.general;					}				public function addLayers(newImg:BitmapData)		{			// run through the list of makeup objects			for (var i:int=0;i<makeuplist.length;i++)			{				makeuplist[i].addLayer(newImg);							}					}				public function showInfoText(info:String)		{			piecetextInfo.text = info;						var textFormatTitle = new TextFormat();			textFormatTitle.color =0x000000;			textFormatTitle.size=11.5;			textFormatTitle.letterSpacing=0;			piecetextInfo.setTextFormat(textFormatTitle);		}	}	}