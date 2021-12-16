select	distinct a12.PAYPER_SKEY  WU_PP_SKEY
into ##T0FH7PFM5MQ000
from	VW_LKP_PERIOD_PAYPER_MATRIX	a11
	join	VW_DIM_PAYPER	a12
	  on 	(a11.PAYPER_SKEY = a12.PAYPER_SKEY)
	join	VW_SEC_USER_IMP	a13
	  on 	(a12.LANG_COD = a13.LANG_COD)
	join	VW_DIM_PERIOD_PAYPER	a14
	  on 	(a11.PERIOD_SKEY = a14.PERIOD_SKEY and 
	a13.LANG_COD = a14.LANG_COD)
where	(a14.PERIOD_NAM_STRNG_ID in (N'954')
 and a11.REF_DAT = '2020-08-03'
 and a12.LANG_COD = N'EN_US'
 and a13.ACTUAL_USER_SKEY = '1') 

select	distinct a11.ACTUAL_USER_SKEY  ACTUAL_USER_SKEY,
	a11.WRK_UNIT_SKEY  WRK_UNIT_SKEY
into ##TYPIXP1M5MQ001
from	VW_R_CB_RPRT_SET_WU	a11
	join	VW_SEC_USER_IMP	a12
	  on 	(a11.ACTUAL_USER_SKEY = a12.ACTUAL_USER_SKEY)
	join	VW_R_CB_RPRT_SET_WU_PRMPT	a13
	  on 	(a11.ACTUAL_USER_SKEY = a13.ACTUAL_USER_SKEY and 
	a11.RPRT_SET_SKEY = a13.RPRT_SET_SKEY)
where	(a12.LANG_COD = N'EN_US'
 and a12.ACTUAL_USER_SKEY = '1'
 and a13.ALISE_SKEY in (N'3634')) 

select	a12.PAYPER_SKEY  PAYPER_SKEY,
	max(a12.PAYPER_ADJ_END_DTM)  WU_PP_END_DATE,
	a16.WRK_UNIT_SKEY  WRK_UNIT_SKEY,
	max(a16.WRK_UNIT_NAM)  WRK_UNIT_NAM,
	a16.WRK_UNIT_SVC_DESC  WRK_UNIT_SVC_DESC,
	sum(a11.VOL_QTY)  WJXBFS1,
	sum(a11.CORE_PRD_FXD_TGT_HRS)  WJXBFS2,
	sum(a11.ACTL_HRS)  WJXBFS3,
	sum(a11.CORE_HRS)  WJXBFS4,
	sum(a11.CORE_OT_HRS)  WJXBFS5,
	sum(a11.CORE_AGCY_HRS)  WJXBFS6,
	sum(a11.ACTL_AMT)  WJXBFS7,
	sum(a11.PRD_AMT)  WJXBFS8,
	max(a11.VRBL_RATIO)  WJXBFS9,
	max(a11.PRD_IND_LWR_THR)  WJXBFSa,
	sum(a11.CORE_NON_PRD_HRS)  WJXBFSb,
	sum(a11.CORE_INTRNL_AGCY_HRS)  WJXBFSc,
	sum(a11.VRBL_RATIO)  WJXBFSd,
	sum((Case when a11.VRBL_RATIO <> 0.0 then 1.0 else 0.0 end))  WJXBFSe
into ##TVMM0OUM5SP002
from	VW_FCT_HC_VOL_PAYROLL_VIP	a11
	join	VW_DIM_PAYPER	a12
	  on 	(a11.LANG_COD = a12.LANG_COD and 
	a11.PAYPER_SKEY = a12.PAYPER_SKEY)
	join	##T0FH7PFM5MQ000	pa13
	  on 	(a12.PAYPER_SKEY = pa13.WU_PP_SKEY)
	join	##TYPIXP1M5MQ001	pa14
	  on 	(a11.ACTUAL_USER_SKEY = pa14.ACTUAL_USER_SKEY and 
	a11.WRK_UNIT_SKEY = pa14.WRK_UNIT_SKEY)
	join	VW_SEC_USER_IMP	a15
	  on 	(a11.ACTUAL_USER_SKEY = a15.ACTUAL_USER_SKEY and 
	a11.LANG_COD = a15.LANG_COD)
	join	VW_DIM_WRK_UNIT	a16
	  on 	(a11.WRK_UNIT_SKEY = a16.WRK_UNIT_SKEY)
where	(a15.LANG_COD = N'EN_US'
 and a12.LANG_COD = N'EN_US'
 and a15.ACTUAL_USER_SKEY = '1'
 and a15.ACTUAL_USER_SKEY = '1')
group by	a12.PAYPER_SKEY,
	a16.WRK_UNIT_SKEY,
	a16.WRK_UNIT_SVC_DESC 

select	a12.PAYPER_SKEY  PAYPER_SKEY,
	max(a12.PAYPER_ADJ_END_DTM)  WU_PP_END_DATE,
	a16.WRK_UNIT_SKEY  WRK_UNIT_SKEY,
	max(a16.WRK_UNIT_NAM)  WRK_UNIT_NAM,
	a16.WRK_UNIT_SVC_DESC  WRK_UNIT_SVC_DESC,
	max(1)  WJXBFS1,
	sum(a11.PAYPER_FTE_FACTOR)  WJXBFS2
into ##TF462EWILSP003
from	VW_FCT_WU_PAYPER	a11
	join	VW_DIM_PAYPER	a12
	  on 	(a11.LANG_COD = a12.LANG_COD and 
	a11.PAYPER_SKEY = a12.PAYPER_SKEY)
	join	##T0FH7PFM5MQ000	pa13
	  on 	(a12.PAYPER_SKEY = pa13.WU_PP_SKEY)
	join	##TYPIXP1M5MQ001	pa14
	  on 	(a11.ACTUAL_USER_SKEY = pa14.ACTUAL_USER_SKEY and 
	a11.WRK_UNIT_SKEY = pa14.WRK_UNIT_SKEY)
	join	VW_SEC_USER_IMP	a15
	  on 	(a11.ACTUAL_USER_SKEY = a15.ACTUAL_USER_SKEY and 
	a11.LANG_COD = a15.LANG_COD)
	join	VW_DIM_WRK_UNIT	a16
	  on 	(a11.WRK_UNIT_SKEY = a16.WRK_UNIT_SKEY)
where	(a15.LANG_COD = N'EN_US'
 and a12.LANG_COD = N'EN_US'
 and a15.ACTUAL_USER_SKEY = '1'
 and a15.ACTUAL_USER_SKEY = '1')
group by	a12.PAYPER_SKEY,
	a16.WRK_UNIT_SKEY,
	a16.WRK_UNIT_SVC_DESC 

select	coalesce(pa11.PAYPER_SKEY, pa12.PAYPER_SKEY)  PAYPER_SKEY,
	coalesce(pa11.WU_PP_END_DATE, pa12.WU_PP_END_DATE)  WU_PP_END_DATE,
	coalesce(pa11.WRK_UNIT_SKEY, pa12.WRK_UNIT_SKEY)  WRK_UNIT_SKEY,
	coalesce(pa11.WRK_UNIT_NAM, pa12.WRK_UNIT_NAM)  WRK_UNIT_NAM,
	coalesce(pa11.WRK_UNIT_SVC_DESC, pa12.WRK_UNIT_SVC_DESC)  WRK_UNIT_SVC_DESC,
	pa11.WJXBFS1  WJXBFS1,
	pa11.WJXBFS2  WJXBFS2,
	pa11.WJXBFS3  WJXBFS3,
	pa11.WJXBFS4  WJXBFS4,
	pa11.WJXBFS5  WJXBFS5,
	pa11.WJXBFS6  WJXBFS6,
	pa11.WJXBFS7  WJXBFS7,
	pa11.WJXBFS8  WJXBFS8,
	pa11.WJXBFS9  WJXBFS9,
	pa12.WJXBFS1  WJXBFSa,
	pa11.WJXBFSa  WJXBFSb,
	pa11.WJXBFSb  WJXBFSc,
	pa11.WJXBFSc  WJXBFSd,
	pa11.WJXBFSd  WJXBFSe
into ##TSX89BA2LMD004
from	##TVMM0OUM5SP002	pa11
	full outer join	##TF462EWILSP003	pa12
	  on 	(pa11.PAYPER_SKEY = pa12.PAYPER_SKEY and 
	pa11.WRK_UNIT_SKEY = pa12.WRK_UNIT_SKEY and 
	pa11.WRK_UNIT_SVC_DESC = pa12.WRK_UNIT_SVC_DESC) 

select	a12.PAYPER_SKEY  PAYPER_SKEY,
	max(a12.PAYPER_ADJ_END_DTM)  WU_PP_END_DATE,
	a16.WRK_UNIT_SKEY  WRK_UNIT_SKEY,
	max(a16.WRK_UNIT_NAM)  WRK_UNIT_NAM,
	a16.WRK_UNIT_SVC_DESC  WRK_UNIT_SVC_DESC,
	sum(a11.CORE_PRD_HRS)  WJXBFS1
into ##TDWC6AKDPMD005
from	VW_FCT_HC_VOL_PAYROLL	a11
	join	VW_DIM_PAYPER	a12
	  on 	(a11.LANG_COD = a12.LANG_COD and 
	a11.PAYPER_SKEY = a12.PAYPER_SKEY)
	join	##T0FH7PFM5MQ000	pa13
	  on 	(a12.PAYPER_SKEY = pa13.WU_PP_SKEY)
	join	##TYPIXP1M5MQ001	pa14
	  on 	(a11.ACTUAL_USER_SKEY = pa14.ACTUAL_USER_SKEY and 
	a11.WRK_UNIT_SKEY = pa14.WRK_UNIT_SKEY)
	join	VW_SEC_USER_IMP	a15
	  on 	(a11.ACTUAL_USER_SKEY = a15.ACTUAL_USER_SKEY and 
	a11.LANG_COD = a15.LANG_COD)
	join	VW_DIM_WRK_UNIT	a16
	  on 	(a11.WRK_UNIT_SKEY = a16.WRK_UNIT_SKEY)
where	(a15.LANG_COD = N'EN_US'
 and a12.LANG_COD = N'EN_US'
 and a15.ACTUAL_USER_SKEY = '1'
 and a15.ACTUAL_USER_SKEY = '1')
group by	a12.PAYPER_SKEY,
	a16.WRK_UNIT_SKEY,
	a16.WRK_UNIT_SVC_DESC 

select	max(a11.VIEW_WAGES_SWT)  WJXBFS1
into ##TWRJJIZNHMD006
from	VW_SEC_USER_IMP	a11
	join	VW_SEC_USER_IMP	a12
	  on 	(a11.ACTUAL_USER_SKEY = a12.ACTUAL_USER_SKEY and 
	a11.LANG_COD = a12.LANG_COD)
where	(a12.ACTUAL_USER_SKEY = '1'
 and a12.LANG_COD = N'EN_US') 

select	pa14.PAYPER_SKEY  PAYPER_SKEY,
	max(pa14.WU_PP_END_DATE)  WU_PP_END_DATE,
	pa14.WRK_UNIT_SKEY  WRK_UNIT_SKEY,
	max(pa14.WRK_UNIT_NAM)  WRK_UNIT_NAM,
	pa14.WRK_UNIT_SVC_DESC  WRK_UNIT_SVC_DESC,
	max((Case when pa14.WJXBFS9 = 0.0 then a11.PRD_IND_LWR_THR else ((a11.PRD_IND_LWR_THR * a11.VRBL_RATIO) / NULLIF(a11.VRBL_RATIO, 0)) end))  WJXBFS1,
	max((Case when pa14.WJXBFS9 = 0.0 then a11.PRD_IND_UPR_THR else ((a11.PRD_IND_UPR_THR * a11.VRBL_RATIO) / NULLIF(a11.VRBL_RATIO, 0)) end))  WJXBFS2
into ##TMKKEIBWTMD007
from	VW_FCT_HC_VOL_PAYROLL_VIP	a11
	join	VW_DIM_WRK_UNIT	a12
	  on 	(a11.WRK_UNIT_SKEY = a12.WRK_UNIT_SKEY)
	join	VW_DIM_PAYPER	a13
	  on 	(a11.LANG_COD = a13.LANG_COD and 
	a11.PAYPER_SKEY = a13.PAYPER_SKEY)
	right outer join	##TSX89BA2LMD004	pa14
	  on 	(a12.WRK_UNIT_SKEY = pa14.WRK_UNIT_SKEY and 
	a12.WRK_UNIT_SVC_DESC = pa14.WRK_UNIT_SVC_DESC and 
	a13.PAYPER_SKEY = pa14.PAYPER_SKEY)
	join	VW_SEC_USER_IMP	a15
	  on 	(a11.ACTUAL_USER_SKEY = a15.ACTUAL_USER_SKEY and 
	a11.LANG_COD = a15.LANG_COD)
where	(a15.LANG_COD = N'EN_US'
 and a13.LANG_COD = N'EN_US'
 and a15.ACTUAL_USER_SKEY = '1'
 and a15.ACTUAL_USER_SKEY = '1')
group by	pa14.PAYPER_SKEY,
	pa14.WRK_UNIT_SKEY,
	pa14.WRK_UNIT_SVC_DESC 

select	a11.WRK_UNIT_SKEY  WRK_UNIT_SKEY,
	a11.PAYPER_SKEY  PAYPER_SKEY,
	a11.LANG_COD  LANG_COD,
	a12.PAYPER_SKEY  PAYPER_SKEY0,
	max(a12.PAYPER_ADJ_END_DTM)  WU_PP_END_DATE,
	sum((Case when a11.VRBL_RATIO <> 0.0 then 1.0 else 0.0 end))  WJXBFS1
into ##TSG9MKE1PMD008
from	VW_FCT_HC_VOL_PAYROLL_VIP	a11
	join	VW_DIM_PAYPER	a12
	  on 	(a11.LANG_COD = a12.LANG_COD and 
	a11.PAYPER_SKEY = a12.PAYPER_SKEY)
	join	##T0FH7PFM5MQ000	pa13
	  on 	(a12.PAYPER_SKEY = pa13.WU_PP_SKEY)
	join	##TYPIXP1M5MQ001	pa14
	  on 	(a11.ACTUAL_USER_SKEY = pa14.ACTUAL_USER_SKEY and 
	a11.WRK_UNIT_SKEY = pa14.WRK_UNIT_SKEY)
	join	VW_SEC_USER_IMP	a15
	  on 	(a11.ACTUAL_USER_SKEY = a15.ACTUAL_USER_SKEY and 
	a11.LANG_COD = a15.LANG_COD)
where	(a15.LANG_COD = N'EN_US'
 and a12.LANG_COD = N'EN_US'
 and a15.ACTUAL_USER_SKEY = '1'
 and a15.ACTUAL_USER_SKEY = '1')
group by	a11.WRK_UNIT_SKEY,
	a11.PAYPER_SKEY,
	a11.LANG_COD,
	a12.PAYPER_SKEY 

select	pa11.PAYPER_SKEY0  PAYPER_SKEY,
	max(pa11.WU_PP_END_DATE)  WU_PP_END_DATE,
	pa13.WRK_UNIT_SKEY  WRK_UNIT_SKEY,
	max(pa13.WRK_UNIT_NAM)  WRK_UNIT_NAM,
	pa13.WRK_UNIT_SVC_DESC  WRK_UNIT_SVC_DESC,
	sum(ISNULL((pa13.WJXBFS1 * (pa13.WJXBFSd / NULLIF(pa11.WJXBFS1, 0))), 0))  WJXBFS1
into ##TH9P9KAX9MD009
from	##TSG9MKE1PMD008	pa11
	join	VW_DIM_WRK_UNIT	a12
	  on 	(pa11.WRK_UNIT_SKEY = a12.WRK_UNIT_SKEY)
	join	##TVMM0OUM5SP002	pa13
	  on 	(a12.WRK_UNIT_SKEY = pa13.WRK_UNIT_SKEY and 
	a12.WRK_UNIT_SVC_DESC = pa13.WRK_UNIT_SVC_DESC and 
	pa11.PAYPER_SKEY0 = pa13.PAYPER_SKEY)
	join	VW_DIM_PAYPER	a14
	  on 	(pa11.LANG_COD = a14.LANG_COD and 
	pa11.PAYPER_SKEY = a14.PAYPER_SKEY)
	join	##T0FH7PFM5MQ000	pa15
	  on 	(a14.PAYPER_SKEY = pa15.WU_PP_SKEY)
	join	VW_SEC_MATRIX_WRK_UNIT	a16
	  on 	(pa11.WRK_UNIT_SKEY = a16.WRK_UNIT_SKEY)
	join	VW_SEC_USER_IMP	a17
	  on 	(a16.ACTUAL_USER_SKEY = a17.ACTUAL_USER_SKEY and 
	a16.LANG_COD = a17.LANG_COD)
where	(a17.LANG_COD = N'EN_US'
 and a14.LANG_COD = N'EN_US'
 and a17.ACTUAL_USER_SKEY = '1'
 and a17.ACTUAL_USER_SKEY = '1')
group by	pa11.PAYPER_SKEY0,
	pa13.WRK_UNIT_SKEY,
	pa13.WRK_UNIT_SVC_DESC 

select	coalesce(pa11.WRK_UNIT_SKEY, pa12.WRK_UNIT_SKEY, pa13.WRK_UNIT_SKEY)  WRK_UNIT_SKEY,
	coalesce(pa11.WRK_UNIT_NAM, pa12.WRK_UNIT_NAM, pa13.WRK_UNIT_NAM)  WRK_UNIT_NAM,
	coalesce(pa11.PAYPER_SKEY, pa12.PAYPER_SKEY, pa13.PAYPER_SKEY)  PAYPER_SKEY,
	coalesce(pa11.WU_PP_END_DATE, pa12.WU_PP_END_DATE, pa13.WU_PP_END_DATE)  WU_PP_END_DATE,
	coalesce(pa11.WRK_UNIT_SVC_DESC, pa12.WRK_UNIT_SVC_DESC, pa13.WRK_UNIT_SVC_DESC)  WRK_UNIT_SVC_DESC,
	pa11.WJXBFS1  WJXBFS1,
	pa11.WJXBFS2  WJXBFS2,
	pa11.WJXBFS3  WJXBFS3,
	pa11.WJXBFS4  WJXBFS4,
	pa11.WJXBFS5  WJXBFS5,
	pa11.WJXBFS6  WJXBFS6,
	pa12.WJXBFS1  WJXBFS7,
	ISNULL((pa11.WJXBFS7 * pa15.WJXBFS1), 0)  WJXBFS8,
	ISNULL((pa11.WJXBFS8 * pa15.WJXBFS1), 0)  WJXBFS9,
	pa13.WJXBFS1  WJXBFSa,
	pa13.WJXBFS2  WJXBFSb,
	pa11.WJXBFSa  WJXBFSc,
	pa11.WJXBFSb  WJXBFSd,
	pa15.WJXBFS1  WJXBFSe,
	pa11.WJXBFS9  WJXBFSf,
	pa11.WJXBFSc  WJXBFS10,
	pa11.WJXBFSd  WJXBFS11,
	pa16.WJXBFS1  WJXBFS12,
	pa17.WJXBFS1  WJXBFS13,
	pa17.WJXBFSe  WJXBFS14,
	pa17.WJXBFSd  WJXBFS15,
	pa11.WJXBFSe  WJXBFS16,
	pa110.WJXBFS2  WJXBFS18
from	##TSX89BA2LMD004	pa11
	full outer join	##TDWC6AKDPMD005	pa12
	  on 	(pa11.PAYPER_SKEY = pa12.PAYPER_SKEY and 
	pa11.WRK_UNIT_SKEY = pa12.WRK_UNIT_SKEY and 
	pa11.WRK_UNIT_SVC_DESC = pa12.WRK_UNIT_SVC_DESC)
	full outer join	##TMKKEIBWTMD007	pa13
	  on 	(coalesce(pa11.PAYPER_SKEY, pa12.PAYPER_SKEY) = pa13.PAYPER_SKEY and 
	coalesce(pa11.WRK_UNIT_SKEY, pa12.WRK_UNIT_SKEY) = pa13.WRK_UNIT_SKEY and 
	coalesce(pa11.WRK_UNIT_SVC_DESC, pa12.WRK_UNIT_SVC_DESC) = pa13.WRK_UNIT_SVC_DESC)
	cross join	##TWRJJIZNHMD006	pa15
	left outer join	##TH9P9KAX9MD009	pa16
	  on 	(coalesce(pa11.PAYPER_SKEY, pa12.PAYPER_SKEY, pa13.PAYPER_SKEY) = pa16.PAYPER_SKEY and 
	coalesce(pa11.WRK_UNIT_SKEY, pa12.WRK_UNIT_SKEY, pa13.WRK_UNIT_SKEY) = pa16.WRK_UNIT_SKEY and 
	coalesce(pa11.WRK_UNIT_SVC_DESC, pa12.WRK_UNIT_SVC_DESC, pa13.WRK_UNIT_SVC_DESC) = pa16.WRK_UNIT_SVC_DESC)
	left outer join	##TVMM0OUM5SP002	pa17
	  on 	(coalesce(pa11.PAYPER_SKEY, pa12.PAYPER_SKEY, pa13.PAYPER_SKEY) = pa17.PAYPER_SKEY and 
	coalesce(pa11.WRK_UNIT_SKEY, pa12.WRK_UNIT_SKEY, pa13.WRK_UNIT_SKEY) = pa17.WRK_UNIT_SKEY and 
	coalesce(pa11.WRK_UNIT_SVC_DESC, pa12.WRK_UNIT_SVC_DESC, pa13.WRK_UNIT_SVC_DESC) = pa17.WRK_UNIT_SVC_DESC)
	left outer join	##TF462EWILSP003	pa110
	  on 	(coalesce(pa11.PAYPER_SKEY, pa12.PAYPER_SKEY, pa13.PAYPER_SKEY) = pa110.PAYPER_SKEY and 
	coalesce(pa11.WRK_UNIT_SKEY, pa12.WRK_UNIT_SKEY, pa13.WRK_UNIT_SKEY) = pa110.WRK_UNIT_SKEY and 
	coalesce(pa11.WRK_UNIT_SVC_DESC, pa12.WRK_UNIT_SVC_DESC, pa13.WRK_UNIT_SVC_DESC) = pa110.WRK_UNIT_SVC_DESC)

drop table ##T0FH7PFM5MQ000

drop table ##TYPIXP1M5MQ001

drop table ##TVMM0OUM5SP002

drop table ##TF462EWILSP003

drop table ##TSX89BA2LMD004

drop table ##TDWC6AKDPMD005

drop table ##TWRJJIZNHMD006

drop table ##TMKKEIBWTMD007

drop table ##TSG9MKE1PMD008

drop table ##TH9P9KAX9MD009

[Analytical engine calculation steps:
	1.  Calculate metric: <VARIABLE HOUR TARGETS/UOS> in the dataset
	2.  Calculate metric: <Actual FTEs> in the dataset
	3.  Calculate metric: <VARIABLE HOUR TARGETS/UOS-1> in the dataset
	4.  Perform dynamic aggregation over <Unit of Service, Work Unit>
	5.  Calculate metric: <ACTUAL PRODUCTIVE > at original data level in the view
	6.  Calculate metric: <TOTAL TARGET PRODUCTIVE New> at original data level in the view
	7.  Calculate metric: <PRODUCTIVITY INDEX New> at original data level in the view
	8.  Calculate metric: <Variable Avg New> at original data level in the view
	9.  Calculate metric: <FIXED HOUR TARGETS > at original data level in the view
	10.  Calculate metric: <AVERAGE HOURLY RATE> at original data level in the view
	11.  Calculate metric: <ESTIMATED COST New> at original data level in the view
	12.  Calculate metric: <NON-PRODUCTIVE > at original data level in the view
	13.  Calculate metric: <PAID HOURS > at original data level in the view
	14.  Calculate metric: <OVERTIME > at original data level in the view
	15.  Calculate metric: <PRODUCTIVE VARIANCE> at original data level in the view
	16.  Calculate metric: <PRODUCTIVITY INDEX> at original data level in the view
	17.  Calculate metric: <TARGET/UOS> at original data level in the view
	18.  Calculate metric: <ACTUAL/UOS> at original data level in the view
	19.  Calculate metric: <PRODUCTIVE VARIANCE/UOS> at original data level in the view
	20.  Calculate metric: <PRODUCTIVE COST/UOS> at original data level in the view
	21.  Calculate metric: <PAID MONEY/UOS> at original data level in the view
	22.  Calculate metric: <ESTIMATED COST> at original data level in the view
	23.  Calculate metric: <Actual FTEs> at original data level in the view
	24.  Calculate metric: <VARIABLE HOUR TARGETS/UOS-1> at original data level in the view
	25.  Calculate subtotal: <TOTAL> 
	26.  Calculate metric: <ACTUAL PRODUCTIVE > at subtotal levels in the view
	27.  Calculate metric: <TOTAL TARGET PRODUCTIVE New> at subtotal levels in the view
	28.  Calculate metric: <PRODUCTIVITY INDEX New> at subtotal levels in the view
	29.  Calculate metric: <Variable Avg New> at subtotal levels in the view
	30.  Calculate metric: <FIXED HOUR TARGETS > at subtotal levels in the view
	31.  Calculate metric: <AVERAGE HOURLY RATE> at subtotal levels in the view
	32.  Calculate metric: <ESTIMATED COST New> at subtotal levels in the view
	33.  Calculate metric: <NON-PRODUCTIVE > at subtotal levels in the view
	34.  Calculate metric: <PAID HOURS > at subtotal levels in the view
	35.  Calculate metric: <OVERTIME > at subtotal levels in the view
	36.  Calculate metric: <PRODUCTIVE VARIANCE> at subtotal levels in the view
	37.  Calculate metric: <PRODUCTIVITY INDEX> at subtotal levels in the view
	38.  Calculate metric: <TARGET/UOS> at subtotal levels in the view
	39.  Calculate metric: <ACTUAL/UOS> at subtotal levels in the view
	40.  Calculate metric: <PRODUCTIVE VARIANCE/UOS> at subtotal levels in the view
	41.  Calculate metric: <PRODUCTIVE COST/UOS> at subtotal levels in the view
	42.  Calculate metric: <PAID MONEY/UOS> at subtotal levels in the view
	43.  Calculate metric: <ESTIMATED COST> at subtotal levels in the view
	44.  Calculate metric: <Actual FTEs> at subtotal levels in the view
	45.  Calculate metric: <VARIABLE HOUR TARGETS/UOS-1> at subtotal levels in the view
	46.  Perform cross-tabbing
]
