﻿package  {	import flash.display.MovieClip;	import flash.display.DisplayObject;	import FacesList;	import flash.display.Sprite;	import flash.media.Camera;	import flash.media.Video;	import flash.display.BitmapData;	import flash.display.Bitmap;	import flash.printing.PrintJob;	import flash.events.MouseEvent;	import flash.events.Event;	import flash.net.FileReference;	import flash.net.FileFilter;	import flash.utils.ByteArray;	import flash.display.MovieClip;	import flash.display.SimpleButton;	import flash.filters.ColorMatrixFilter;	import flash.filters.ConvolutionFilter;	import flash.filters.BlurFilter;		import flash.net.FileReference;	import flash.printing.PrintJob; 	import flash.external.ExternalInterface;	import flash.net.navigateToURL;	import flash.net.URLRequest;	import flash.net.URLLoader;	//import flash.net.URLVariables;	import flash.net.URLRequestMethod;	import com.adobe.images.PNGEncoder;	import DrawingMakeup0731;	import flash.geom.Matrix;	import flash.geom.Point;		import flash.events.StatusEvent;		import com.adobe.serialization.json.JSON;		public class JiaJiangwholeTest extends MovieClip	{		private var jiajaingMakup:FacesList;				private var camera:Camera = Camera.getCamera();		private var video:Video;				private var bandwidth:int = 0; //quality setting		private var quality:int = 100;  //quality setting				private var bmp:Bitmap;		private var bmdata:BitmapData;						//private var fileReference:FileReference = new FileReference();		private var byteArray:ByteArray;				private var faceMakeuped:MovieClip;		private var faceMakeuped2:MovieClip;		private var capture:MovieClip;		private var discardButton:SimpleButton;		private var viewMore_mc:SimpleButton;				private var UI:DrawingMakeup0731; //UI = drawing part						private var mygrey:ColorMatrixFilter = new ColorMatrixFilter([0.72,0.8,0.1,0,0,//red																	  0.5,0.6,0.2,0,0,//green																	  0.1,0.7,0.1,0,0,//blue																	  0,0,0,1,0]);  //alpha 																	  		private var myconvolution2:ConvolutionFilter = new ConvolutionFilter(3,3,[-1.8,-1,0,-0.5,1,1,0,1,2]);		//private var myconvolution2:ConvolutionFilter = new ConvolutionFilter(3,3,[0,1,0,1,-3,1,0,1,0]);		private var blurEffect:BlurFilter=new BlurFilter(1,1,1);				private var current_tool:int;		private const TOOL_MOVE:int = 1;		private const TOOL_DRAW:int = 2;		private var toggleBtn1:toggle_btnMove;		private var toggleBtn1Gray:toggle_btnMoveGray;		private var toggleBtn2:toggle_btnDraw;		private var toggleBtn2Gray:toggle_btnDrawGray;		private var toolBack_mc:MovieClip;				private var toolcontentB1_mc:MovieClip;		private var switchBcover_mc:MovieClip;				private var saveBtn_mc:MovieClip;		private var saveDialog_mc:MovieClip;		private var uploadDialog_mc:MovieClip;		private var printBtn_mc:MovieClip;		private var facebookBtn_mc:MovieClip;		private var imagePost_mc:MovieClip;				private var helpInfo_mc:SimpleButton;		private const BOARD_WIDTH = 420;		private const BOARD_HEIGHT = 550;		private const BOARD_SIZE = new Point(BOARD_WIDTH,BOARD_HEIGHT);				public var cameraX:int=450;  // 這邊改的時候 Makeup class的 topleft point 也要改		public var cameraY:int=100;				private var uploadedID:int;				//往前推的判定		private var camCapture_mc:MovieClip;				private var agreeDialogue_mc:MovieClip;		public function JiaJiangwholeTest() 		{			addCameraButton();  //function			//videoSet();         //function						current_tool = TOOL_MOVE; // 定義工具 在設定現在是甚麼工具			setTool(TOOL_MOVE);					}		//------set begining control close makeup or drawing --------------------------------------------------------				private function setTool(which:int)		{			switch (which)			{				case TOOL_MOVE:					current_tool = TOOL_MOVE;					if (UI)					{						UI.disable();  // disable and enable都同時設定在makeup transfer 跟drwaing 裡面的 active 						UI.stroke2.visible = false;						UI.stroke1.visible = false;											}					if (jiajaingMakup)					{						jiajaingMakup.enable();											}										break;				case TOOL_DRAW:					current_tool = TOOL_DRAW;					if (jiajaingMakup)					{						jiajaingMakup.disable();						jiajaingMakup.defaultTool.target = null;  // 在畫畫的時候  要關起來						jiajaingMakup.selected_mc = null;					}					if (UI)					{						UI.enable();						UI.actived = "Stroke1";						UI.stroke2.visible = false;						UI.stroke1.visible = true;					}					break;			}								}		private function toggleTool1(e:MouseEvent)		{			e.stopPropagation();			setTool(TOOL_MOVE);						highlightedTool(toggleBtn1);			hideTools(toggleBtn2);						switchBcover_mc.visible=true;		}		private function toggleTool2(e:MouseEvent)		{			e.stopPropagation();			setTool(TOOL_DRAW);		    			highlightedTool(toggleBtn2);			hideTools(toggleBtn1);						switchBcover_mc.visible=false;		}				private function highlightedTool(btn1:DisplayObject):void		{			btn1.visible=true;					}		private function hideTools(btn2:DisplayObject):void		{			btn2.visible=false;					}		//------addBtn------------------------------------------------------------------				private function addCameraButton()		{			toolBack_mc = new toolBack();			addChild(toolBack_mc);			toolBack_mc.x=870;			toolBack_mc.y=100;			toolBack_mc.alpha=0.9;			toolBack_mc.visible=false;						discardButton =new DiscardButton();			addChild(discardButton);			discardButton.x=634;			discardButton.y=660;						capture = new captureBtn();			addChild(capture);			capture.x = 634;			capture.y = 660;						toolcontentB1_mc = new toolcontentB1();			addChild(toolcontentB1_mc);			toolcontentB1_mc.x =935;			toolcontentB1_mc.y=120;			toolcontentB1_mc.visible=false;						toggleBtn1Gray=new toggle_btnMoveGray();			addChild(toggleBtn1Gray);			toggleBtn1Gray.x = 947;			toggleBtn1Gray.y = 132;		    			toggleBtn1 = new toggle_btnMove();			addChild(toggleBtn1);			toggleBtn1.x = 947;			toggleBtn1.y = 132;						toggleBtn2Gray=new toggle_btnDrawGray();			addChild(toggleBtn2Gray);			toggleBtn2Gray.x = 1060;			toggleBtn2Gray.y = 132;						toggleBtn2=new toggle_btnDraw();			addChild(toggleBtn2);			toggleBtn2.x = 1060;			toggleBtn2.y = 132;									toggleBtn1.visible=false;			toggleBtn2.visible=false;			toggleBtn1Gray.visible=false;			toggleBtn2Gray.visible=false;						toggleBtn1Gray.addEventListener(MouseEvent.MOUSE_DOWN,toggleTool1);			toggleBtn2Gray.addEventListener(MouseEvent.MOUSE_DOWN,toggleTool2);						bmdata= new BitmapData(BOARD_WIDTH,BOARD_HEIGHT); //x y 的長寬						discardButton.visible = false;			discardButton.addEventListener(MouseEvent.MOUSE_DOWN, discard);			capture.addEventListener(MouseEvent.MOUSE_DOWN, captureImage);			saveBtn_mc = new saveBtn();			addChild(saveBtn_mc);			saveBtn_mc.x=1200;			saveBtn_mc.y=600;			saveBtn_mc.addEventListener(MouseEvent.MOUSE_DOWN,saveFunction);			saveBtn_mc.visible=false;						printBtn_mc = new printBtn();			addChild(printBtn_mc);			printBtn_mc.x=1200;			printBtn_mc.y=650;			printBtn_mc.addEventListener(MouseEvent.MOUSE_DOWN,printFunction);			printBtn_mc.visible=false;						facebookBtn_mc = new facebookBtn();			addChild(facebookBtn_mc);			facebookBtn_mc.x=1200;			facebookBtn_mc.y=700;			facebookBtn_mc.addEventListener(MouseEvent.MOUSE_DOWN,FaceBookShareFunction);			facebookBtn_mc.visible=false;						camCapture_mc = new camCapture();			addChild(camCapture_mc);			camCapture_mc.addEventListener(MouseEvent.MOUSE_DOWN, resetvideo);			camCapture_mc.x=530;			camCapture_mc.y=250;						capture.visible = false;					}		//----------進入相機前面的page	--------------------------------------------		private function resetvideo(e:MouseEvent)		{						agreeDialogue_mc = new agreeDialogue();			addChild(agreeDialogue_mc);			agreeDialogue_mc.x=500;			agreeDialogue_mc.y=200;					    agreeDialogue_mc.closebtnIncamera.addEventListener(MouseEvent.CLICK, removeDialogueFunction);			agreeDialogue_mc.facebookbtn.addEventListener(MouseEvent.CLICK, facebookLoginFunction);			agreeDialogue_mc.howTobtn.addEventListener(MouseEvent.CLICK, howTobtnFunction);						agreeDialogue_mc.agreebtn.addEventListener(MouseEvent.CLICK, agreebtnFunction);			agreeDialogue_mc.denybtn.addEventListener(MouseEvent.CLICK, removeDialogueFunction);		}				private function removeDialogueFunction(e:MouseEvent)		{			removeChild(agreeDialogue_mc);			agreeDialogue_mc.closebtnIncamera.removeEventListener(MouseEvent.CLICK, removeDialogueFunction);			agreeDialogue_mc.facebookbtn.removeEventListener(MouseEvent.CLICK, facebookLoginFunction);			agreeDialogue_mc.howTobtn.removeEventListener(MouseEvent.CLICK, howTobtnFunction);			agreeDialogue_mc.denybtn.removeEventListener(MouseEvent.CLICK, removeDialogueFunction);					}			    private function facebookLoginFunction(e:MouseEvent):void 		{ 	    var req:URLRequest=new URLRequest("http://www.facebook.com"); 	    navigateToURL(req,"_blank"); 		} 				private function howTobtnFunction(e:MouseEvent):void 		{ 	    var req:URLRequest=new URLRequest("http://sunny.chunhuanglo.com/testSendtoTable/howTo/howTopopup.html"); 	    navigateToURL(req,"_blank"); 		} 				private function agreebtnFunction(e:MouseEvent):void		{			videoSet();			agreeDialogue_mc.agreebtn.removeEventListener(MouseEvent.MOUSE_UP, agreebtnFunction);					}				//------sharePictures------------------------------------------------------------------						private function FaceBookShareFunction(evt:MouseEvent)		{			imagePost_mc = new imagePost();			addChild(imagePost_mc);			imagePost_mc.x = 500;			imagePost_mc.y = 250;			imagePost_mc.closeBtn.addEventListener(MouseEvent.CLICK, closeFacebookDialog);			imagePost_mc.facebookbtn.addEventListener(MouseEvent.CLICK, facebookLoginFunction);			imagePost_mc.howTobtn.addEventListener(MouseEvent.CLICK, howTobtnFunction);			//ExternalInterface.call('connectToFB','');			uploadToFacebook(); //for upload to database and then go to javascript  		}		private function closeFacebookDialog(e:MouseEvent)		{			imagePost_mc.closeBtn.removeEventListener(MouseEvent.CLICK, closeFacebookDialog);			imagePost_mc.facebookbtn.removeEventListener(MouseEvent.CLICK, facebookLoginFunction);			imagePost_mc.howTobtn.removeEventListener(MouseEvent.CLICK, howTobtnFunction);			removeChild(imagePost_mc);		}				private function uploadToFacebook()		{		    var bmd:BitmapData = composeImage();			var ba:ByteArray = PNGEncoder.encode(bmd);						var urloader:URLLoader = new URLLoader;			var url = new URLRequest('http://sunny.chunhuanglo.com/testSendtoTable/AS_JSTest1011JIA/save_pic.php');						url.data = ba;			url.method = URLRequestMethod.POST;			url.contentType ='application/octet-stream';						urloader.addEventListener(Event.COMPLETE, jpgComplete);			urloader.load(url);						function jpgComplete(e:Event):void 			{				trace(urloader.data);								var dat:Object = JSON.decode(urloader.data);				trace('RESULT: ' + dat.result);				trace('TEXT: ' + dat.text);								if (dat.result == 1)				{					uploadedID = dat.text;				}								if (ExternalInterface.available) 				{					ExternalInterface.call('connectToFB',dat.text);									}												trace('upload complete!');			}								}			//------save------------------------------------------------------------------				private function saveFunction(e:MouseEvent)		{			var bmd:BitmapData = composeImage();						var ba:ByteArray = PNGEncoder.encode(bmd);			var file:FileReference = new FileReference(); // FileReference 使用者的桌面			file.addEventListener(Event.COMPLETE, saveSuccessful);			file.save(ba, "MyDrawing.png");						bmd.dispose(); //dispose 清理記憶體裡面的空間 		}				//------save 成功的對話窗------------------------------------------------------------------			private function saveSuccessful(e:Event):void		{			saveDialog_mc = new SaveDialog();			saveDialog_mc.x=600;			saveDialog_mc.y=300;			addChild(saveDialog_mc);						//jiajaingMakup.disable(); //要存的時候先把畫畫跟transfer的功能都鎖住			//UI.disable();			saveDialog_mc.closeBtn.addEventListener(MouseEvent.CLICK, closeSaveDialog);		}		private function closeSaveDialog(e:MouseEvent):void		{ 			removeChild(saveDialog_mc);			 			//UI.enable(); //存完在把畫畫跟transfer的功能解開			//jiajaingMakup.enable();		}//------print------------------------------------------------------------------						private function printFunction(evt:MouseEvent)		{			var bmd:BitmapData = composeImage();			var bm:Bitmap = new Bitmap(bmd);						var printS:Sprite=new Sprite();			printS.addChild(bm);				        var printJob:PrintJob = new PrintJob();						if (printJob.start()) {								printJob.addPage(printS);				printJob.send();			}						bmd.dispose();					}//------composeImage 整合圖片---------------------------------------------------------------		private function composeImage():BitmapData		{			var bmd:BitmapData = new BitmapData(BOARD_SIZE.x, BOARD_SIZE.y);  // created a new image to export			var watermarked_mc = new watermark_mc;			bmd.draw(bmdata);  // adds the camera image						bmd.draw(faceMakeuped2); // added the 上面的圖			// instead, pass the new image to our UI object			UI.addLayers(bmd);  // add all of the painting  //UI = drawing part						// add the makeup for the current face			jiajaingMakup.addLayers(bmd);						// add in watermark info			var m:Matrix = new Matrix();			m.translate(BOARD_SIZE.x,BOARD_SIZE.y);			bmd.draw(watermarked_mc,m);						return bmd;		}		//------videoSet------------------------------------------------------------------				private function videoSet()		{			camera.setQuality(bandwidth,quality);			camera.setMode(BOARD_SIZE.x,BOARD_SIZE.y,30,true);  //setMode(videoWidth, videoHeight, video fps, favor area)						video = new Video(BOARD_WIDTH,BOARD_HEIGHT);			addChild(video);			//video.filters=[mygrey];			video.filters=[mygrey,blurEffect];  //mix filter									if (camera != null)			{				camera.addEventListener(StatusEvent.STATUS, cameraStatusHandler);				video.smoothing = true;				video.attachCamera(camera);				video.x = cameraX;				video.y = cameraY;				addChild(video);				video.visible=true;							}			else			{				trace("No Camera Detected");			}						removeChild(agreeDialogue_mc);			removeChild(camCapture_mc);			capture.visible = true;						faceMakeuped = new faceMake(); // 一開始要蓋在video上的			addChild(faceMakeuped);			faceMakeuped.x=cameraX;			faceMakeuped.y=cameraY;					}		private function cameraStatusHandler(e:StatusEvent):void 		{	    	if (camera.muted) 			{				trace("You disagree the camera");				reloadpage();			} 					}				private function reloadpage()		{			var req:URLRequest=new URLRequest("http://sunny.chunhuanglo.com/2011FallTest/makeup/testFB.html"); 	        navigateToURL(req,"_self");		}//------照到的圖片------------------------------------------------------------------						private function captureImage(e:MouseEvent):void		{			facebookBtn_mc.visible=true;			printBtn_mc.visible=true;			saveBtn_mc.visible=true;						bmdata.draw(video);			bmp = new Bitmap(bmdata);			bmp.x = cameraX;			bmp.y = cameraY;			bmp.scaleX= bmp.scaleY =1;			//bmp.alpha=0.8;			addChild(bmp);			video.visible=false;			capture.visible = false;			discardButton.visible = true;				faceMakeuped.visible=false;						faceMakeuped2 = new faceMake2();			addChild(faceMakeuped2);			faceMakeuped2.x=cameraX;			faceMakeuped2.y=cameraY;									//drawing 			addDrawing(); //addDrawing function						viewMore_mc = new viewMore();			addChild(viewMore_mc);			viewMore_mc.x=300;			viewMore_mc.y=555;			viewMore_mc.visible= true;			viewMore_mc.addEventListener(MouseEvent.MOUSE_DOWN, gotoInfo);						toolBack_mc.visible=true;			toolcontentB1_mc.visible=true;						helpInfo_mc = new helpInfo();			addChild(helpInfo_mc);			helpInfo_mc.x=810;			helpInfo_mc.y=120;			helpInfo_mc.visible=true;			helpInfo_mc.addEventListener(MouseEvent.MOUSE_DOWN, viewHelpInfo);			// faceslist 要放在這邊才不會在上ㄧ曾			addJiajiangMakeupIn();  //addJiajiangMakeupIn function						this.jiajaingMakup.visible = true;						toggleBtn1.visible=true;			toggleBtn2.visible=false;			toggleBtn1Gray.visible=true;			toggleBtn2Gray.visible=true;		}				private function discard(e:MouseEvent):void		{			facebookBtn_mc.visible=false;			printBtn_mc.visible=false;			saveBtn_mc.visible=false;						faceMakeuped2.visible=false;			faceMakeuped.visible=true;			removeChild(bmp);			discardButton.visible = false;			this.jiajaingMakup.visible = false;			capture.visible = true;			video.visible=true;			UI.visible=false;			viewMore_mc.visible= false;			helpInfo_mc.visible=false;						toolBack_mc.visible=false;			toolcontentB1_mc.visible=false;						toggleBtn1.visible=false;			toggleBtn2.visible=false;			toggleBtn1Gray.visible=false;			toggleBtn2Gray.visible=false;		}				private function addJiajiangMakeupIn()		{			this.jiajaingMakup = new FacesList("faceXmlFile/HsienFace.xml");			addChild(this.jiajaingMakup);			this.jiajaingMakup.visible = false;			setTool(TOOL_MOVE);								}				private function addDrawing()		{			UI = new DrawingMakeup0731(BOARD_SIZE);			addChild(UI);			UI.x=cameraX;  // drawing 跟camera的起始點要一致			UI.y=cameraY;						switchBcover_mc= new switchBcover();			addChild(switchBcover_mc);			switchBcover_mc.x=930;			switchBcover_mc.y=180;			switchBcover_mc.visible=true;						this.addEventListener(MouseEvent.MOUSE_DOWN,UI.handleMouseDown);			this.addEventListener(MouseEvent.MOUSE_MOVE,UI.handleMouseMove);			this.addEventListener(MouseEvent.MOUSE_UP,UI.handleMouseUp);  // 共用drawing 裡面的funciton		}				private function gotoInfo(e:MouseEvent):void 		{			var req:URLRequest=new URLRequest("http://sunny.chunhuanglo.com/2012JiaJIang/JiaJiangInfo/testInfo.html"); 	        navigateToURL(req,"_self");		}				private function viewHelpInfo(e:MouseEvent):void		{					}	}	}