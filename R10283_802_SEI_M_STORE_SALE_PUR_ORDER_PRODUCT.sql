/*BEGIN*/
/*
 * 処理概要：
 * 店舗系マスタ・発注セールに関する製品系マスタを読込み、店別セール発注製品マスタを登録する。
 *
 */
/*END*/
insert /* _SQL_IDENTIFIER_ */
into
	m_store_sale_pur_order_product	-- 店別セール発注製品マスタ
(
	store_id				-- 店舗ID
,	sale_id					-- セールID
,	product_id				-- 製品ID
,	forwarding_begn_date	-- 廻送日付開始
,	store_cd				-- 店舗コード
,	department_cd			-- 部門コード
,	store_nm				-- 店舗名
,	ship_to_typ				-- 出荷先区分
,	district_typ			-- 地区区分
,	sub_district_typ		-- サブ地区区分
,	district_sub_nm			-- 地区サブ名
,	district_depart_nm		-- 地区部名
,	sv_cd					-- SVコード
,	sv_nm					-- SV名
,	org_id					-- 組織ID
,	sale_typ				-- セール区分
,	disp_begn_date			-- 表示開始日
,	disp_finish_date		-- 表示終了日
,	sale_nm					-- セール名
,	forwarding_finish_date	-- 廻送日付終了
,	slip_date				-- 伝票日付
,	product_cd				-- 製品コード
,	product_nm				-- 製品名
,	part_no					-- 品番
,	biz_cd					-- 業務コード
,	qty						-- 入数
,	sprt_unit_cost			-- バラ単価
,	pur_order_pur_unit_cost	-- 発注仕入原単価
,	item_id					-- 商品ID
,	item_cd					-- 商品コード
,	item_nm					-- 商品名
,	basic_descr				-- 基本説明
,	regi_large_class_id		-- レジ大分類ID
,	regi_large_class_cd		-- レジ大分類コード
,	regi_large_class_nm		-- レジ大分類名
,	regi_middle_class_id	-- レジ中分類ID
,	regi_middle_class_cd	-- レジ中分類コード
,	regi_middle_class_nm	-- レジ中分類名
,	regi_small_class_id		-- レジ小分類ID
,	regi_small_class_cd		-- レジ小分類コード
,	regi_small_class_nm		-- レジ小分類名
,	piece_class_id			-- 単品分類ID
,	piece_class_cd			-- 単品分類コード
,	piece_class_nm			-- 単品分類名
,	sell_unit_prc			-- 売単価
,	supplier_cd				-- 仕入先コード
,	sply_lt					-- 供給LT
,	pur_order_closing_id	-- 発注締めID
,	deliv_abl_flg			-- 配送可フラグ
)
select
	msre.store_id												as	store_id				-- 店舗ID
,	msle.sale_id												as	sale_id					-- セールID
,	mpct.product_id												as	product_id				-- 製品ID
,	mspop.forwarding_begn_date									as	forwarding_begn_date	-- 廻送日付開始
,	max(msre.store_cd)											as	store_cd				-- 店舗コード
,	max(msre.department_cd)										as	department_cd			-- 部門コード
,	max(msre.store_nm)											as	store_nm				-- 店舗名
,	max(mstg.ship_to_typ)										as	ship_to_typ				-- 出荷先区分
,	max(mstg.district_typ)										as	district_typ			-- 地区区分
,	max(mstg.sub_district_typ)									as	sub_district_typ		-- サブ地区区分
,	max(mrds.district_sub_nm)									as	district_sub_nm			-- 地区サブ名
,	max(mrds.district_depart_nm)								as	district_depart_nm		-- 地区部名
,	max(mrds.sv_cd)												as	sv_cd					-- SVコード
,	max(mrds.sv_nm)												as	sv_nm					-- SV名
,	max(morg.org_id)											as	org_id					-- 組織ID
,	max(msle.sale_typ)											as	sale_typ				-- セール区分
,	max(msle.disp_begn_date)									as	disp_begn_date			-- 表示開始日
,	max(msle.disp_finish_date)									as	disp_finish_date		-- 表示終了日
,	max(msle.sale_nm)											as	sale_nm					-- セール名
,	max(mspop.forwarding_finish_date)							as	forwarding_finish_date	-- 廻送日付終了
,	max(mspop.slip_date)										as	slip_date				-- 伝票日付
,	max(mpct.product_cd)										as	product_cd				-- 製品コード
,	max(mpgn.product_nm)										as	product_nm				-- 製品名
,	max(mpgn.part_no)											as	part_no					-- 品番
,	max(mpgn.biz_cd)											as	biz_cd					-- 業務コード
,	max(mpgn.qty)												as	qty						-- 入数
,	max(
		case
			when
				mstg.delivery_unit_cost_typ	=	/*#CLS_DELIVERY_UNIT_COST_TYP_MANAGED_DIRECTLY*/'01'
			then
				mpgn.sprt_unit_cost_rc	-- 製品世代マスタ.バラ単価（RC）
			when
				mstg.delivery_unit_cost_typ	=	/*#CLS_DELIVERY_UNIT_COST_TYP_FC0*/'02'
			then
				mpgn.sprt_unit_cost_fc0	-- 製品世代マスタ.バラ単価（ＦＣ-０）
			when
				mstg.delivery_unit_cost_typ	=	/*#CLS_DELIVERY_UNIT_COST_TYP_FC1*/'03'
			then
				mpgn.sprt_unit_cost_fc1	-- 製品世代マスタ.バラ単価（ＦＣ-１）
			when
				mstg.delivery_unit_cost_typ	=	/*#CLS_DELIVERY_UNIT_COST_TYP_FC2*/'04'
			then
				mpgn.sprt_unit_cost_fc2	-- 製品世代マスタ.バラ単価（ＦＣ-２）
			when
				mstg.delivery_unit_cost_typ	=	/*#CLS_DELIVERY_UNIT_COST_TYP_FFS*/'05'
			then
				mpgn.sprt_unit_cost_ffs	-- 製品世代マスタ.バラ単価（ＦＦＳ）
		end
	)															as	sprt_unit_cost			-- バラ単価
,	max(
		case
			when
				mstg.delivery_unit_cost_typ	=	/*CLS_DELIVERY_UNIT_COST_TYP_MANAGED_DIRECTLY*/'01'
			then
				mpgn.barros_unit_cost_rc	-- 製品世代マスタ.バロス単価（ＲＣ）
			when
				mstg.delivery_unit_cost_typ	=	/*CLS_DELIVERY_UNIT_COST_TYP_FC0*/'02'
			then
				mpgn.barros_unit_cost_fc0	-- 製品世代マスタ.バロス単価（ＦＣ-０）
			when
				mstg.delivery_unit_cost_typ	=	/*CLS_DELIVERY_UNIT_COST_TYP_FC1*/'03'
			then
				mpgn.barros_unit_cost_fc1	-- 製品世代マスタ.バロス単価（ＦＣ-１）
			when
				mstg.delivery_unit_cost_typ	=	/*CLS_DELIVERY_UNIT_COST_TYP_FC2*/'04'
			then
				mpgn.barros_unit_cost_fc2	-- 製品世代マスタ.バロス単価（ＦＣ-２）
			when
				mstg.delivery_unit_cost_typ	=	/*CLS_DELIVERY_UNIT_COST_TYP_FFS*/'05'
			then
				mpgn.barros_unit_cost_ffs	-- 製品世代マスタ.バロス単価（ＦＦＳ）
		end
	)															as	pur_order_pur_unit_cost	-- 発注仕入原単価
,	max(miem.item_id)											as	item_id					-- 商品ID
,	max(miem.item_cd)											as	item_cd					-- 商品コード
,	max(miem.item_nm)											as	item_nm					-- 商品名
,	max(miem.basic_descr)										as	basic_descr				-- 基本説明
,	max(
		case
			when
				micd.hier_level	=	'1'
			then
				micd.item_class_id
			else
				null
		end
	)															as	regi_large_class_id		-- レジ大分類ID
,	max(
		case
			when
				micd.hier_level	=	'1'
			then
				micd.item_class_cd
			else
				null
		end
	)															as	regi_large_class_cd		-- レジ大分類コード
,	max(
		case
			when
				micd.hier_level	=	'1'
			then
				micd.item_class_nm
			else
				null
		end
	)															as	regi_large_class_nm		-- レジ大分類名
,	max(
		case
			when
				micd.hier_level	=	'2'
			then
				micd.item_class_id
			else
				null
		end
	)															as	regi_middle_class_id	-- レジ中分類ID
,	max(
		case
			when
				micd.hier_level	=	'2'
			then
				micd.item_class_cd
			else
				null
		end
	)															as	regi_middle_class_cd	-- レジ中分類コード
,	max(
		case
			when
				micd.hier_level	=	'2'
			then
				micd.item_class_nm
			else
				null
		end
	)															as	regi_middle_class_nm	-- レジ中分類名
,	max(
		case
			when
				micd.hier_level	=	'3'
			then
				micd.item_class_id
			else
				null
		end
	)															as	regi_small_class_id		-- レジ小分類ID
,	max(
		case
			when
				micd.hier_level	=	'3'
			then
				micd.item_class_cd
			else
				null
		end
	)															as	regi_small_class_cd		-- レジ小分類コード
,	max(
		case
			when
				micd.hier_level	=	'3'
			then
				micd.item_class_nm
			else
				null
		end
	)															as	regi_small_class_nm		-- レジ小分類名
,	max(
		case
			when
				micd.hier_level	=	'4'
			then
				micd.item_class_id
			else
				null
		end
	)															as	piece_class_id			-- 単品分類ID
,	max(
		case
			when
				micd.hier_level	=	'4'
			then
				micd.item_class_cd
			else
				null
		end
	)															as	piece_class_cd			-- 単品分類コード
,	max(
		case
			when
				micd.hier_level	=	'4'
			then
				micd.item_class_nm
			else
				null
		end
	)															as	piece_class_nm			-- 単品分類名
,	max(msfisc.sell_unit_prc)									as	sell_unit_prc			-- 売単価
,	max(mser.supplier_cd)										as	supplier_cd				-- 仕入先コード
,	max(mspop.forwarding_begn_date	-	msle.disp_finish_date)	as	sply_lt					-- 供給LT
,	max(mser.pur_order_closing_id)								as	pur_order_closing_id	-- 発注締めID
,	max(
		case
			when
				msle.sale_typ	=	/*#CLS_SALE_TYP_LONG_LT_NORMAL_PUR_ORDER*/'99'
			then
				mcbs.deliv_abl_flg
			else
				/*#CLS_DELIV_ABL_FLG_DELIV_ABL*/'01'
		end
	)															as	deliv_abl_flg			-- 配送可フラグ
from
	m_sale	msle	-- セールマスタ
inner join
	m_sale_pur_order_product	mspop	-- セール発注製品マスタ
on
	mspop.del_flg	=	/*#CLS_FLAG_OFF*/'00'	-- セール発注製品マスタ.削除フラグ
and	mspop.sale_id	=	msle.sale_id			-- セール発注製品マスタ.セールID = セールマスタ.セールID
inner join
	m_item	miem	-- 商品マスタ
on
	miem.del_flg				=		/*#CLS_FLAG_OFF*/'00'					-- 商品マスタ.削除フラグ
and	miem.item_cd				=		mspop.item_cd							-- 商品マスタ.商品コード = セール発注製品マスタ.商品コード
and	mspop.forwarding_begn_date	between	miem.start_date	and	miem.end_date		-- セール発注製品マスタ.廻送日付開始 between 商品マスタ.適用開始日 and 商品マスタ.適用終了日
and	miem.item_deal_state_typ	=		/*#CLS_ITEM_DEAL_STATE_TYP_DEAL*/'01'	-- 商品マスタ.商品取扱状態区分 = [区分値.商品取扱状態区分.取扱]
inner join
	m_item_class_rlat	micr	-- 商品分類関連マスタ
on
	micr.del_flg				=	/*#CLS_FLAG_OFF*/'00'								-- 商品分類関連マスタ.削除フラグ
and	micr.item_id				=	miem.item_id										-- 商品分類関連マスタ.商品ID = 商品マスタ.商品ID
and	micr.item_end_date			=	miem.end_date										-- 商品分類関連マスタ.商品適用終了日 = 商品マスタ.適用終了日
and	micr.item_class_scheme_typ	=	/*#CLS_ITEM_CLASS_SCHEME_TYP_BIZ_ITEM_CLASS*/'01'	-- 商品分類関連マスタ.商品分類体系区分 = [区分値.商品分類体系区分.営業商品分類]
inner join
	m_item_class_dev	micd	-- 商品分類展開マスタ
on
	micd.del_flg					=		/*#CLS_FLAG_OFF*/'00'				-- 商品分類展開マスタ.削除フラグ
and	micd.item_class_scheme_typ		=		micr.item_class_scheme_typ			-- 商品分類展開マスタ.商品分類体系区分 = 商品分類関連マスタ.商品分類体系区分
and	micd.bottom_hier_item_class_id	=		micr.item_class_id					-- 商品分類展開マスタ.最下層商品分類ID = 商品分類関連マスタ.商品分類ID
and	mspop.forwarding_begn_date		between	micd.start_date	and	micd.end_date	-- セール発注製品マスタ.廻送日付開始 between 商品分類展開マスタ.適用開始日 and 商品分類展開マスタ.適用終了日
and	micd.process_date				=		cast(/*shoriYmd*/'20180606'	as	Date)	-- 商品分類展開マスタ.処理日 = システム.業務日付
inner join
	m_store_form_item_sell_cond	msfisc	-- 店舗形態別商品販売条件マスタ
on
	msfisc.del_flg			=	/*#CLS_FLAG_OFF*/'00'	-- 店舗形態別商品販売条件マスタ.削除フラグ
and	msfisc.item_id			=	miem.item_id			-- 店舗形態別商品販売条件マスタ.商品ID = 商品マスタ.商品ID
and	msfisc.item_end_date	=	miem.end_date			-- 店舗形態別商品販売条件マスタ.商品適用終了日 = 商品マスタ.適用終了日
inner join
	m_product	mpct	-- 製品マスタ
on
	mpct.del_flg	=	/*#CLS_FLAG_OFF*/'00'	-- 製品マスタ.削除フラグ
and	mpct.product_id	=	mspop.product_id		-- 製品マスタ.製品ID = セール発注製品マスタ.製品ID
inner join
	m_product_generation	mpgn	-- 製品世代マスタ
on
	mpgn.del_flg				=		/*#CLS_FLAG_OFF*/'00'				-- 製品世代マスタ.削除フラグ
and	mpgn.product_id				=		msle.sale_id						-- 製品世代マスタ.製品ID = セールマスタ.製品ID
and	mspop.forwarding_begn_date	between	mpgn.start_date	and	mpgn.end_date	-- セール発注製品マスタ廻送日付開始 between 製品世代マスタ.適用開始日 and 製品世代マスタ.適用終了日
and	mpgn.part_no				!=		'000'								-- 製品世代マスタ.品番 ≠ [000]
and	mpgn.biz_cd					!=		/*#CLS_BIZ_CD_TYP_WIDE_AREA*/'12'	-- 製品世代マスタ.業務コード <> [区分値.業務コード区分.広域]
inner join
	m_supplier	mser	-- 仕入先マスタ
on
	mspop.del_flg					=		/*#CLS_FLAG_OFF*/'00'							-- セール発注製品マスタ廻送日付開始.削除フラグ
and	mspop.forwarding_begn_date		between	mser.start_date	and	mser.end_date				-- セール発注製品マスタ廻送日付開始 between 仕入先マスタ.適用開始日 and 仕入先マスタ.適用終了日
and	mser.district_typ				=		mpct.district_typ								-- 仕入先マスタ.地区区分 = 製品マスタ.地区区分
and	mser.biz_cd						=		mpgn.biz_cd										-- 仕入先マスタ.業務コード = 製品世代マスタ.業務コード
and	mser.store_pur_order_stop_flg	=		/*#CLS_STORE_PUR_ORDER_STOP_FLG_NOT_STOP*/'00'	-- 仕入先マスタ.店舗発注停止フラグ = [区分値.店舗発注停止フラグ.停止しない]
inner join
	m_calendar_by_supplier	mcbs	-- 仕入先別カレンダーマスタ
on
	mcbs.del_flg		=	/*#CLS_FLAG_OFF*/'00'		-- 仕入先別カレンダーマスタ.削除フラグ
and	mcbs.supplier_cd	=	mser.supplier_cd			-- 仕入先別カレンダーマスタ.仕入先コード = 仕入先マスタ.仕入先コード
and	mcbs.ymd			=	mspop.forwarding_begn_date	-- 仕入先別カレンダーマスタ.年月日 = セール発注製品マスタ.廻送日付開始
inner join
	m_store	msre	-- 店舗マスタ
on
	mspop.del_flg				=		/*#CLS_FLAG_OFF*/'00'				-- 店舗マスタ.削除フラグ
and	mspop.forwarding_begn_date	between	msre.start_date	and	msre.end_date	-- セール発注製品マスタ廻送日付開始 between 店舗マスタ.適用開始日 and 店舗マスタ.適用終了日
inner join
	m_ship_to_generation	mstg	-- 出荷先世代マスタ
on
	mstg.del_flg				=		/*#CLS_FLAG_OFF*/'00'				-- 出荷先世代マスタ.削除フラグ
and	mstg.ship_to_id				=		msre.ship_to_id						-- 出荷先世代マスタ.出荷先ID = 店舗マスタ.出荷先ID
and	mspop.forwarding_begn_date	between	mstg.start_date	and	mstg.end_date	-- セール発注製品世代マスタ.廻送日付開始 between 出荷先世代マスタ.適用開始日 and 出荷先マスタ.適用終了日
and	mstg.district_typ			=		mpct.district_typ					-- 出荷先世代マスタ.地区区分 = 製品マスタ.地区区分
and	(
		case
			when
				substring(mpgn.handling_flg, 1, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 1, 1)
			else
				substring(mstg.handling_flg, 1, 1)
		end
	)							=		substring(mstg.handling_flg, 1, 1)	-- (case when 製品世代マスタ.取扱フラグ(1桁目) = "1" then 製品世代マスタ.取扱フラグ(1桁目) else 出荷先世代マスタ.取扱フラグ(1桁目) end) = 出荷先世代マスタ.取扱フラグ(1桁目) -- 洋菓子
and	(
		case
			when
				substring(mpgn.handling_flg, 2, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 2, 1)
			else
				substring(mstg.handling_flg, 2, 1)
		end
	)							=		substring(mstg.handling_flg, 2, 1)	-- (case when 製品世代マスタ.取扱フラグ(2桁目) = "1" then 製品世代マスタ.取扱フラグ(2桁目) else 出荷先世代マスタ.取扱フラグ(2桁目) end) = 出荷先世代マスタ.取扱フラグ(2桁目) -- 特殊
and	(
		case
			when
				substring(mpgn.handling_flg, 3, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 3, 1)
			else
				substring(mstg.handling_flg, 3, 1)
		end
	)							=		substring(mstg.handling_flg, 3, 1)	-- (case when 製品世代マスタ.取扱フラグ(3桁目) = "1" then 製品世代マスタ.取扱フラグ(3桁目) else 出荷先世代マスタ.取扱フラグ(3桁目) end) = 出荷先世代マスタ.取扱フラグ(3桁目) -- アイス
and	(
		case
			when
				substring(mpgn.handling_flg, 4, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 4, 1)
			else
				substring(mstg.handling_flg, 4, 1)
		end
	)							=		substring(mstg.handling_flg, 4, 1)	-- (case when 製品世代マスタ.取扱フラグ(4桁目) = "1" then 製品世代マスタ.取扱フラグ(4桁目) else 出荷先世代マスタ.取扱フラグ(4桁目) end) = 出荷先世代マスタ.取扱フラグ(4桁目) -- ＦＦ
and	(
		case
			when
				substring(mpgn.handling_flg, 5, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 5, 1)
			else
				substring(mstg.handling_flg, 5, 1)
		end
	)							=		substring(mstg.handling_flg, 5, 1)	-- (case when 製品世代マスタ.取扱フラグ(5桁目) = "1" then 製品世代マスタ.取扱フラグ(5桁目) else 出荷先世代マスタ.取扱フラグ(5桁目) end) = 出荷先世代マスタ.取扱フラグ(5桁目) -- ＢＯ
and	(
		case
			when
				substring(mpgn.handling_flg, 6, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 6, 1)
			else
				substring(mstg.handling_flg, 6, 1)
		end
	)							=		substring(mstg.handling_flg, 6, 1)	-- (case when 製品世代マスタ.取扱フラグ(6桁目) = "1" then 製品世代マスタ.取扱フラグ(6桁目) else 出荷先世代マスタ.取扱フラグ(6桁目) end) = 出荷先世代マスタ.取扱フラグ(6桁目) -- ＣＫ
and	(
		case
			when
				substring(mpgn.handling_flg, 7, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 7, 1)
			else
				substring(mstg.handling_flg, 7, 1)
		end
	)							=		substring(mstg.handling_flg, 7, 1)	-- (case when 製品世代マスタ.取扱フラグ(7桁目) = "1" then 製品世代マスタ.取扱フラグ(7桁目) else 出荷先世代マスタ.取扱フラグ(7桁目) end) = 出荷先世代マスタ.取扱フラグ(7桁目) -- キャンチョコ
and	(
		case
			when
				substring(mpgn.handling_flg, 8, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 8, 1)
			else
				substring(mstg.handling_flg, 8, 1)
		end
	)							=		substring(mstg.handling_flg, 8, 1)	-- (case when 製品世代マスタ.取扱フラグ(8桁目) = "1" then 製品世代マスタ.取扱フラグ(8桁目) else 出荷先世代マスタ.取扱フラグ(8桁目) end) = 出荷先世代マスタ.取扱フラグ(8桁目) -- 資材
and	(
		case
			when
				substring(mpgn.handling_flg, 17, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 17, 1)
			else
				substring(mstg.handling_flg, 17, 1)
		end
	)							=		substring(mstg.handling_flg, 17, 1)	-- (case when 製品世代マスタ.取扱フラグ(17桁目) = "1" then 製品世代マスタ.取扱フラグ(17桁目) else 出荷先世代マスタ.取扱フラグ(17桁目) end) = 出荷先世代マスタ.取扱フラグ(17桁目) -- ＲＣ専用
and	(
		case
			when
				substring(mpgn.handling_flg, 18, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 18, 1)
			else
				substring(mstg.handling_flg, 18, 1)
		end
	)							=		substring(mstg.handling_flg, 18, 1)	-- (case when 製品世代マスタ.取扱フラグ(18桁目) = "1" then 製品世代マスタ.取扱フラグ(18桁目) else 出荷先世代マスタ.取扱フラグ(18桁目) end) = 出荷先世代マスタ.取扱フラグ(18桁目) -- ＦＣ専用
and	(
		case
			when
				substring(mpgn.handling_flg, 19, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 19, 1)
			else
				substring(mstg.handling_flg, 19, 1)
		end
	)							=		substring(mstg.handling_flg, 19, 1)	-- (case when 製品世代マスタ.取扱フラグ(19桁目) = "1" then 製品世代マスタ.取扱フラグ(19桁目) else 出荷先世代マスタ.取扱フラグ(19桁目) end) = 出荷先世代マスタ.取扱フラグ(19桁目) -- 特売専用
and	(
		case
			when
				substring(mpgn.handling_flg, 20, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 20, 1)
			else
				substring(mstg.handling_flg, 20, 1)
		end
	)							=		substring(mstg.handling_flg, 20, 1)	-- (case when 製品世代マスタ.取扱フラグ(20桁目) = "1" then 製品世代マスタ.取扱フラグ(20桁目) else 出荷先世代マスタ.取扱フラグ(20桁目) end) = 出荷先世代マスタ.取扱フラグ(20桁目) -- 売場
and	(
		case
			when
				substring(mpgn.handling_flg, 21, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 21, 1)
			else
				substring(mstg.handling_flg, 21, 1)
		end
	)							=		substring(mstg.handling_flg, 21, 1)	-- (case when 製品世代マスタ.取扱フラグ(21桁目) = "1" then 製品世代マスタ.取扱フラグ(21桁目) else 出荷先世代マスタ.取扱フラグ(21桁目) end) = 出荷先世代マスタ.取扱フラグ(21桁目) -- 食堂
and	(
		case
			when
				substring(mpgn.handling_flg, 22, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 22, 1)
			else
				substring(mstg.handling_flg, 22, 1)
		end
	)							=		substring(mstg.handling_flg, 22, 1)	-- (case when 製品世代マスタ.取扱フラグ(22桁目) = "1" then 製品世代マスタ.取扱フラグ(22桁目) else 出荷先世代マスタ.取扱フラグ(22桁目) end) = 出荷先世代マスタ.取扱フラグ(22桁目) -- 店内製造A
and	(
		case
			when
				substring(mpgn.handling_flg, 23, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 23, 1)
			else
				substring(mstg.handling_flg, 23, 1)
		end
	)							=		substring(mstg.handling_flg, 23, 1)	-- (case when 製品世代マスタ.取扱フラグ(23桁目) = "1" then 製品世代マスタ.取扱フラグ(23桁目) else 出荷先世代マスタ.取扱フラグ(23桁目) end) = 出荷先世代マスタ.取扱フラグ(23桁目) -- 店内製造B
and	(
		case
			when
				substring(mpgn.handling_flg, 24, 1)	=	'1'
			then
				substring(mpgn.handling_flg, 24, 1)
			else
				substring(mstg.handling_flg, 24, 1)
		end
	)							=		substring(mstg.handling_flg, 24, 1)	-- (case when 製品世代マスタ.取扱フラグ(24桁目) = "1" then 製品世代マスタ.取扱フラグ(24桁目) else 出荷先世代マスタ.取扱フラグ(24桁目) end) = 出荷先世代マスタ.取扱フラグ(24桁目) -- ファミリークラブ
inner join
	m_regi_data_store	mrds	-- レジデータ店舗マスタ
on
	mrds.del_flg				=		/*#CLS_FLAG_OFF*/'00'				-- レジデータ店舗マスタ.削除フラグ
and	mrds.register_data_store_id	=		msre.store_id						-- レジデータ店舗マスタ.レジデータ店舗ID = 店舗マスタ.レジデータ店舗ID
and	mspop.forwarding_begn_date	between	mrds.start_date	and	mrds.end_date	-- セール発注製品世代マスタ.廻送日付開始 between レジデータ店舗マスタ.適用開始日 and レジデータ店舗マスタ.適用終了日
inner join
	m_org	morg	-- 組織マスタ
on
	morg.del_flg				=		/*#CLS_FLAG_OFF*/'00'				-- 組織マスタ.削除フラグ
and	morg.org_id					=		msre.record_dest_org_id				-- 組織マスタ.組織ID = 店舗マスタ.計上先組織ID
and	mspop.forwarding_begn_date	between	morg.start_date	and	morg.end_date	-- セール発注製品世代マスタ.廻送日付開始 between 組織マスタ.適用開始日 and 組織マスタ.適用終了日
and	morg.store_form_cd			=		msfisc.store_form_cd				-- 組織マスタ.店舗形態コード = 店舗形態別商品販売条件マスタ.店舗形態コード
and	morg.org_discont_flg		=		/*#CLS_ORG_DISCONT_FLG_ACTIVE*/'00'	-- 組織マスタ.組織廃止フラグ = [区分値.組織廃止フラグ.活動中]
where
	msle.del_flg							=	/*#CLS_FLAG_OFF*/'00'		-- セールマスタ.削除フラグ
and	cast(/*shoriYmd*/'20180606'	as	Date)	<=	msle.last_ref_possible_date	-- 業務日付 <= セールマスタ.最終参照可能日
group by
	msre.store_id				-- 店舗マスタ.店舗ID
,	msle.sale_id				-- セールマスタ.セールID
,	mpct.product_id				-- 製品マスタ.製品ID
,	mspop.forwarding_begn_date	-- セール発注製品マスタ.廻送日付開始
