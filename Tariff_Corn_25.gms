$onText
Ag commodity trade model between US, China and ROW with detailed production in US
Trade year is 2014
$offText
*****************************US crop production********************************
Set c Crop types               /corn,sb,wt,srg/
    w Irrigation level          /w1*w5/
    m  Scenarios for historical crop mix /2005*2019/
    n  Scenarios for synthetic crop mix  /1*16/
    k  segment no                        /1*60000/;

Set f fertilizer level /5,10,15,25,50,75,100,125,150,200,250,300/;

Scalar aggfert aggregated N fertilizer consumed /13010/;
*2015 level from usda ers data Table 1, unit is 1000 short tons
Set cropf(c,f) allowable crop fertilizer combinations
/corn.50
 corn.100
 corn.150
 corn.200
 corn.250
 corn.300
 sb.5
 sb.10
 sb.15
 wt.25
 wt.50
 wt.75
 wt.100
 wt.125
 srg.50
 srg.100
 srg.150
 srg.200
/
*if this set does not exist, acreage is zero
*${not cropf(c,f) le }

;
*corn.50
*corn.250
*corn.300
*wt.150
*wt.175
*wt.200
*srg.200
*srg.250

Set i counties within MRB
/
$include CSWMRB.csv
/;

display i;

Set j counties outside MRB
/
$include CSOMRB.csv
/;

display j;

*$call gdxxrw.exe hist_cropmix_2788counties_inhectare_20052019.xls par=cghistwmrb rng=cornWMRB!A1:P1621
*Parameter cghistwmrb(i,m) m historical crop mix for corn by county;
*$gdxin hist_cropmix_2788counties_inhectare_20052019.gdx
*$load cghistwmrb
*$gdxin
*display cghistwmrb;


******************************************************************
***********************crop mix***********************************
***********************within MRB*********************************************
Parameter   cghistwmrb(i,m)  m historical crop mix for corn by county;
$LIBInclude xlimport cghistwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\hist_cropmix_2788counties_inhectare_20052019.xls" cornWMRB!A1:P1621
Parameter  sbhistwmrb(i,m)  m historical crop mix for sb by county;
$LIBInclude xlimport sbhistwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\hist_cropmix_2788counties_inhectare_20052019.xls" sbWMRB!A1:P1621
Parameter   whhistwmrb(i,m)  m historical crop mix for wheat by county;
$LIBInclude xlimport whhistwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\hist_cropmix_2788counties_inhectare_20052019.xls" wtWMRB!A1:P1621
Parameter   srghistwmrb(i,m)  m historical crop mix for sorghum by county;
$LIBInclude xlimport srghistwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\hist_cropmix_2788counties_inhectare_20052019.xls" srgWMRB!A1:P1621

Parameter  crophistwmrb(c,i,m)  m historical crop mix by county;
           crophistwmrb('corn',i,m)= cghistwmrb(i,m);
           crophistwmrb('sb',i,m)  =  sbhistwmrb(i,m);
           crophistwmrb('wt',i,m) =  whhistwmrb(i,m)*1.2;
           crophistwmrb('srg',i,m) =  srghistwmrb(i,m);

***********************outside MRB**************************************************
Parameter   cghistomrb(j,m)  m historical crop mix for corn by county;
$LIBInclude xlimport cghistomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\hist_cropmix_2788counties_inhectare_20052019.xls" cornOMRB!A1:P1169
Parameter  sbhistomrb(j,m)  m historical crop mix for sb by county;
$LIBInclude xlimport sbhistomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\hist_cropmix_2788counties_inhectare_20052019.xls" sbOMRB!A1:P1169
Parameter   whhistomrb(j,m)  m historical crop mix for wheat by county;
$LIBInclude xlimport whhistomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\hist_cropmix_2788counties_inhectare_20052019.xls" wtOMRB!A1:P1169
Parameter   srghistomrb(j,m)  m historical crop mix for sorghum by county;
$LIBInclude xlimport srghistomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\hist_cropmix_2788counties_inhectare_20052019.xls" srgOMRB!A1:P1169

Parameter  crophistomrb(c,j,m)  m historical crop mix by county;
           crophistomrb('corn',j,m)= cghistomrb(j,m);
           crophistomrb('sb',j,m)  =  sbhistomrb(j,m);
           crophistomrb('wt',j,m) =  whhistomrb(j,m)*1.2;
           crophistomrb('srg',j,m) =  srghistomrb(j,m);




***********************************Syn crop mix******************************
***********************within MRB*********************************************
Parameter   cgsynwmrb(i,n)  n synthetic crop mix for corn by county;
$LIBInclude xlimport  cgsynwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\SynCropmix_inhectare.xls" cornWMRB!A1:Q1621
Parameter  sbsynwmrb(i,n)  n synthetic crop mix for sb by county;
$LIBInclude xlimport sbsynwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\SynCropmix_inhectare.xls" sbWMRB!A1:Q1621
Parameter   whsynwmrb(i,n)  n synthetic crop mix for wheat by county;
$LIBInclude xlimport  whsynwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\SynCropmix_inhectare.xls" wtWMRB!A1:Q1621
Parameter   srgsynwmrb(i,n)  n synthetic crop mix for sorghum by county;
$LIBInclude xlimport srgsynwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\SynCropmix_inhectare.xls" srgWMRB!A1:Q1621

Parameter  cropsynwmrb(c,i,n)  n synthetic crop mix by county;
           cropsynwmrb('corn',i,n)= cgsynwmrb(i,n);
           cropsynwmrb('sb',i,n)  = sbsynwmrb(i,n);
           cropsynwmrb('wt',i,n) =  whsynwmrb(i,n);
           cropsynwmrb('srg',i,n) =  srgsynwmrb(i,n);

***********************outside MRB**************************************************
Parameter   cgsynomrb(j,n)  n synthetic crop mix for corn by county;
$LIBInclude xlimport cgsynomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\SynCropmix_inhectare.xls" cornOMRB!A1:Q1169
Parameter  sbsynomrb(j,n)  n synthetic crop mix for sb by county;
$LIBInclude xlimport  sbsynomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\SynCropmix_inhectare.xls" sbOMRB!A1:Q1169
Parameter   whsynomrb(j,n)  n synthetic crop mix for wheat by county;
$LIBInclude xlimport whsynomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\SynCropmix_inhectare.xls" wtOMRB!A1:Q1169
Parameter   srgsynomrb(j,n)  n synthetic crop mix for sorghum by county;
$LIBInclude xlimport srgsynomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\SynCropmix_inhectare.xls" srgOMRB!A1:Q1169

Parameter  cropsynomrb(c,j,n)  n synthetic crop mix by county;
           cropsynomrb('corn',j,n)= cgsynomrb(j,n);
           cropsynomrb('sb',j,n)  = sbsynomrb(j,n);
           cropsynomrb('wt',j,n) =  whsynomrb(j,n);
           cropsynomrb('srg',j,n) =  srgsynomrb(j,n);



***********************************************************************
*************end of crop mix*******************************************
************************************************************************



*********crop yield*****************************************
***********Within MRB baseline: only fertilizer application******************
Parameter ym(i,c) yield multiplier for calibration;
$LIBInclude xlimport ym "C:\YueluResearch\TradePaper\GAMScode_for_replication\YieldM.xls" Sheet2!a1:e1621
Parameter cgyieldwmrb(i,f) corn per ha yield by county and fertilizer level;
$LIBInclude xlimport cgyieldwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" CornYield!a1:g1621
Parameter sbyieldwmrb(i,f) soybean per ha yield by county and soil type;
$LIBInclude xlimport sbyieldwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" SBYield!a1:d1621
Parameter wtyieldwmrb(i,f) wheat per ha yield by county and soil type;
$LIBInclude xlimport wtyieldwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" WTYield!a1:f1621
Parameter srgyieldwmrb(i,f) sorghum per ha yield by county and soil type;
$LIBInclude xlimport srgyieldwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" SRGYield!a1:e1621

Parameter cropyieldwmrb(c,i,f) crop yield by county and fertilizer level;
          cropyieldwmrb('corn',i,f)=cgyieldwmrb(i,f);
          cropyieldwmrb('sb',i,f)=sbyieldwmrb(i,f);
          cropyieldwmrb('wt',i,f)=wtyieldwmrb(i,f);
          cropyieldwmrb('srg',i,f)=srgyieldwmrb(i,f);
Display cropyieldwmrb;

***********************Outside MRB*************************************
Parameter cropyieldo(j,c) per ha yield by county and crop outside mrb;
$LIBInclude xlimport cropyieldo "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" yieldforOMRB!a1:e1169
Parameter cropyieldomrb(j,c) per ha yield by county and crop outside mrb with calibration;
          cropyieldomrb(j,'corn')=cropyieldo(j,'corn')*0.595;
          cropyieldomrb(j,'sb')=cropyieldo(j,'sb')*0.81;
          cropyieldomrb(j,'wt')=cropyieldo(j,'wt')*1.04;
          cropyieldomrb(j,'srg')=cropyieldo(j,'srg')*0.71;
******************with irrigation********************
Parameter cgwco50(i,w) corn per ha yield coefficient with 50kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgwco50 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN50_yield!a1:f1621
Parameter cgwco100(i,w) corn per ha yield coefficient with 100kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgwco100 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN100_yield!a1:f1621
Parameter cgwco150(i,w) corn per ha yield coefficient with 150kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgwco150 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN150_yield!a1:f1621
Parameter cgwco200(i,w) corn per ha yield coefficient with 200kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgwco200 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN200_yield!a1:f1621
Parameter cgwco250(i,w) corn per ha yield coefficient with 250kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgwco250 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN250_yield!a1:f1621
Parameter cgwco300(i,w) corn per ha yield coefficient with 300kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgwco300 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN300_yield!a1:f1621

Parameter cgyieldirri(i,w,f) corn per ha yield with irrigation and fertilizer;
          cgyieldirri(i,w,'50')= cgyieldwmrb(i,'50')*cgwco50(i,w);
          cgyieldirri(i,w,'100')= cgyieldwmrb(i,'100')*cgwco100(i,w);
          cgyieldirri(i,w,'150')= cgyieldwmrb(i,'150')*cgwco150(i,w);
          cgyieldirri(i,w,'200')= cgyieldwmrb(i,'200')*cgwco200(i,w);
          cgyieldirri(i,w,'250')= cgyieldwmrb(i,'250')*cgwco250(i,w);
          cgyieldirri(i,w,'300')= cgyieldwmrb(i,'300')*cgwco300(i,w);

*Parameter sbwco0(i,w) soybean per ha yield coefficient with 0kg N fertilizer irrigation by county and irrigation level;
*$LIBInclude xlimport sbwco0 "H:\Research\postdoc\NSFproject\GAMSDATA\2788_irrigationsb_yieldN.xls" SB0Y!a1:f2789
Parameter sbwco5(i,w) soybean per ha yield coefficient with 5kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport sbwco5 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsb_yieldN.xls" SB5Y!a1:f1621
Parameter sbwco10(i,w) soybean per ha yield coefficient with 10kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport sbwco10 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsb_yieldN.xls" SB10Y!a1:f1621
Parameter sbwco15(i,w) soybean per ha yield coefficient with 15kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport sbwco15 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsb_yieldN.xls" SB15Y!a1:f1621
Parameter sbyieldirri(i,w,f) sb per ha yield with irrigation and fertilizer;
*sbyieldirri(i,w,'0')= sbyield(i,'0')*sbwco0(i,w);
          sbyieldirri(i,w,'5')= sbyieldwmrb(i,'5')*sbwco5(i,w);
          sbyieldirri(i,w,'10')= sbyieldwmrb(i,'10')*sbwco10(i,w);
          sbyieldirri(i,w,'15')= sbyieldwmrb(i,'15')*sbwco15(i,w);

Parameter srgwco50(i,w) sorghum per ha yield coefficient with 50kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport srgwco50 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsrg_yieldN.xls" SRG50Y!a1:f1621
Parameter srgwco100(i,w) sorghum per ha yield coefficient with 100kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport srgwco100 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsrg_yieldN.xls" SRG100Y!a1:f1621
Parameter srgwco150(i,w) sorghum per ha yield coefficient with 150kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport srgwco150 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsrg_yieldN.xls" SRG150Y!a1:f1621
Parameter srgwco200(i,w) sorghum per ha yield coefficient with 200kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport srgwco200 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsrg_yieldN.xls" SRG200Y!a1:f1621
*Parameter srgwco250(i,w) sorghum per ha yield coefficient with 250kg N fertilizer irrigation by county and irrigation level;
*$LIBInclude xlimport srgwco250 "H:\Research\postdoc\NSFproject\GAMSDATA\2788_irrigationsrg_yieldN.xls" SRG250Y!a1:f1621
Parameter srgyieldirri(i,w,f) srg per ha yield with irrigation and fertilizer;
          srgyieldirri(i,w,'50')= srgyieldwmrb(i,'50')*srgwco50(i,w);
          srgyieldirri(i,w,'100')= srgyieldwmrb(i,'100')*srgwco100(i,w);
          srgyieldirri(i,w,'150')= srgyieldwmrb(i,'150')*srgwco150(i,w);
          srgyieldirri(i,w,'200')= srgyieldwmrb(i,'200')*srgwco200(i,w);
*srgyieldirri(i,w,'250')= srgyieldwmrb(i,'250')*srgwco250(i,w);
******************wheat does not need irrigation*******************************
Parameter wtyieldirri(i,w,f) wt per ha yield with irrigation and fertilizer;
          wtyieldirri(i,'w1',f)= cropyieldwmrb('wt',i,f);
          wtyieldirri(i,'w2',f)= cropyieldwmrb('wt',i,f);
          wtyieldirri(i,'w3',f)= cropyieldwmrb('wt',i,f);
          wtyieldirri(i,'w4',f)= cropyieldwmrb('wt',i,f);
          wtyieldirri(i,'w5',f)= cropyieldwmrb('wt',i,f);


Parameter cropyieldirri(i,c,w,f) crop yield with irrigation and fertilzier by county;
          cropyieldirri(i,'corn',w,f)=cgyieldirri(i,w,f)*ym(i,"corn")*0.595;
          cropyieldirri(i,'sb',w,f)=sbyieldirri(i,w,f)*ym(i,"sb")*0.81;
          cropyieldirri(i,'wt',w,f)=wtyieldirri(i,w,f)*ym(i,"wt")*1.04;
          cropyieldirri(i,'srg',w,f)=srgyieldirri(i,w,f)*ym(i,"srg")*0.71;
display cropyieldirri;
*ym(i,"corn")*0.575
*ym(i,"sb")*0.845
*ym(i,"wt")*1.03
*ym(i,"srg")*0.685
*************end of crop yield*****************************************



*************N runoff from crop production in MRB*****************************
***********baseline: only fertilizer application******************
Parameter cgn(i,f) corn per ha N runoff by county and fertilizer level;
$LIBInclude xlimport cgn "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" CornN!a1:g1621
Parameter sbn(i,f) soybean per ha N runoff by county and soil type;
$LIBInclude xlimport sbn "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" SBN!a1:d1621
Parameter wtn(i,f) wheat per ha N runoff by county and soil type;
$LIBInclude xlimport wtn "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" WTN!a1:f1621
Parameter srgn(i,f) sorghum per ha N runoff by county and soil type;
$LIBInclude xlimport srgn "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_baseline_yieldN_fortest.xls" SRGN!a1:e1621


******************with irrigation********************
Parameter cgnwco50(i,w) corn per ha N runoff coefficient with 50kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgnwco50 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN50_N!a1:f1621
Parameter cgnwco100(i,w) corn per ha N runoff coefficient with 100kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgnwco100 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN100_N!a1:f1621
Parameter cgnwco150(i,w) corn per ha N runoff coefficient with 150kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgnwco150 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN150_N!a1:f1621
Parameter cgnwco200(i,w) corn per ha N runoff coefficient with 200kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgnwco200 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN200_N!a1:f1621
Parameter cgnwco250(i,w) corn per ha N runoff coefficient with 250kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgnwco250 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN250_N!a1:f1621
Parameter cgnwco300(i,w) corn per ha N runoff coefficient with 300kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport cgnwco300 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationcorn_yieldN.xls" CornN300_N!a1:f1621

Parameter cgnirri(i,w,f) corn per ha N runoff with irrigation and fertilizer;
          cgnirri(i,w,'50')= cgn(i,'50')*cgnwco50(i,w);
          cgnirri(i,w,'100')= cgn(i,'100')*cgnwco100(i,w);
          cgnirri(i,w,'150')= cgn(i,'150')*cgnwco150(i,w);
          cgnirri(i,w,'200')= cgn(i,'200')*cgnwco200(i,w);
          cgnirri(i,w,'250')= cgn(i,'250')*cgnwco250(i,w);
          cgnirri(i,w,'300')= cgn(i,'300')*cgnwco300(i,w);

Parameter sbnwco5(i,w) soybean per ha N runoff coefficient with 5kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport sbnwco5 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsb_yieldN.xls" SB5N!a1:f1621
Parameter sbnwco10(i,w) soybean per ha N runoff coefficient with 10kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport sbnwco10 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsb_yieldN.xls" SB10N!a1:f1621
Parameter sbnwco15(i,w) soybean per ha N runoff coefficient with 15kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport sbnwco15 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsb_yieldN.xls" SB15N!a1:f1621
Parameter sbnirri(i,w,f) sb per ha N runoff with irrigation and fertilizer;
          sbnirri(i,w,'5')= sbn(i,'5')*sbnwco5(i,w);
          sbnirri(i,w,'10')= sbn(i,'10')*sbnwco10(i,w);
          sbnirri(i,w,'15')= sbn(i,'15')*sbnwco15(i,w);

Parameter srgnwco50(i,w) sorghum per ha N runoff coefficient with 50kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport srgnwco50 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsrg_yieldN.xls" SRG50N!a1:f1621
Parameter srgnwco100(i,w) sorghum per ha N runoff coefficient with 100kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport srgnwco100 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsrg_yieldN.xls" SRG100N!a1:f1621
Parameter srgnwco150(i,w) sorghum per ha N runoff coefficient with 150kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport srgnwco150 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsrg_yieldN.xls" SRG150N!a1:f1621
Parameter srgnwco200(i,w) sorghum per ha N runoff coefficient with 200kg N fertilizer irrigation by county and irrigation level;
$LIBInclude xlimport srgnwco200 "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationsrg_yieldN.xls" SRG200N!a1:f1621
*Parameter srgnwco250(i,w) sorghum per ha N runoff coefficient with 250kg N fertilizer irrigation by county and irrigation level;
*$LIBInclude xlimport srgnwco250 "H:\Research\postdoc\NSFproject\GAMSDATA\2788_irrigationsrg_yieldN.xls" SRG250N!a1:f1621
Parameter srgnirri(i,w,f) srg per ha N runoff with irrigation and fertilizer;
          srgnirri(i,w,'50')= srgn(i,'50')*srgnwco50(i,w);
          srgnirri(i,w,'100')= srgn(i,'100')*srgnwco100(i,w);
          srgnirri(i,w,'150')= srgn(i,'150')*srgnwco150(i,w);
          srgnirri(i,w,'200')= srgn(i,'200')*srgnwco200(i,w);
*srgnirri(i,w,'250')= srgn(i,'250')*srgnwco250(i,w);

parameter wtnirri(i,w,f) wt per ha N runoff with irrgation and fertilizet;
          wtnirri(i,'w1',f)=1*wtn(i,f);
          wtnirri(i,'w2',f)=1*wtn(i,f);
          wtnirri(i,'w3',f)=1*wtn(i,f);
          wtnirri(i,'w4',f)=1*wtn(i,f);
          wtnirri(i,'w5',f)=1*wtn(i,f);

Parameter cropirrin(i,c,w,f) crop N runoff with irrigation by counties;
          cropirrin(i,'corn',w,f)= cgnirri(i,w,f);
          cropirrin(i,'sb',w,f)=  sbnirri(i,w,f);
          cropirrin(i,'wt',w,f)=  wtnirri(i,w,f);
          cropirrin(i,'srg',w,f)= srgnirri(i,w,f);

***********end of N runoff******************************************************


****************Irrigation level************************************************
Parameter cgirridep(i,f) corn optimal irrigation depth(mm) by N fertilizer level and counties;
$LIBInclude xlimport cgirridep "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationdepth_fortest_allF.xls" corn!a1:f1621
Parameter sbirridep(i,f) soybean optimal irrigation depth(mm) by N fertilizer level and counties;
$LIBInclude xlimport sbirridep "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationdepth_fortest_allF.xls" sb!a1:d1621
Parameter srgirridep(i,f) sorghum optimal irrigation depth(mm) by N fertilizer level and counties;
$LIBInclude xlimport srgirridep "C:\YueluResearch\TradePaper\GAMScode_for_replication\2788_irrigationdepth_fortest_allF.xls" srg!a1:f1621
Parameter cropwu(i,c,f) crop water use by ocunties and fertilizer level;
          cropwu(i,'corn',f)= cgirridep(i,f);
          cropwu(i,'sb',f) = sbirridep(i,f);
          cropwu(i,'wt',f)=0;
          cropwu(i,'srg',f)= srgirridep(i,f);

Parameter cowu(w) crop water use coefficient;
          cowu('w1')=0;
          cowu('w2')=0.25;
          cowu('w3')=0.5;
          cowu('w4')=0.75;
          cowu('w5')=1;
*****************************END of irrigation*****************************************

****************************************************************************
**************crop cost*****************************************************
****************************************************************************
*This section includes fertilizer cost, water cost and total other costs for crop production, per ha basis.
Scalar fcost per kg nitrogen fertilizer costs in 2014 /1.32/;
*national-level per kg N costs, obatained from ERS fertilizer data, which is only available up to 2014, N in 2018$ is calcualted from fertilizer index
Parameter flcost(f) per ha level fertilizer costs by various levels;
          flcost('5')=5*fcost;
          flcost('10')=10*fcost;
          flcost('15')=15*fcost;
          flcost('25')=25*fcost;
          flcost('50')=50*fcost;
          flcost('75')=75*fcost;
          flcost('100')=100*fcost;
          flcost('125')=125*fcost;
          flcost('150')=150*fcost;
*flcost('175')=175*fcost;
          flcost('200')=200*fcost;
          flcost('250')=250*fcost;
          flcost('300')=300*fcost;
Display flcost;

Parameter flevel(f) per ha fertilizer level (kg);
          flevel('5')=5;
          flevel('10')=10;
          flevel('15')=15;
          flevel('25')=25;
          flevel('50')=50;
          flevel('75')=75;
          flevel('100')=100;
          flevel('125')=125;
          flevel('150')=150;
*flevel('175')=175;
          flevel('200')=200;
          flevel('250')=250;
          flevel('300')=300;

Parameter pcost(c) per ha P & K fertilizer cost;
*https://farmdocdaily.illinois.edu/2017/07/fertilizer-costs-in-2017-and-2018.html
*2017, P: 425 $/ton=0.425$/kg;
*SWAT sets: 0.425$/kg with 17kg/ha for corn, 3kg/ha for sb, 7kg/ha for wt, 16kg/ha for srg
*No Potash level in SWAT
         pcost('corn')=7.23;
         pcost('sb')=1.28;
         pcost('wt')=2.98;
         pcost('srg')=6.8;


Parameter flcostomrb(j,c) per ha level fertilizer costs for counties outside MRB;
$LIBInclude xlimport flcostomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\FC_2788counties_2014.xls" OMRB!A1:E1169


Parameter wcostwmrb(i,c)  water costs by crops and counties per ha (mean value over years) for counties within MRB;
*water cost data obatined from usda ers, the original unit is $/planted acre, which is converted into $/ planted ha
*the water cost data is independent of the optimal irrigation depth
$LIBInclude xlimport wcostwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\WC_2788counties_2014.xls" WMRB!A1:E1621

Parameter wlcostwmrb(w,i,c) water costs by water level per ha counties within MRB;
          wlcostwmrb('w1',i,c)= wcostwmrb(i,c)*0;
          wlcostwmrb('w2',i,c)= wcostwmrb(i,c)*0.25;
          wlcostwmrb('w3',i,c)= wcostwmrb(i,c)*0.5;
          wlcostwmrb('w4',i,c)= wcostwmrb(i,c)*0.75;
          wlcostwmrb('w5',i,c)= wcostwmrb(i,c)*1;

Parameter wcostomrb(j,c)  water costs by crops and counties per ha (mean value over years) for counties outsie MRB;
*water cost data obatined from usda ers, the original unit is $/planted acre, which is converted into $/ planted ha
*the water cost data is independent of the optimal irrigation depth
$LIBInclude xlimport wcostomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\WC_2788counties_2014.xls" OMRB!A1:E1621

Parameter ccostwmrb(i,c) crop costs exclude fertilizer and water and land by county within MRB;
$LIBInclude xlimport ccostwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\TC_noflw_2788counties_2014.xls" WMRB!A1:E1621

Parameter ccostomrb(j,c) crop costs exclude fertilizer and water and land by county outside MRB;
$LIBInclude xlimport ccostomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\TC_noflw_2788counties_2014.xls" OMRB!A1:E1169

Parameter ecostwmrb(i,c) crop energy costs within MRB;
$LIBInclude xlimport ecostwmrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\EnergyCost2014.xls" WMRB!A1:E1621

Parameter ecostomrb(j,c) crop energy costs outside MRB;
$LIBInclude xlimport ecostomrb "C:\YueluResearch\TradePaper\GAMScode_for_replication\EnergyCost2014.xls" OMRB!A1:E1169

Scalar ecm energy cost multiplier /1/;
Scalar fcm fertilizer cost multiplier for counties outside the MRB /1/;

*********************************************************************************
**********************end of costs***********************************************
*********************************************************************************


Set dr delivery ratio set /dr1/
Parameter deliveryratio(i,dr) delivery ratio at the county level;
$LIBInclude xlimport deliveryratio "C:\YueluResearch\TradePaper\GAMScode_for_replication\DR_county.xls" SWATDR2!A1:B1621





************************************End of US production*****************************************************************************


************************Trade Part***************************************************
SETS  source    SUPPLY SOURCE LOCATIONS
                /us,china,row/
      market   DEMAND MARKETS
               /us,china,row/
      there(market,source) SET WHICH MATCHES MARKETS
              /us.us,china.china,row.row/
      exclude(source)  SET WHICH EXCLUDE SOURCE
              /us/
;

*****************US Demand elasticity*************************************************
*******************year:2014*********************************************************

Parameter de(c)  US crop demand elasticity;
          de('corn')= -0.28;
*corn price elasticity of demand for feed,  Westcott, P. C., & Hoffman, L. A. (1999). Price determination for corn and wheat: the role of market factors and government programs (No. 1488-2016-123383).
          de('sb')= -0.29;
*the price elasticity of domestic demand for USA soybeans, Piggott, N. E., & Wohlgenant, M. K. (2002). Price elasticities, joint products, and international trade. Australian Journal of Agricultural and Resource Economics, 46(4), 487-500.
          de('wt')= -0.34;
*wheat price elasticity of demand, Westcott, P. C., & Hoffman, L. A. (1999). Price determination for corn and wheat: the role of market factors and government programs (No. 1488-2016-123383).
          de('srg')= -0.3;
*Ishida, K., & Jaime, M. (2015). A Partial Equilibrium of the Sorghum Markets in US, Mexico, and Japan (No. 330-2016-13894, pp. 1-1).
Parameter export(c) USDA export by crop (metric ton);
          export('corn')= 47421000;
          export('sb')  = 50143000;
          export('wt')  = 23518000;
          export('srg') = 8935000;
Parameter import(c) USDA import by crop (metric ton);
          import('corn')= 804000;
          import('sb')  = 904000;
          import('wt')  = 4117000;
          import('srg') = 10000;

Parameter dcrop(c) USDA demand quantity total consumption (metric ton);
   dcrop('corn')= 301792000;
   dcrop('sb')=  54955000;
   dcrop('wt')=  31334000;
   dcrop('srg')= 2459000;


Parameter pcrop(c) USDA crop price received by farmers (metric ton) in 2014;
*from usda nass quick stat
          pcrop('corn')= 146;
          pcrop('sb')= 371;
          pcrop('wt')= 220;
          pcrop('srg')= 142;
*pcrop('srg')= 146;
*all prices are converted into $/metric ton
Parameter b(c) slope of the demand curve;
          b(c)=pcrop(c)/(de(c)*dcrop(c));
Display b;
Parameter a(c) intercept of the demand curve;
          a(c)=pcrop(c)-b(c)*dcrop(c);
Display a;

****************end of demand elasticity***************************************
***********China demand***********************
Parameter cexport(c) China export by crop (metric ton);
          cexport('corn')= 13000;
          cexport('sb')= 143000;
          cexport('wt')= 803000;
          cexport('srg')= 9000;
Parameter cimport(c) China import by crop (metric ton);
          cimport('corn')= 5516000;
          cimport('sb')= 78350000;
          cimport('wt')=  1926000;
          cimport('srg')= 10162000;
Parameter cdcrop(c) China demand quantity (metric ton) total consumption;
          cdcrop('corn')=  201560920;
          cdcrop('sb')= 67180882;
          cdcrop('wt')= 116500000;
          cdcrop('srg')= 12900000;

Parameter cde(c)  China crop demand elasticity;
*corn and wheat demand elasticity are from Zhuang, R., & Abbott, P. (2007). Price elasticities of key agricultural commodities in China. China Economic Review, 18(2), 155-169.
*soybean is from Chen, W., Marchant, M. A., & Muhammad, A. (2012). China's soybean product imports: an analysis of price effects using a production system approach. China Agricultural Economic Review.
          cde('corn')= -0.329;
          cde('sb')= -0.5091;
          cde('wt')= -0.244;
          cde('srg')= -0.36;
*sorghum from other grains Table A5, Global Drivers of Agricultural Demand and Supply, USDA ERS

Parameter cpcrop(c) China crop price in 2014 (metric ton);
*soybean and wheat price from Yi et al. (2018) Environmental Research Letter, 1usd=6.5cny
*sorghum price from FAOSTAT year 2013 is 403, the price index in 2013 and 2014 is 116.68 and 113.69, hence price in 2014 is 403/116.68*113.69= 393
*corn price from FAOSTAT maize price 2014 442
*corn price Yi et al (2018) 250; in FAO IS 442
          cpcrop('corn')= 250;
*cpcrop('sb')= 870;
          cpcrop('sb')= 538;
          cpcrop('wt')= 250;
*cpcrop('wt')= 377;
          cpcrop('srg')= 393;
*cpcrop('wt')= 250;
*cpcrop('srg')= 393;
*all prices are converted into $/metric ton
Parameter cb(c) slope of the demand curve;
          cb(c)=cpcrop(c)/(cde(c)*cdcrop(c));
Display cb;
Parameter ca(c) intercept of the demand curve;
          ca(c)=cpcrop(c)-cb(c)*cdcrop(c);
Display ca;




********************ROW demand**************************
Parameter rexport(c) ROW export by crop (metric ton);
          rexport('corn')= 141797000-export('corn')-cexport('corn');
          rexport('sb')= 126218000-export('sb')-cexport('sb');
          rexport('wt')= 164421000-export('wt')-cexport('wt');
          rexport('srg')= 12165000-export('srg')-cexport('srg');
Parameter rimport(c) ROW import by crop (metric ton);
          rimport('corn')= 141797000-import('corn')-cimport('corn');
          rimport('sb')= 126218000-import('sb')-cimport('sb');
          rimport('wt')=  164421000-import('wt')-cimport('wt');
          rimport('srg')= 12165000-import('srg')-cimport('srg');
Parameter rdcrop(c) ROW demand quantity (metric ton) total consumption -us-china;
   rdcrop('corn')= 526162966;
   rdcrop('sb')=   179807863;
   rdcrop('wt')=   583548113;
   rdcrop('srg')=  52431000;
Parameter rde(c)  ROW crop demand elasticity;
*corn, soybean demand elasticity from Roberts and Schlenker (2013) AER
*soybean -0.34 from The Fapri modeling system at CARD a documentation summary
*wheat from Sarris, A. H., & Freebairn, J. (1983). Endogenous price policies and international wheat prices. American Journal of Agricultural Economics, 65(2), 214-224.
*sorghum Bredahl, M. E., Meyers, W. H., & Collins, K. J. (1979). The elasticity of foreign demand for US agricultural products: the importance of the price transmission elasticity. American Journal of Agricultural Economics, 61(1), 58-63.
         rde('corn')= -0.271;
         rde('sb')= -0.34;
         rde('wt')= -0.25;
         rde('srg')= -0.29;

Parameter rpcrop(c) ROW crop price in 2014 per metric ton;
*soybean & sorghum price, world bank https://www.worldbank.org/en/research/commodity-markets
*wheat US HRW price, world bank https://www.worldbank.org/en/research/commodity-markets
*corn price is maize price, world bank  https://www.worldbank.org/en/research/commodity-markets
          rpcrop('corn')=193;
          rpcrop('sb')= 485;
          rpcrop('wt')= 285;
          rpcrop('srg')= 210;
*rpcrop('wt')= 245;
*rpcrop('srg')= 210;
*all prices are converted into $/metric ton
Parameter rb(c) ROW slope of the demand curve;
          rb(c)=rpcrop(c)/(rde(c)*rdcrop(c));
Display rb;
Parameter ra(c) ROW intercept of the demand curve;
          ra(c)=rpcrop(c)-rb(c)*rdcrop(c);
Display ra;


TABLE   tflow(c,source,market)   NET Trade Flow FROM EACH SOURCE TO EACH MARKET per metric ton
*COMTRADE for trade between US, China, ROW
*domestic flow is from usda, if a net exporter, use total consumption-import, if a net importer, use total consumption
*https://www.agmrc.org/renewable-energy/renewable-energy-climate-change-report/renewable-energy-climate-change-report/july-2017-report/us-corn-exports-to-china-significant-impact-from-new-chinese-ag-and-trade-policies
*trade flow within the county = total consumption - import
*GTAP DATA us to china export
                    us        china        row
corn.us        301792000     299062        34786160
corn.china     0             196484000     0
corn.row       0             2279393       476971000
sb.us          54051000      24259092      13957582
sb.china       0             12154000      0
sb.row         0             46869049      160926000
wt.us          27217000      613776        20344594
wt.china       0             114574000     0
wt.row         0             2356515       557905000
srg.us         2459000       4786905       639359
srg.china      0             2738000       0
srg.row        0             979005        49862000
;

*54051000

TABLE   tcost(c,source,market)   TRANSPORTATION COST FROM EACH SOURCE TO EACH MARKET per metric ton
*20% of destination autarky equilibrium prices
                       us       china      row
      corn.us          0         43         56
      sb.us            0        282         76
      wt.us            0         75         70
      srg.us           0        216         43
      corn.china      22         0          56
      sb.china       4.4         0          76
      wt.china         0         0          70
      srg.china        0         0          43
      corn.row        22         43          0
      sb.row         4.4        282          0
      wt.row           0         75          0
      srg.row          0        216          0
;
*use the price difference as the transportation cost
*us     china    row
*us           0      108     134
*china        108      0      162
*row         134     162      0


TABLE   tcga(c,source,market)   calibrated transaction costs per metric ton
*20% of market prices in desination
                  us           china         row
corn.us           0             50           49
corn.china        29             0           49
corn.row          29            50            0
sb.us              0           107           97
sb.china          74             0           97
sb.row            74           107            0
wt.us              0            50           57
wt.china          44             0           57
wt.row            44            50            0
srg.us             0            79           42
srg.china         32             0           42
srg.row           32            79            0
;

*us        china      row
*corn.us          0        368        368
*corn.china      271        0         271
*corn.row        393       393         0
*sb.us            0         0          0
*sb.china        568        0         568
*sb.row          318       318         0
*wt.us            0        780        780
*wt.china        181        0         181
*wt.row          530       530         0
*srg.us           0        397        397
*srg.china       225        0         225
*srg.row         287       287         0
;



*us to china soybean table 3 in https://cait.rutgers.edu/wp-content/uploads/2018/03/usda-report-final_transportation-cost-modeling-of-international-containerized-soybean.pdf
*the average value of total 5 route in table 3, (74.76+107.91+114.63+114.83+128.92)/5=$108 per metric ton
*us to row is used us to rotterdam table 5, (112.46+132.8+135.37+145.07+145.62)/5=$134 per metric ton
*row to china and china to row is brazil to china, table 1 https://www.ams.usda.gov/services/transportation-analysis/brazil-datasets
*use brazil gdp deflator to convert average cost in 2019 to 2014
*(112.92+58.99+101.25+70.98)/4=86.04 in 2019, gdp deflator in 2014 and 2019 is 7.9 and 4.2. Hence $161.8 per metric ton

PARAMETERS
       limits(c,source) QUOTAS ON OUTGOING SHIPMENTS;
       limits(c,source) = 99999.;


Table subtax(c,source,market) SUBSIDIES OR TAXES ON OUTGOING SHIPMENTS
                 us     china   row
corn.us           0      50       0
corn.china        0     -70       0
corn.row          0      23       0
sb.us             0       0       0
sb.china          0       0       0
sb.row            0       0       0
wt.us             0       0       0
wt.china          0       0       0
wt.row            0       0       0
srg.us            0       0       0
srg.china         0       0       0
srg.row           0       0       0
;


**************China and ROW supply in 2014****************************
Parameter cscrop(c) China supply quantity (metric ton) production;
          cscrop('corn')= 215646000 ;
          cscrop('sb')=    12154000;
          cscrop('wt')=   126208000;
          cscrop('srg')=    2885000;

Parameter cse(c)  China crop supply elasticity;
* wheat supply elasticity from  Zhuang, R., & Abbott, P. (2007). Price elasticities of key agricultural commodities in China. China Economic Review, 18(2), 155-169.
*corn supply elasticity from Yu, B., Liu, F., & You, L. (2012). Dynamic agricultural supply response under economic transformation: a case study of Henan, China. American Journal of Agricultural Economics, 94(2), 370-376.
*soybean use The FAPRI Modeling System at CARD: A Documentation Summary
*sorghum Roberts and Schelenker (2013) AER Table 1 column 2b
          cse('corn')= 0.23;
          cse('sb')= 0.12;
          cse('wt')= 0.044;
          cse('srg')= 0.112;

Parameter z(c) China crop supply slope;
          z(c)=cpcrop(c)/(cse(c)*cscrop(c));

Parameter x(c) China crop supply intercept;
          x(c)=cpcrop(c)-z(c)*cscrop(c);


Parameter rscrop(c) ROW supply quantity (metric ton) production world-us-china;
          rscrop('corn')= 437283000;
*1014020000 -361091000-cscrop('corn');
          rscrop('sb')= 200748000;
*319780000-106878000-cscrop('sb');
          rscrop('wt')=546901000;
*728256000-55147000-cscrop('wt');
          rscrop('srg')=51547000;
*65420000-10988000-cscrop('srg');

Parameter rse(c)  ROW crop supply elasticity;
* soybean short-run supply elasticity from  Iqbal, M. Z., & Babcock, B. A. (2018). Global growing©\area elasticities of key agricultural crops estimated using dynamic heterogeneous panel methods. Agricultural Economics, 49(6), 681-690.
*soybean use The FAPRI Modeling System at CARD: A Documentation Summary
*sorghum Roberts and Schelenker (2013) AER Table 1 column 2b
*wheat from Sarris, A. H., & Freebairn, J. (1983). Endogenous price policies and international wheat prices. American Journal of Agricultural Economics, 65(2), 214-224.
*corn supply elasticity from Karp, L. S., & McCalla, A. F. (1983). Dynamic games and international trade: An application to the world corn market. American Journal of Agricultural Economics, 65(4), 641-650.
         rse('corn')= 0.1;
          rse('sb')= 0.19;
          rse('wt')= 0.035;
          rse('srg')= 0.112;

Parameter g(c) ROW crop supply slope;
          g(c)=rpcrop(c)/(rse(c)*rscrop(c));

Parameter h(c) ROW crop supply intercept;
          h(c)=rpcrop(c)-g(c)*rscrop(c);


****************************End of Trade Setting********************************

**************************grid linearization*************************************
************US*************************
Parameter qbar(k,c) qbar for quantity segments;
$LIBInclude xlimport qbar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridCS.xls" qbar!A1:E60001
Parameter ybar(k,c) ybar for consumer surplus segments;
$LIBInclude xlimport ybar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridCS.xls" CS2014!A1:E60001

************************CHINA********************************
Parameter cbar(k,c) cbar for demand quantity segments;
$LIBInclude xlimport cbar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridCSChina.xls" cbar!A1:E60001
Parameter xbar(k,c) xbar for consumer surplus segments;
$LIBInclude xlimport xbar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridCSChina.xls" CS!A1:E60001
Parameter gbar(k,c) gbar for supply quantity segments;
$LIBInclude xlimport gbar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridPSChina.xls" cbar!A1:E60001
Parameter pbar(k,c) pbar for producer surplus segments;
$LIBInclude xlimport pbar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridPSChina.xls" PS!A1:E60001
************************ROW**********************************
Parameter abar(k,c) abar for demand quantity segments;
$LIBInclude xlimport abar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridCSROW.xls" rbar!A1:E60001
Parameter dbar(k,c) dbar for consumer surplus segments;
$LIBInclude xlimport dbar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridCSROW.xls" CS!A1:E60001
Parameter ebar(k,c) ebar for supply quantity segments;
$LIBInclude xlimport ebar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridPSROW.xls" rbar!A1:E60001
Parameter fbar(k,c) fbar for producer surplus segments;
$LIBInclude xlimport fbar "C:\YueluResearch\TradePaper\GAMScode_for_replication\GridPSROW.xls" PS!A1:E60001
**********END of Grid linearization*******************************************************************






VARIABLES
CSPS                   TOTAL CONSUMERS AND PRODUCERS SURPLUS
SHIPMENTS(c,source,market) AMOUNT SHIPPED OVER A TRANPORT ROUTE
*TC(c,source,market)       TRANSACTION COSTS FOR CALIBRATION
SUPPLY(c,source)           QUANTITY AVAILABLE AT EACH SOURCE
DEMAND(c,market)           QUANTITY REQUIRED BY DEMAND MARKET
ALLCROPHA(c,i,f,w) all crop acreages
*SURPLUS            OBJ value
CSGRID(c)          Consumer surplus grid by crop
TOTCOST(c)         Total production cost by crop
TOTHA(c)           Total ha by crop
CROPHA(c,i,f,w)    Crop ha by county fertilizer and water level within MRB
CROPHAO(j,c)       Crop ha by county outside MRB
OUT(c,i,f)
OUT2(i)
OUT3(i)
OUT4(i,c)
OUT5(j,c)
OUT6(i)
OUT7(c,i,w)
SCROP(c)           Supply quantity (metric ton)
TOTCROPW(c,f)      Total crop produced within MRB (metric ton)
TOTCROPHAW(c)      Total crop ha within MRB by crop
TOTCROPHAWCOUNTY(i,c)     Total crop ha within MRB by crop  by county
TOTCROPO(c)        Total crop produced outside MRB (metric ton)
TOTCROPHAO(c)       Total crop ha ouside MRB by crop
CROPCOSTW(c)       Total other cost within MRB
TOTFCW(c)          Total fertilizet cost within MRB
TOTFCTCW           Total fertilizer cost for all crops within MRB
TOTFW(i)           Total fertilizer use by county
TOTFERTLEVEL       Total fertilizer level within MRB
TOTWCW(c)          Total water costs within MRB
CROPCOSTO(c)        Total other cost outside MRB
TOTFCO(c)          Total fertilizet cost outside MRB
TOTFCTCO           Total fertilizer cost for all crops outside MRB
TOTWCO(c)          Total water costs outside MRB
TOTCROPN(c)         Total N runoff by crop within MRB by crop
TOTCROPNGULF(c)     Total N runoff in the Gulf of Mexico from MRB by crop
TOTNGULF             Total N runoff in the Gulf of Mexico from MRB
TOTNGULFCOUNTY(i)          County-level N to the Gulf
TOTN(i)              County-level local N runoff
TOTWATER            Total water use within MRB
TAO(m,i)           Weights for the mth historical crop mix wihtin MRB
GAMMA(n,i)         Weights for the nth synthetic crop mix  within MRB
ROU(m,j)           Weights for the mth historical crop mix outside MRB
SU(n,j)            Weights for the nth synthetic crop mix outside MRB
;

Positive variables
SHIPMENTS,SUPPLY,DEMAND,SALE,SCROP,CROPHA,CROPHAO,TAO,GAMMA,ROU,SU;

SOS2 variables LAMBDA(c,k)        Grid weights for US demand
               ALPHA(c,k)         Grid weights for CHINA demand
               BETA(c,k)          Grid weights for CHINA supply
               THETA(c,k)         Grid weights for ROW demand
               DELTA(c,k)         Grid weights for ROW supply
;


Equations

TSURP           TOTAL SURPLUS EQUATION
REROWUS(c)      reference row US
CONUS(c)        The sum of lambda less than 1
REROWCHD(c)     CHINA DEMAND reference row
CONCHD(c)       CHINA DEMAND The sum of ALPHA less than 1
REROWCHS(c)     CHINA SUPPLY reference row
CONCHS(c)       CHINA SUPPLY  The sum of BETA less than 1
REROWRD(c)      ROW DEMAND reference row
CONRD(c)        ROW DEMAND The sum of THETA less than 1
REROWRS(c)      ROW SUPPLY reference row
CONRS(c)        ROW SUPPLY  The sum of DELTA less than 1
SUPPLYUS(c)
SUPPLYE(c,source)         LIMIT ON SUPPLY AVAILABLE AT A SOURCE
DEMANDE(c,market)         MINIMUM REQUIREMENT AT A DEMAND MARKET
*TCCALIBRATION(c,source,market) TRANSACTION COST EQUARION FOR CALIBRATION
*QUOTA(c,source)           OUTGOING SHIPMENT QUOTA BY SOURCE
*WELOBJECTIVE  Social welfare
*CHIMPORT1(c,source,market) China import constraints corn
*CHIMPORT2(c,source,market) China import constraints soybean
*CHIMPORT3(c,source,market) China import constraints wheat
*CHIMPORT4(c,source,market) China import constraints sorghum
SUPPLYCONS(c)  Total supply cannot exceed total production
TOTCOSTQ(c)    Total costs for crop production
CROPHAQ(c,i,f,w) considered crop acreage
NOCROPHAQ(c,i,f,w)  not considered crop acreage equals zero
TOTHAQ(c)      Total ha by crop

TOTCROPWQ(c,f)  Total produced quantity within MRB by crop
TOTCROPHAWQ(c)   Total crop ha within MRB bycrop
TOTCROPHAWCOUNTYQ(i,c)     Total crop ha within MRB bycrop  by county
CROPCOSTWQ(c)   Total production costs within MRB by crop
TOTFCWQ(c)      Total fertilizer costs within MRB by crop
TOTFCTCWQ        Total fertilizer costs within MRB
TOTFWQ(i)          Total fertilizer use by county
TOTFERTLEVELQ    Total fertilizer level within MRB
TOTWCWQ(c)      Total water costs within MRB by crop
CROPMIXW(c,i)   Historical crop mix constraint within MRB
CMCONVEXW(i)    Convex combination within MRB
TOTCROPNQ(c)    Local total N runoff
TOTCROPNGULFQ(c) Total N runoff in the Gulf of Mexico
TOTNGULFCOUNTYQ(i)
TOTNQ(i)
TOTNGULFQ
TOTWATERQ
*TOTFCQ   Total fertilizer cost for the entire united states

TOTCROPOQ(c)    Total produced quantity outside MRB by crop
TOTCROPHAOQ(c)  Total crop ha ousdie MRB by crop
CROPCOSTOQ(c)   Total production costs outside MRB by crop
TOTFCOQ(c)      Total fertilizer costs outside MRB by crop
TOTFCTCOQ        Total fertilizer costs outside MRB
TOTWCOQ(c)      Total water costs outside MRB by crop
CROPMIXO(c,j)   Historical crop mix constraint outside MRB
CMCONVEXO(j)    Convex combination outside MRB
;



TSURP..  CSPS =E= SUM((k,c),LAMBDA(c,k)*ybar(k,c))-SUM(c,TOTCOST(c))
*                 US part
                 +SUM((k,c),ALPHA(c,k)*xbar(k,c))-SUM((k,c),BETA(c,k)*pbar(k,c))
*                  CHINA part
                 +SUM((k,c),THETA(c,k)*dbar(k,c))-SUM((k,c),DELTA(c,k)*fbar(k,c))
*                  ROW part
                 -SUM((c,source,market),SHIPMENTS(c,source,market)*(tcga(c,source,market)+subtax(c,source,market)));
*                  Transportation cost
*+subtax(c,source)$(NOT THERE(market,source))
REROWUS(c)..DEMAND(c,'US') =E= SUM(k,LAMBDA(c,k)*qbar(k,c));
CONUS(c).. SUM(k,LAMBDA(c,k))=L=1;
REROWCHD(c)..DEMAND(c,'CHINA') =E= SUM(k,ALPHA(c,k)*cbar(k,c));
CONCHD(c)..SUM(k,ALPHA(c,k))=L=1;
REROWCHS(c)..SUPPLY(c,'CHINA') =E= SUM(k,BETA(c,k)*gbar(k,c));
CONCHS(c)..SUM(k,BETA(c,k))=L=1;
REROWRD(c)..DEMAND(c,'ROW') =E= SUM(k,THETA(c,k)*abar(k,c));
CONRD(c)..SUM(k,THETA(c,k))=L=1;
REROWRS(c)..SUPPLY(c,'ROW') =E= SUM(k,DELTA(c,k)*ebar(k,c));
CONRS(c)..SUM(k,DELTA(c,k))=L=1;


SUPPLYUS(c)..SUPPLY(c,'us')=E=SCROP(c);


********************balance****************************************
DEMANDE(c,market)..  DEMAND(c,market)-SUM(source,SHIPMENTS(c,source,market)) =L= 0;

SUPPLYE(c,source).. -SUPPLY(c,source)+SUM(market,SHIPMENTS(c,source,market)) =L= 0;
*TCCALIBRATION(c,source,market)..SHIPMENTS(c,source,market)=E= tflow(c,source,market);

*QUOTA(c,source)..    SUM(market$(NOT THERE(market,source)) ,SHIPMENTS(c,source,market)) =L= LIMITS(c,source);
*CHIMPORT1(c,source,market).. SHIPMENTS('corn','us','china')=L=tflow('corn','us','china');
*CHIMPORT2(c,source,market).. SHIPMENTS('sb','us','china')=L=tflow('sb','us','china');
*CHIMPORT3(c,source,market).. SHIPMENTS('wt','us','china')=L=tflow('wt','us','china');
*CHIMPORT4(c,source,market).. SHIPMENTS('srg','us','china')=L=tflow('srg','us','china');


****************************US production part******************************
*********************aggregate*****************************************
SUPPLYCONS(c)..SUM(f,TOTCROPW(c,f))+TOTCROPO(c)-SCROP(c)=G=0;
TOTCOSTQ(c)..TOTCOST(c)=E=CROPCOSTW(c)+TOTFCW(c)+TOTWCW(c)+CROPCOSTO(c)+TOTFCO(c)+TOTWCO(c);
CROPHAQ(c,i,f,w)..CROPHA(c,i,f,w)=E=ALLCROPHA(c,i,f,w)$cropf(c,f);
NOCROPHAQ(c,i,f,w)..ALLCROPHA(c,i,f,w)$(not cropf(c,f))=E=0;
TOTHAQ(c)..TOTHA(c)=E=SUM((i,w,f),CROPHA(c,i,f,w))+SUM(j,CROPHAO(j,c));


******within MRB part******************** ************************
TOTCROPWQ(c,f).. TOTCROPW(c,f)=E=SUM((i,w),CROPHA(c,i,f,w)*cropyieldirri(i,c,w,f));
TOTCROPHAWQ(c)..TOTCROPHAW(c)=E=SUM((i,w,f),CROPHA(c,i,f,w));
TOTCROPHAWCOUNTYQ(i,c)..TOTCROPHAWCOUNTY(i,c)=E=SUM((w,f),CROPHA(c,i,f,w));
CROPCOSTWQ(c)..CROPCOSTW(c)=E= SUM((i,w,f),CROPHA(c,i,f,w)*(ccostwmrb(i,c)-ecostwmrb(i,c)+ecostwmrb(i,c)*ecm +pcost(c)));
TOTFCWQ(c).. TOTFCW(c)=E= SUM((i,w,f),CROPHA(c,i,f,w)*flcost(f));
TOTFCTCWQ .. TOTFCTCW =E= SUM(c,TOTFCW(c));
TOTFWQ(i).. TOTFW(i)=E= SUM((c,w,f),CROPHA(c,i,f,w)*flevel(f));
TOTFERTLEVELQ..TOTFERTLEVEL=E=SUM((i,w,f,c),CROPHA(c,i,f,w)*flevel(f));
TOTWCWQ(c).. TOTWCW(c)=E= SUM((i,w,f),CROPHA(c,i,f,w)*wcostwmrb(i,c));


*CROPMIXW(c,i)..SUM((f,w),CROPHA(c,i,f,w))=e=TAO("2014",i)*crophistwmrb(c,i,"2014");
CROPMIXW(c,i)..SUM((f,w),CROPHA(c,i,f,w))=e=SUM(m,TAO(m,i)*crophistwmrb(c,i,m));
*+SUM(n,GAMMA(n,i)*cropsynwmrb(c,i,n))
*SUM((f,w),CROPHA(c,i,f,w))=e=SUM(m,TAO(m,i)*crophistwmrb(c,i,m))+SUM(n,GAMMA(n,i)*cropsynwmrb(c,i,n));
*SUM((f,w),CROPHA(c,i,f,w)$cropf(c,f))=e=SUM(m,TAO('2018',i)*crophistwmrb(c,i,m));
CMCONVEXW(i).. SUM(m,TAO(m,i))=E=1;
*+SUM(n,GAMMA(n,i))
*CMCONVEXW(i).. TAO("2014",i)=L=1;
*define CROPHA by CROPHA(i,cropf,w)

TOTCROPNQ(c)..TOTCROPN(c)=E=SUM((i,w,f),CROPHA(c,i,f,w)*cropirrin(i,c,w,f));
TOTCROPNGULFQ(c)..TOTCROPNGULF(c)=E=SUM((i,w,f,dr),CROPHA(c,i,f,w)*cropirrin(i,c,w,f)*deliveryratio(i,dr));
TOTNGULFCOUNTYQ(i)..TOTNGULFCOUNTY(i)=E=SUM((c,w,f,dr),CROPHA(c,i,f,w)*cropirrin(i,c,w,f)*deliveryratio(i,dr));
TOTNQ(i).. TOTN(i)=E=SUM((c,w,f),CROPHA(c,i,f,w)*cropirrin(i,c,w,f));
TOTNGULFQ..TOTNGULF=E=SUM(c,TOTCROPNGULF(c));
TOTWATERQ..TOTWATER=E=SUM((c,i,f,w),CROPHA(c,i,f,w)*cowu(w)*cropwu(i,c,f));


******outside MRB part********************
TOTCROPOQ(c).. TOTCROPO(c)=E=SUM(j,CROPHAO(j,c)*cropyieldomrb(j,c));
TOTCROPHAOQ(c)..TOTCROPHAO(c) =E=  SUM(j,CROPHAO(j,c));
CROPCOSTOQ(c)..CROPCOSTO(c)=E= SUM(j,CROPHAO(j,c)*(ccostomrb(j,c)-ecostomrb(j,c)+ecostomrb(j,c)*ecm));
TOTFCOQ(c).. TOTFCO(c)=E= SUM(j,CROPHAO(j,c)*flcostomrb(j,c)*fcm);
TOTFCTCOQ .. TOTFCTCO =E= SUM(c,TOTFCO(c));
TOTWCOQ(c).. TOTWCO(c)=E= SUM(j,CROPHAO(j,c)*wcostomrb(j,c));

*CROPMIXO(c,j)..CROPHAO(j,c)=e=ROU("2014",j)*crophistomrb(c,j,"2014");
CROPMIXO(c,j)..CROPHAO(j,c)=e=SUM(m,ROU(m,j)*crophistomrb(c,j,m));
*CROPHAO(j,c)=e=SUM(m,ROU(m,j)*crophistomrb(c,j,m))+SUM(n,SU(n,j)*cropsynomrb(c,j,n));
*+SUM(n,SU(n,j)*cropsynomrb(c,j,n))
*CROPHAO(j,c)=e=SUM(m,ROU(m,j)*crophistomrb(c,j,m));
*CMCONVEXO(j).. ROU("2014",j)=L=1;
CMCONVEXO(j)..SUM(m,ROU(m,j))=E=1;
*SUM(m,ROU(m,j))+SUM(n,SU(n,j))=l=1;
*SUM(m,ROU(m,j))=l=1
*******************************End of US production************************************************

MODEL  AUTARKYUS /ALL/;
OPTION ITERLIM = 70000;
option RESLIM=5000;
SOLVE AUTARKYUS USING MIP MAXIMIZING CSPS;
OUT.L(c,i,f) = SUM(w,ALLCROPHA.L(c,i,f,w));
OUT2.L(i) = TOTN.L(i);
OUT3.L(i) = TOTNGULFCOUNTY.L(i);
OUT4.L(i,c) = SUM((w,f),ALLCROPHA.L(c,i,f,w));
OUT5.L(j,c) = CROPHAO.L(j,c);
OUT6.L(i) = TOTFW.L(i);
OUT7.L(c,i,w) = SUM(f,ALLCROPHA.L(c,i,f,w));

display TAO.l;
$ontext
$LIBInclude xldump OUT.L "C:\YueluResearch\TradePaper\GAMScode_for_replication\091321TradeTariff.xlsx" wcropha!a1
$LIBInclude xldump OUT2.L "C:\YueluResearch\TradePaper\GAMScode_for_replication\091321TradeTariff.xlsx" Nedge!a1
$LIBInclude xldump OUT3.L "C:\YueluResearch\TradePaper\GAMScode_for_replication\091321TradeTariff.xlsx" NGULF!a1
$LIBInclude xldump OUT4.L "C:\YueluResearch\TradePaper\GAMScode_for_replication\091321TradeTariff.xlsx" wcountycropha!a1
$LIBInclude xldump OUT5.L "C:\YueluResearch\TradePaper\GAMScode_for_replication\091321TradeTariff.xlsx" ocountycropha!a1
$LIBInclude xldump OUT6.L "C:\YueluResearch\TradePaper\GAMScode_for_replication\091321TradeTariff.xlsx" Nuse!a1
$LIBInclude xldump OUT7.L "C:\YueluResearch\TradePaper\GAMScode_for_replication\091321TradeTariff.xlsx" wateruse!a1



 parameter report(*,*,*);
 parameter trans(source,market);
           report(market,"demand","quantity") = demand.l(market);
           report(source,"supply","quantity") = supply.l(source);
           report(market,"demand","price") = demande.m(market);
           report(source,"supply","price") = supplye.m(source);
           trans(source,market) = shipments.l(source,market);
 display report,trans;

 limits(source)=0;
SOLVE TRADE USING NLP MAXIMIZING CSPS;
           report(market,"demand","quantity") = demand.l(market);
           report(source,"supply","quantity") = supply.l(source);
           report(market,"demand","price") = demande.m(market);
           report(source,"supply","price") = supplye.m(source);
           trans(source,market) = shipments.l(source,market);
 display report,trans;

 limits(source)=99999;
 limits("us") = 2;
 SOLVE TRADE USING NLP MAXIMIZING CSPS;
           report(market,"demand","quantity") = demand.l(market);
           report(source,"supply","quantity") = supply.l(source);
           report(market,"demand","price") = demande.m(market);
           report(source,"supply","price") = supplye.m(source);
           trans(source,market) = shipments.l(source,market);
 display report,trans;

 limits(source)=99999;
 subtax("china")=-1.;
 subtax("us")=1.;
 SOLVE TRADE USING NLP MAXIMIZING CSPS;
           report(market,"demand","quantity") = demand.l(market);
           report(source,"supply","quantity") = supply.l(source);
           report(market,"demand","price") = demande.m(market);
           report(source,"supply","price") = supplye.m(source);
           trans(source,market) = shipments.l(source,market);
 display report,trans;

$OFFTEXT


