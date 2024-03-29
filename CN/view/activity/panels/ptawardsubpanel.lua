slot0 = class("PtAwardSubPanel", import("view.base.BaseSubPanel"))

function slot0.GetUIName(slot0)
	return "ActivitybonusWindow_btnVer"
end

function slot0.OnInit(slot0)
	slot0.UIlist = UIItemList.New(slot0._tf:Find("window/panel/list"), slot0._tf:Find("window/panel/list/item"))
	slot0.totalTxt = slot0._tf:Find("window/pt/Text"):GetComponent(typeof(Text))
	slot0.totalTitleTxt = slot0._tf:Find("window/pt/title"):GetComponent(typeof(Text))
	slot0.closeBtn = slot0._tf:Find("window/top/btnBack")
	slot0.btn_banned = slot0._tf:Find("window/btn_banned")
	slot0.btn_get = slot0._tf:Find("window/btn_get")
	slot0.btn_got = slot0._tf:Find("window/btn_got")

	onButton(slot0, slot0._tf:Find("bg_dark"), function ()
		slot0:Hide()
	end, SFX_PANEL)
	onButton(slot0, slot0.closeBtn, function ()
		slot0:Hide()
	end, SFX_PANEL)
	onButton(slot0, slot0.btn_get, function ()
		slot2, slot5.arg1 = slot0.ptData:GetResProgress()

		slot0:emit(ActivityMediator.EVENT_PT_OPERATION, {
			cmd = 1,
			activity_id = slot0.ptData:GetId(),
			arg1 = slot1
		})
	end, SFX_PANEL)
end

function slot0.UpdateView(slot0, slot1)
	slot0.ptData = slot1
	slot2 = slot1.dropList
	slot3 = slot1.targets
	slot4 = slot1.level
	slot5 = slot1.count
	slot7 = pg.item_data_statistics[id2ItemId(slot1.resId)].name

	if slot1.type == 2 then
		slot0.cntTitle = i18n("pt_total_count", i18n("pt_cosume", slot7))
		slot0.resTitle = i18n("pt_count", i18n("pt_cosume", slot7))
	else
		slot0.cntTitle = i18n("pt_total_count", slot7)
		slot0.resTitle = i18n("pt_count", slot7)
	end

	setActive(slot0.btn_get, slot9)
	setActive(slot0.btn_banned, not slot0.ptData:CanGetAward())
	slot0:UpdateList(slot2, slot3, slot4, slot0.ptData:GetBossProgress())
	Canvas.ForceUpdateCanvases()
end

function slot0.UpdateList(slot0, slot1, slot2, slot3)
	slot0.UIlist:make(function (slot0, slot1, slot2)
		if slot0 == UIItemList.EventUpdate then
			setText(slot2:Find("title/Text"), "PHASE " .. slot1 + 1)
			setText(slot2:Find("target/Text"), slot4)
			setText(slot2:Find("target/title"), slot2.resTitle)
			updateDrop(slot2:Find("award"), slot5, {
				hideName = true
			})
			onButton(slot2, slot2:Find("award"), function ()
				slot0:emit(BaseUI.ON_DROP, slot0)
			end, SFX_PANEL)
			setActive(slot2:Find("award/mask"), slot1 + 1 <= slot0[slot1 + 1])
		end
	end)
	slot0.UIlist:align(#slot1)
end

return slot0
