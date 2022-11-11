load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/contributed.ncl"
filesu0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/ua1*.nc")
filesv0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/va1*.nc")
filesq1=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/hus2*.nc")
filesq0=systemfunc("ls /media/renxin/renxin/data/Amon-ModelData/1pctCO/Amon/hus1*.nc")
fu0=addfiles(filesu0,"r")
fv0=addfiles(filesv0,"r")
fq1=addfiles(filesq1,"r") 
fq0=addfiles(filesq0,"r")
ListSetType(fu0,"cat")
ListSetType(fv0,"cat")
ListSetType(fq1,"cat")
ListSetType(fq0,"cat")
q1=fq1[:]->hus           ; specific humidity unit:g/kg
q0=fq0[:]->hus
u0=fu0[:]->ua
v0=fv0[:]->va
print("===========finish reading all the data")
;Thermal
qu1100t1=(u0*q1)*1000./9.8
qv1100t1=(v0*q1)*1000./9.8
delete(q1)
qu1100t2=(u0*q0)*1000./9.8
qv1100t2=(v0*q0)*1000./9.8
delete([/q0/])
copy_VarCoords(u0,qu1100t1)
copy_VarCoords(v0,qv1100t1)
copy_VarCoords(u0,qu1100t2)
copy_VarCoords(v0,qv1100t2)
print("===========finish plus the data")
;;;;;;;;;;DIV
divt1=uv2dvG_Wrap(qu1100t1,qv1100t1)
divt2=uv2dvG_Wrap(qu1100t2,qv1100t2)
fo=addfile("thermo_1pct19.nc","c")
filedimdef(fo,"time",-1,True)
fo->divt=divt1
fo2=addfile("thermo_1pct18.nc","c")
filedimdef(fo2,"time",-1,True)
fo2->divt=divt2
quit
