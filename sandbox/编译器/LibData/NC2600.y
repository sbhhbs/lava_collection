<
  5
机 型:NC2600
原型:void exeasm(char &buf[]);
功能:在LavaX环境下执行汇编代码。
说明:buf为汇编代码地址。汇编效率高，且可以做任何事，但无法跨平台，要合理利用。
举例:
#include <NC2600.y>
char buf[]={0x00,0x1d,0x05,0x60};//即INT $051d RTS
void main()
{SetScreen(0);
 printf("空间整理中...\n");
 exeasm(buf);
 printf("OK!\n");
 getchar();
}

原型:void call(int brk);
功能:在LavaX环境下调用系统中断。
说明:brk为系统中断号。
 如：0x051b为空间整理。类似汇编中的
 INT $051b
 RTS
举例:
#include <NC2600.y>
void main()
{SetScreen(0);
 printf("空间整理中...\n");
 call(0x051b);
 printf("OK!\n");
 getchar();
}

原型:void DiskReclaim();
功能:空间整理。
举例:
#include <NC2600.y>
void main()
{SetScreen(0);
 printf("空间整理中...\n");
 DiskReclaim();
 printf("OK!\n");
 getchar();
}

原型:long DiskCheck();
功能:获取磁盘剩余空间。
说明:返回剩余磁盘空间大小，单位为KB。使用该函数前最好先空间整理一下。
举例:
#include <NC3000.y>
void main()
{SetScreen(0);
 DiskReclaim();
 printf("剩余空间:%dKB\n",DiskCheck());
 getchar();
}

原型:void SetFlmMode(struct FLM_BUF &cut,char &pic[]);
功能:设置播放的缓冲区地址。
说明:配合FlmDecode函数使用，必须在FlmDecode函数前调用改函数。使用该函数前必须定义：
struct FLM_BUF
{char cmd;
 char pic[1600];
};
这是存放压缩数据的缓冲区，所以参数cut就是压缩数据缓冲区，而参数pic是解压缩后的数据缓冲区。

原型:void FlmDecode();
功能:flm影片解码。
说明:配合SetFlmMode函数使用，只有在调用FlmDecode函数后才能调用该函数。
举例:
#define ESC_KEY 0x1b
#include <NC3000.y>
struct FLM_BUF
{char cmd;
 char pic[1600];
};
void playFlm2(int fn)
{char fp,head[16];
 char ms,low,high;
 int tmp,length,frame,process,speed;
 struct FLM_BUF cut;
 char pic[1600];
 if(!(fp=fopen(fn,"r")))return;
 fread(head,1,16,fp);
 if(head[0]!='F'||head[1]!='L'||head[2]!='M'||head[3]!=0x10){fclose(fp);return;}//不是有效的FLM文件
 if(head[4])//压缩格式的flm文件
  {frame=head[5]+(head[6]<<8);//祯数
   speed=head[7];//速度(延迟tick数)
   SetFlmMode(cut,pic);//设置播放的缓冲区地址
   for(process=0;process<frame&&Inkey()!=ESC_KEY;process++)
    {ms=Getms();
     fread(&tmp,1,2,fp);length=(tmp&0xfff)-2;cut.cmd=tmp>>12;//读取长度
     fread(cut.pic,1,length,fp);cut.pic[length]=0xc1;//读取压缩数据
     FlmDecode();//解码
     WriteBlock(0,0,160,80,0x41,pic);//显示
     if(speed){while(((Getms()-ms)&0xff)<speed);}//延时，祯控制
    }
   }
 fclose(fp);
}
void main()
{char fn[60];
 ChDir("/开机画面");
 for(;;)
  {if(!FileList(fn)){ChDir("..");continue;}
   if(ChDir(fn))continue;
   playFlm2(fn);
   ChDir("/开机画面");
  }
} �!>	 㩳               exeasm             剦  58�剦 y�  58?> 㩳              call               	 �  58
 �  58 � `58	 =   ?>  㩳  D             DiskReclaim        =  =  ?>  㩳 W             DiskCheck          A  � �m{��8�|�
�
��
杞��
� �
��
� 呟�呠 � 厛厜厐�厑i鷧偉乮 厓� 眬���� 
�鎴�鎵栲愹鎬�鎭艃�艂愗i0厛�鎵`  =    � "J ? ?> 㩳  �            SetFlmMode         A  〡厐�&厑� 厒� 厓瓙,��� 眬憘刃佹兪序眬憘仁续`��`���� 槕側宣鎯市觫@憘仁喧� 厒� 厓� 眬葽�)?�〡e倕倫鎯鎬�鎭� 眬闪雄`蓘�()?�〡獱 眰i�憘鎮�鎯市疰��鎭� 眬闪携`衫�')?�〡獱 鎬�鎭眬q倯傛��鎭鎮�鎯市牮�)?�〡��鎭� 眬厔眰e剳傛傂鎯市疰��鎭� 馃
   E 58
   E K 58	
  S
  	 558
  W
  	 K 558
   E  58
   E  K 58?>  㩳  h            FlmDecode          剦    58�剦 y�  58?