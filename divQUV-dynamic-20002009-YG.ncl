load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"

filesu1=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/ua2*.nc")
filesu0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/ua1*.nc")
filesv1=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/va2*.nc")
filesv0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/va1*.nc")
filesq0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/hus1*.nc")
fu1=addfiles(filesu1,"r") 
fu0=addfiles(filesu0,"r")
fv1=addfiles(filesv1,"r") 
fv0=addfiles(filesv0,"r")
fq0=addfiles(filesq0,"r")
ListSetType(fu1,"cat")
ListSetType(fu0,"cat")
ListSetType(fv1,"cat")
ListSetType(fv0,"cat")
ListSetType(fq0,"cat")
   ; specific humidity unit:g/kg
q0=fq0[:]->hus
u1=fu1[:]->ua
u0=fu0[:]->ua
v1=fv1[:]->va
v0=fv0[:]->va

;;;;;;;;;;;;;;dynamic uv change q unchange;
qu1100t1=(u1*q0)*1000./9.8-(u0*q0)*1000./9.8
qv1100t1=(v1*q0)*1000./9.8-(v0*q0)*1000./9.8
qu1100t2=(u0*q0)*1000./9.8
qv1100t2=(v0*q0)*1000./9.8
copy_VarCoords(u1,qu1100t1)
copy_VarCoords(v1,qv1100t1)
copy_VarCoords(u1,qu1100t2)
copy_VarCoords(v1,qv1100t2)
;;;;;;;;;;DIV
divt1=uv2dvG_Wrap(qu1100t1,qv1100t1)
divt2=uv2dvG_Wrap(qu1100t2,qv1100t2)
fo=addfile("dynamic_1pct.nc","c")
filedimdef(fo,"time",-1,True)
fo->divd=divt1
fo2=addfile("dynamic_1pct18.nc","c")
filedimdef(fo2,"time",-1,True)
fo2->divd=divt2
quit
