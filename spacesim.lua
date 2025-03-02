                                                                                 local StrToNumber=    
                                                                        tonumber;local Byte=string.byte;local Char=     
                                                                    string.char;local Sub=string.sub;local Subg=string.gsub;local 
                                                                 Rep=string.rep;local Concat=table.concat;local Insert=table.insert;    
                                                            local LDExp=math.ldexp;local GetFEnv=getfenv or function() return _ENV;end ;  
                                                          local Setmetatable=setmetatable;local PCall=pcall;local Select=select;local       
                                                        Unpack=unpack or table.unpack ;local ToNumber=tonumber;local function VMCall(         
                                                      ByteString,vmenv,...) local DIP=1;local repeatNext;ByteString=Subg(Sub(ByteString,5),".." 
                                                    ,function(byte) if (Byte(byte,2)==81) then local FlatIdent_91AE4=0;while true do if (         
                                                  FlatIdent_91AE4==0) then repeatNext=StrToNumber(Sub(byte,1,1));return "";end end else local       
                                                  FlatIdent_99831=0;local a;while true do if (0==FlatIdent_99831) then a=Char(StrToNumber(byte,16));  
                                                if repeatNext then local b=Rep(a,repeatNext);repeatNext=nil;return b;else return a;end break;end end    
                                                end end);local function gBit(Bit,Start,End) if End then local FlatIdent_5C9D7=0;local Res;while true do   
                                              if (FlatIdent_5C9D7==0) then Res=(Bit/(2^(Start-1)))%(2^(((End-1) -(Start-1)) + 1)) ;return Res-(Res%1) ;end  
                                              end else local Plc=2^(Start-1) ;return (((Bit%(Plc + Plc))>=Plc) and 1) or 0 ;end end local function gBits8() 
                                             local FlatIdent_15AD5=0;local a;while true do if (FlatIdent_15AD5==0) then a=Byte(ByteString,DIP,DIP);DIP=DIP +  
                                            1 ;FlatIdent_15AD5=1;end if (FlatIdent_15AD5==1) then return a;end end end local function gBits16() local           
                                          FlatIdent_51A3C=0;local a;local b;while true do if (FlatIdent_51A3C==1) then return (b * 256) + a ;end if (             
                                          FlatIdent_51A3C==0) then a,b=Byte(ByteString,DIP,DIP + 2 );DIP=DIP + 2 ;FlatIdent_51A3C=1;end end end local function      
                                          gBits32() local FlatIdent_95CAC=0;local a;local b;local c;local d;while true do if (FlatIdent_95CAC==1) then return (d *    
                                          16777216) + (c * 65536) + (b * 256) + a ;end if (FlatIdent_95CAC==0) then a,b,c,d=Byte(ByteString,DIP,DIP + 3 );DIP=DIP + 4 
                                         ;FlatIdent_95CAC=1;end end end local function gFloat() local Left=gBits32();local Right=gBits32();local IsNormal=1;local       
                                        Mantissa=(gBit(Right,1,20) * (2^32)) + Left ;local Exponent=gBit(     --[[==============================]]Right,21,31);local Sign 
                                        =((gBit(Right,32)==1) and  -1) or 1 ;if (Exponent==0) then  --[[============================================]]if (Mantissa==0)    
                                        then return Sign * 0 ;else local FlatIdent_8D327=0;     --[[======================================================]]while true do   
                                      if (FlatIdent_8D327==0) then Exponent=1;IsNormal=0;   --[[==========================================================]]break;end end end 
                                       elseif (Exponent==2047) then return ((Mantissa==0) --[[==============================================================]] and (Sign * (1 
                                      /0))) or (Sign * NaN) ;end return LDExp(Sign,       --[[================================================================]]Exponent-1023 ) 
                                       * (IsNormal + (Mantissa/(2^52))) ;end local        --[[==================================================================]]function      
                                      gString(Len) local FlatIdent_24A02=0;local Str;     --[[==================================================================]]local FStr;       
                                    while true do if (FlatIdent_24A02==3) then return     --[[====================================================================]]Concat(FStr); 
                    end if (FlatIdent_24A02==0) then Str=nil;if  not Len then local       --[[====================================================================]]FlatIdent_63487 
              =0;while true do if (FlatIdent_63487==0) then Len=gBits32();if (Len==0)     --[[======================================================================]]then return   
            "";end break;end end end FlatIdent_24A02=1;end if (FlatIdent_24A02==2) then   --[[======================================================================]]FStr={};for   
          Idx=1, #Str do FStr[Idx]=Char(Byte(Sub(Str,Idx,Idx)));end FlatIdent_24A02=3;end --[[======================================================================]] if (         
        FlatIdent_24A02==1) then Str=Sub(ByteString,DIP,(DIP + Len) -1 );DIP=DIP + Len ;  --[[======================================================================]]              
        FlatIdent_24A02=2;end end end local gInt=gBits32;local function _R(...) return {  --[[======================================================================]]...},Select(  
      "#",...);end local function Deserialize() local Instrs={};local Functions={};local  --[[======================================================================]]Lines={};     
      local Chunk={Instrs,Functions,nil,Lines};local ConstCount=gBits32();local Consts={};  --[[==================================================================]]for Idx=1,      
      ConstCount do local FlatIdent_677DA=0;local Type;local Cons;while true do if (        --[[================================================================]]FlatIdent_677DA== 
    0) then Type=gBits8();Cons=nil;FlatIdent_677DA=1;end if (FlatIdent_677DA==1) then if (  --[[==============================================================]]Type==1) then     
    Cons=gBits8()~=0 ;elseif (Type==2) then Cons=gFloat();elseif (Type==3) then Cons=gString( --[[==========================================================]]);end Consts[Idx]=  
    Cons;break;end end end Chunk[3]=gBits8();for Idx=1,gBits32() do local Descriptor=gBits8();  --[[====================================================]]if (gBit(Descriptor,1,1 
    )==0) then local Type=gBit(Descriptor,2,3);local Mask=gBit(Descriptor,4,6);local Inst={       --[[==============================================]]gBits16(),gBits16(),nil,  
    nil};if (Type==0) then local FlatIdent_83DF4=0;while true do if (FlatIdent_83DF4==0) then Inst[3] --[[====================================]]=gBits16();Inst[4]=gBits16(); 
    break;end end elseif (Type==1) then Inst[3]=gBits32();elseif (Type==2) then Inst[3]=gBits32() -(2^16) --[[========================]] ;elseif (Type==3) then Inst[3]=      
    gBits32() -(2^16) ;Inst[4]=gBits16();end if (gBit(Mask,1,1)==1) then Inst[2]=Consts[Inst[2]];end if (gBit(Mask,2,2)==1) then Inst[3]=Consts[Inst[3]];end if (gBit(Mask, 
  3,3)==1) then Inst[4]=Consts[Inst[4]];end Instrs[Idx]=Inst;end end for Idx=1,gBits32() do Functions[Idx-1 ]=Deserialize();end return Chunk;end local function Wrap(     
  Chunk,Upvalues,Env) local Instr=Chunk[1];local Proto=Chunk[2];local Params=Chunk[3];return function(...) local Instr=Instr;local Proto=Proto;local Params=Params;     
  local _R=_R;local VIP=1;local Top= -1;local Vararg={};local Args={...};local PCount=Select("#",...) -1 ;local Lupvals={};local Stk={};for Idx=0,PCount do if (Idx>=     
  Params) then Vararg[Idx-Params ]=Args[Idx + 1 ];else Stk[Idx]=Args[Idx + 1 ];end end local Varargsz=(PCount-Params) + 1 ;local Inst;local Enum;while true do Inst=Instr 
  [VIP];Enum=Inst[1];if (Enum<=65) then if (Enum<=32) then if (Enum<=15) then if (Enum<=7) then if (Enum<=3) then if (Enum<=1) then if (Enum>0) then local                
  FlatIdent_44839=0;local A;while true do if (FlatIdent_44839==0) then A=Inst[2];Stk[A]=Stk[A](Unpack(Stk,A + 1 ,Top));break;end end else local FlatIdent_25011=0;local A 
  ;local Results;local Edx;while true do if (FlatIdent_25011==0) then A=Inst[2];Results={Stk[A](Stk[A + 1 ])};FlatIdent_25011=1;end if (FlatIdent_25011==1) then Edx=0;   
  for Idx=A,Inst[4] do local FlatIdent_1076E=0;while true do if (FlatIdent_1076E==0) then Edx=Edx + 1 ;Stk[Idx]=Results[Edx];break;end end end break;end end end elseif ( 
  Enum>2) then local A=Inst[2];local Step=Stk[A + 2 ];local Index=Stk[A] + Step ;Stk[A]=Index;if (Step>0) then if (Index<=Stk[A + 1 ]) then local FlatIdent_C460=0;while  
  true do if (FlatIdent_C460==0) then VIP=Inst[3];Stk[A + 3 ]=Index;break;end end end elseif (Index>=Stk[A + 1 ]) then local FlatIdent_E2D0=0;while true do if (          
  FlatIdent_E2D0==0) then VIP=Inst[3];Stk[A + 3 ]=Index;break;end end end else local FlatIdent_1A6D6=0;local A;while true do if (FlatIdent_1A6D6==1) then Stk[Inst[2]]=   
  Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];FlatIdent_1A6D6=2;end if (FlatIdent_1A6D6==0) then A=nil;Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=  
  Instr[VIP];FlatIdent_1A6D6=1;end if (FlatIdent_1A6D6==2) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;FlatIdent_1A6D6=3;end if (FlatIdent_1A6D6==5 
  ) then Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];FlatIdent_1A6D6=6;end if (FlatIdent_1A6D6==3) then Inst=Instr[VIP];Stk[  
  Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];FlatIdent_1A6D6=4;end if (FlatIdent_1A6D6==7) then Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];break;end if (FlatIdent_1A6D6==6)   
  then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;FlatIdent_1A6D6=7;end if (FlatIdent_1A6D6==4) then A=Inst[2];Stk[A]=Stk[A](Unpack(Stk,A 
   + 1 ,Inst[3]));VIP=VIP + 1 ;Inst=Instr[VIP];FlatIdent_1A6D6=5;end end end elseif (Enum<=5) then if (Enum==4) then local FlatIdent_652D4=0;while true do if (             
  FlatIdent_652D4==6) then Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];break;end if (FlatIdent_652D4==0) then Stk[Inst[2]]=Env[Inst[3]];VIP=VIP  
  + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];FlatIdent_652D4=1;end if (4==FlatIdent_652D4) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];VIP=VIP 
   + 1 ;FlatIdent_652D4=5;end if (3==FlatIdent_652D4) then Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];              
  FlatIdent_652D4=4;end if (FlatIdent_652D4==5) then Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];FlatIdent_652D4=6;end if (             
  FlatIdent_652D4==2) then Inst=Instr[VIP];Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];FlatIdent_652D4=3;end if (FlatIdent_652D4==1) then VIP=VIP + 1 ; 
  Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;FlatIdent_652D4=2;end end else local A;Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];   
  Stk[Inst[2]]=Env[Inst[3]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP]; 
  Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];Stk[A]= 
  Stk[A](Unpack(Stk,A + 1 ,Inst[3]));VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];end elseif (  
  Enum>6) then local FlatIdent_82400=0;local A;while true do if (FlatIdent_82400==1) then VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];Stk[A]=Stk[A](Stk[A + 1 ]);VIP=VIP + 1 ; 
    FlatIdent_82400=2;end if (2==FlatIdent_82400) then Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];FlatIdent_82400=3 
    ;end if (FlatIdent_82400==4) then Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];Stk[A]=Stk[A](Stk[A + 1 ]);FlatIdent_82400=5;end if (     
    FlatIdent_82400==6) then Stk[Inst[2]]=Env[Inst[3]];break;end if (FlatIdent_82400==3) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 
     ;Inst=Instr[VIP];FlatIdent_82400=4;end if (FlatIdent_82400==0) then A=nil;Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][ 
      Inst[4]];FlatIdent_82400=1;end if (FlatIdent_82400==5) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]];VIP=VIP + 1 ;Inst=Instr[VIP];FlatIdent_82400=6 
      ;end end else Stk[Inst[2]]=Env[Inst[3]];end elseif (Enum<=11) then if (Enum<=9) then if (Enum==8) then local FlatIdent_104D4=0;local A;while true do if (         
      FlatIdent_104D4==5) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;FlatIdent_104D4=6;end if (FlatIdent_104D4==0) then A=nil;Stk[Inst[2]]=Stk 
        [Inst[3]];VIP=VIP + 1 ;Inst=Instr[VIP];FlatIdent_104D4=1;end if (FlatIdent_104D4==3) then Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];VIP=VIP + 1 ;Inst=Instr[VIP 
        ];FlatIdent_104D4=4;end if (2==FlatIdent_104D4) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];VIP=VIP + 1 ;FlatIdent_104D4=3;end if (4== 
        FlatIdent_104D4) then Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];FlatIdent_104D4=5;end if (FlatIdent_104D4==1) then   
          Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];FlatIdent_104D4=2;end if (FlatIdent_104D4==7) then A=    
            Inst[2];Stk[A]=Stk[A](Unpack(Stk,A + 1 ,Inst[3]));break;end if (FlatIdent_104D4==6) then Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP 
              ];FlatIdent_104D4=7;end end else local A;Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[  
                VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];Stk[A]=Stk[A](Unpack(Stk,A + 1 ,   
                  Inst[3]));VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];VIP=VIP + 1 ;    
                      Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2] 
                                  ]=Inst[3];end elseif (Enum>10) then local FlatIdent_5B743=0;local A;while true do if (0==FlatIdent_5B743) then A=Inst[2];Stk[A](  
                                      Unpack(Stk,A + 1 ,Inst[3]));break;end end else Stk[Inst[2]]();end elseif (Enum<=13) then if (Enum==12) then local             
                                      FlatIdent_4D36D=0;local A;while true do if (FlatIdent_4D36D==         1) then Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];VIP=  
                                      VIP + 1 ;FlatIdent_4D36D=2;end if (FlatIdent_4D36D==2) then           Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];   
                                      VIP=VIP + 1 ;FlatIdent_4D36D=3;end if (FlatIdent_4D36D==0)            then A=nil;Stk[Inst[2]]=Upvalues[Inst[3]];VIP=VIP + 1 
                                       ;FlatIdent_4D36D=1;end if (5==FlatIdent_4D36D) then Inst=            Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;         
                                      FlatIdent_4D36D=6;end if (FlatIdent_4D36D==3) then Inst=Instr           [VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;            
                                      FlatIdent_4D36D=4;end if (FlatIdent_4D36D==8) then VIP=VIP +            1 ;Inst=Instr[VIP];do return;end break;end if (6==  
                                      FlatIdent_4D36D) then Inst=Instr[VIP];A=Inst[2];Stk[A]=Stk[A]           (Unpack(Stk,A + 1 ,Inst[3]));FlatIdent_4D36D=7;   
                                        end if (FlatIdent_4D36D==4) then Inst=Instr[VIP];Stk[Inst[2           ]]=Inst[3];VIP=VIP + 1 ;FlatIdent_4D36D=5;end if  
                                        (FlatIdent_4D36D==7) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[             Inst[2]][Inst[3]]=Stk[Inst[4]];FlatIdent_4D36D= 
                                        8;end end else local Step;local Index;local A;Stk[Inst[2]]=             {};VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]= 
                                        Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]= #Stk[                Inst[3]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[    
                                        Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];                  Index=Stk[A];Step=Stk[A + 2 ];if (Step>0) 
                                         then if (Index>Stk[A + 1 ]) then VIP=Inst[3];else Stk[A                  + 3 ]=Index;end elseif (Index<Stk[A + 1 ] 
                                          ) then VIP=Inst[3];else Stk[A + 3 ]=Index;end end                         elseif (Enum==14) then local          
                                          FlatIdent_75084=0;local A;while true do if (                                FlatIdent_75084==3) then VIP=   
                                            VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=                          VIP + 1 ;Inst=Instr[VIP]; 
                                            Stk[Inst[2]]=Inst[3];FlatIdent_75084=4;end if (                                               
                                              FlatIdent_75084==2) then VIP=VIP + 1 ;Inst=   
                                                Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst 
                                                    [4]];VIP=VIP + 1 ;Inst=Instr[VIP];  
                                                          Stk[Inst[2]]=Inst[3];   


FlatIdent_75084=3;end if (FlatIdent_75084==4) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];FlatIdent_75084=5;end if (FlatIdent_75084==1) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]][Inst[3]]=Stk[Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];FlatIdent_75084=2;end if (FlatIdent_75084==5) then Stk[A]=Stk[A](Unpack(Stk,A + 1 ,Inst[3]));break;end if (FlatIdent_75084==0) then A=nil;Stk[Inst[2]]=Inst[3];VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];Stk[A]=Stk[A](Unpack(Stk,A + 1 ,Inst[3]));FlatIdent_75084=1;end end else local FlatIdent_7A75F=0;local A;while true do if (FlatIdent_7A75F==5) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]];VIP=VIP + 1 ;Inst=Instr[VIP];FlatIdent_7A75F=6;end if (FlatIdent_7A75F==0) then A=nil;Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];FlatIdent_7A75F=1;end if (FlatIdent_7A75F==2) then Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]];VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Env[Inst[3]];FlatIdent_7A75F=3;end if (FlatIdent_7A75F==3) then VIP=VIP + 1 ;Inst=Instr[VIP];Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];FlatIdent_7A75F=4;end if (FlatIdent_7A75F==6) then Stk[Inst[2]]=Env[Inst[3]];break;end if (FlatIdent_7A75F==4) then Stk[Inst[2]]=Stk[Inst[3]][Inst[4]];VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];Stk[A]=Stk[A](Stk[A + 1 ]);FlatIdent_7A75F=5;end if (FlatIdent_7A75F==1) then VIP=VIP + 1 ;Inst=Instr[VIP];A=Inst[2];Stk[A]=Stk[A](Stk[A + 1 ]);VIP=VIP + 1 ;FlatIdent_7A75F=2;end end e
