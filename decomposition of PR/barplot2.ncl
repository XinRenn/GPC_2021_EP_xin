     pr18p  = addfile("/media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/pr_Amon_MPI-ESM-P_1pctCO2_r1i1p1_185001-198912.nc","r")
     pr18e  = addfile("/media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/evspsbl_Amon_MPI-ESM-P_1pctCO2_r1i1p1_185001-198912.nc","r")
     div18  = addfile("/media/renxin/renxin/绘图脚本、/动热/单项/total_1pct.nc","r")
     divd18 = addfile("/media/renxin/renxin/绘图脚本、/动热/单项/dynamic_1pct.nc","r")
     divt18 = addfile("/media/renxin/renxin/绘图脚本、/动热/单项/thermo_1pct.nc","r")
     divc18 = addfile("/media/renxin/renxin/绘图脚本、/动热/单项/cross_1pct.nc","r")
      
     prmhp  = addfile("/media/renxin/renxin/data/Amon-ModelData/mid-holocene/pr_Amon_MPI-ESM-P_midHolocene_r1i1p1_185001-194912.nc","r")
     prpip  = addfile("/media/renxin/renxin/data/Amon-ModelData/piControl/pr_Amon_MPI-ESM-P_piControl_r1i1p1_185001-199912.nc","r")
     prmhe  = addfile("/media/renxin/renxin/data/Amon-ModelData/mid-holocene/evspsbl_Amon_MPI-ESM-P_midHolocene_r1i1p1_185001-194912.nc","r")
     prpie  = addfile("/media/renxin/renxin/data/Amon-ModelData/piControl/evspsbl_Amon_MPI-ESM-P_piControl_r1i1p1_185001-199912.nc","r")
     divpi  = addfile("/media/renxin/renxin/绘图脚本、/动热/单项/total_mhpi.nc","r")
     divdpi = addfile("/media/renxin/renxin/绘图脚本、/动热/单项/dynamic_mhpi.nc","r")
     divtpi = addfile("/media/renxin/renxin/绘图脚本、/动热/单项/thermo_mhpi.nc","r")
     divcpi = addfile("/media/renxin/renxin/绘图脚本、/动热/单项/cross_mhpi.nc","r")

plev=85000.
i=0
region=(/"SEA","NEA","JAPAN"/)

tot18p0=pr18p->pr(0:239,:,:)
tot18p1=pr18p->pr(1440:,:,:)
tot18e0=pr18e->evspsbl(0:239,:,:)
tot18e1=pr18e->evspsbl(1440:,:,:)
tot18=tot18p1-tot18p0-(tot18e1-tot18e0)
to18=div18->div(:,{plev},:,:)
dy18=divd18->divd(:,{plev},:,:)
th18=divt18->divt(:,{plev},:,:)
cro18=divc18->divc(:,{plev},:,:)

totmhp=prmhp->pr(:1199,:,:)
totpiip=prpip->pr(:1199,:,:)
totmhe=prmhe->evspsbl(:1199,:,:)
totpiie=prpie->evspsbl(:1199,:,:)
totpi=totmhp-totpiip-(totmhe-totpiie)
topi=divpi->div(:,{plev},:,:)
dypi=divdpi->divd(:,{plev},:,:)
thpi=divtpi->divt(:,{plev},:,:)
cropi=divcpi->divc(:,{plev},:,:)

copy_VarCoords(tot18p0,tot18)
copy_VarCoords(totmhp,totpi)
tot18:=month_to_season(tot18,"JJA")
totpi:=month_to_season(totpi,"JJA")
dypi:=month_to_season(dypi,"JJA")
cropipi:=month_to_season(cropi,"JJA")

pct18=new((/dimsizes(to18(:,0,0)),6,dimsizes(to18(0,:,0)),dimsizes(to18(0,0,:))/),"double")
pi=new((/dimsizes(topi(:,0,0)),6,dimsizes(to18(0,:,0)),dimsizes(to18(0,0,:))/),"double")
pct18(:,0,:,:)=tot18*(-1000.)
pct18(:,1,:,:)=to18
pct18(:,2,:,:)=tot18*(-1000.)-to18
pct18(:,3,:,:)=dy18
pct18(:,4,:,:)=th18
pct18(:,5,:,:)=cro18
pi(:,0,:,:)=totpi*(-1000.)
pi(:,1,:,:)=topi
pi(:,2,:,:)=totpi*(-1000.)-topi
pi(:,3,:,:)=dypi
pi(:,4,:,:)=thpi
pi(:,5,:,:)=cropi

;pct18JJA0=month_to_season(pct18,"JJA")
;piJJA0=month_to_season(pi,"JJA")
;printVarSummary(piJJA)

if(i.eq.0) then
pct18JJA:=pct18(:,:,{20:30},{112:122})
piJJA:=pi(:,:,{20:30},{112:122})
end if
if(i.eq.1) then
pct18JJA:=pct18(:,:,{30:45},{112:122})
piJJA:=pi(:,:,{30:45},{112:122})
end if
if(i.eq.2) then
pct18JJA:=pct18(:,:,{30:45},{130:145})
piJJA:=pi(:,:,{30:45},{130:145})
end if

pct18:=dim_avg_n(pct18JJA,(/2,3/))
pct18:=dim_avg_n(pct18,0)
pi:=dim_avg_n(piJJA,(/2,3/))
pi:=dim_avg_n(pi,0)

pct=doubletofloat(pct18)*24.*60*60*(-1)/1000.
mhpi=doubletofloat(pi)*24.*60*60*(-1)/1000.

;======================================================================================	
     wks = gsn_open_wks("png",plev+"p"+region(i))          ; send graphics to PNG file

     sres = True
     sres@vpWidthF = 0.75
     sres@vpHeightF = 0.5
     sres@vpXF = .15
     sres@trXMinF = 0.
     sres@trXMaxF = 14
     sres@trYMinF = -1.5
     sres@trYMaxF = 1.5
     sres@gsnDraw = True
     sres@gsnFrame = False
     sres@gsnYRefLine           = 0.              ; reference line  
     sres@gsnXYBarChart = True
     sres@gsnXYBarChartBarWidth = 0.6           ; change bar widths

     sres@tmYMajorGrid= True
     sres@tmYMajorGridLineDashPattern =2
     sres@tmYMajorGridThicknessF      = 1.0     ; default is 2
     sres@tmXMajorGridLineColor = "Gray"
     sres@tmXBMode          = "Explicit"         ; explicit labels
     sres@tmXBValues        = fspan(1,13,6)
     sres@tmXBLabels = (/"Total","Total~C~(Monthly~C~Data)","Transient~C~Eddy~C~(Calc.as~C~residual)","Dynamic~C~(Monthly~C~Data)","Thermal~C~(Monthly~C~Data)","Cross term~C~(Monthly~C~Data)"/)
     ;sres@tmLabelAutoStride =True
     sres@tmXBTickSpacingF  =0.1
     sres@tmXBAutoPrecision =True
     sres@tmXBMajorLengthF =0.005
     sres@tmXBLabelFontHeightF = 0.018
     sres@tmXTLabelFontHeightF = 0.0205
     sres@tmYLLabelFontHeightF = 0.0225
     sres@tiMainFontHeightF = 0.025
     ;    sres@tiMainFont = " "
     ;sres@tiMainString = " "
     sres@gsnLeftString = region(i)+"   JJA"
     sres@gsnLeftStringFontHeightF =0.03
     sres@gsnLeftStringOrthogonalPosF =-0.12
     sres@gsnLeftStringParallelPosF   = 0.02
     sres@tiYAxisString = "[mm/day]"

    sres@gsnXYBarChartColors = (/"red"/)	
     plot2 = gsn_csm_xy(wks,fspan(.7,12.7,6),mhpi,sres)		; advancing the frame
     sres@gsnXYBarChartColors = (/"blue"/)					; but tweaking where
     plot3 = gsn_csm_xy(wks,fspan(1.3,13.3,6),pct,sres)	; each time series is

;;;;;;;;;;;;;;;;;label bar;;;;;;;;;;;
     lbres                    = True          ; labelbar only resources
     lbres@vpWidthF           = 0.2           ; labelbar width
     lbres@vpHeightF          = 0.05           ; labelbar height
     lbres@lbBoxMajorExtentF  = 0.36          ; puts space between color boxes
     lbres@lbFillColors       = (/"blue"/)
     lbres@lbMonoFillPattern  = True          ; Solid fill pattern
     lbres@lbLabelFontHeightF = 0.02         ; font height. default is small
     lbres@lbLabelJust        = "CenterRight"  ; left justify labels
     lbres@lbPerimOn          = False
     lbres@lgPerimColor 	 = "white"
     labels = (/"1pct"/)
     gsn_labelbar_ndc(wks,1,labels,0.7,0.8,lbres)	; draw right labelbar column
	
     lbres@lbFillColors       = (/"red"/)
     labels = (/"mh-pi"/)
     gsn_labelbar_ndc(wks,1,labels,0.71,0.75,lbres)	; draw left labelbar column
     frame(wks)    
;end  
