load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
;ALL
filesu1=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/ua2*.nc")
filesu0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/ua1*.nc")
filesv1=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/va2*.nc")
filesv0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/va1*.nc")
filesq1=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/hus2*.nc")
filesq0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/hus1*.nc")
fu1=addfiles(filesu1,"r") 
fu0=addfiles(filesu0,"r")
fv1=addfiles(filesv1,"r") 
fv0=addfiles(filesv0,"r")
fq1=addfiles(filesq1,"r") 
fq0=addfiles(filesq0,"r")
ListSetType(fu1,"cat")
ListSetType(fu0,"cat")
ListSetType(fv1,"cat")
ListSetType(fv0,"cat")
ListSetType(fq1,"cat")
ListSetType(fq0,"cat")
q1=fq1[:]->hus   ; specific humidity unit:g/kg
q0=fq0[:]->hus
u1=fu1[:]->ua
u0=fu0[:]->ua
v1=fv1[:]->va
v0=fv0[:]->va
;Total
qu11001=(u1*q1/9.8-u0*q0/9.8)*1000.
qv11001=(v1*q1/9.8-v0*q0/9.8)*1000.
qu11000=u0*q0/9.8
qv11000=v0*q0/9.8
copy_VarCoords(u1,qu11001)
copy_VarCoords(v1,qv11001)
copy_VarCoords(u1,qu11000)
copy_VarCoords(v1,qv11000)
;;;;;;;;;;DIV
div1=uv2dvG_Wrap(qu11001,qv11001)
div0=uv2dvG_Wrap(qu11000,qv11000)
fo=addfile("total_1pct.nc","c")
filedimdef(fo,"time",-1,True)
fo->div=div1
fo=addfile("total_1pct18.nc","c")
filedimdef(fo,"time",-1,True)
fo->div=div0
quit
