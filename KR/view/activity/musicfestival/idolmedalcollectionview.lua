slot0 = class("IdolMedalCollectionView", import("view.base.BaseUI"))
slot0.FADE_OUT_TIME = 1
slot0.PAGE_NUM = 5
slot0.MEDAL_NUM_PER_PAGE = 3

function slot0.getUIName(slot0)
	return "IdolMedalCollectionUI"
end

function slot0.init(slot0)
	slot0:initData()
	slot0:findUI()
	slot0:addListener()
end

function slot0.didEnter(slot0)
	slot0:checkAward()
	setText(slot0.progressText, setColorStr(tostring(#slot0.activeIDList), COLOR_RED) .. "/" .. #slot0.allIDList)
	triggerToggle(slot0.switchBtnList[1], true)
end

function slot0.willExit(slot0)
	return
end

function slot0.initData(slot0)
	slot0.activityProxy = getProxy(ActivityProxy)
	slot0.activityData = slot0.activityProxy:getActivityById(ActivityConst.IDOL_MEDAL_COLLECTION)
	slot0.allIDList = slot0.activityData:getConfig("config_data")
	slot0.pageIDList = {}

	for slot4 = 1, slot0.PAGE_NUM, 1 do
		slot0.pageIDList[slot4] = {}

		for slot8 = 1, slot0.MEDAL_NUM_PER_PAGE, 1 do
			slot0.pageIDList[slot4][slot8] = slot0.allIDList[(slot4 - 1) * slot0.MEDAL_NUM_PER_PAGE + slot8]
		end
	end

	slot0.activatableIDList = slot0.activityData.data1_list
	slot0.activeIDList = slot0.activityData.data2_list
	slot0.curPage = nil
	slot0.newMedalID = nil
end

function slot0.findUI(slot0)
	slot0.bg = slot0:findTF("BG")
	slot1 = slot0:findTF("NotchAdapt")
	slot0.backBtn = slot0:findTF("BackBtn", slot1)
	slot0.progressText = slot0:findTF("ProgressImg/ProgressText", slot1)
	slot0.helpBtn = slot0:findTF("HelpBtn", slot1)
	slot2 = slot0:findTF("MedalContainer")
	slot0.medalItemList = {
		slot0:findTF("Medal1", slot2),
		slot0:findTF("Medal2", slot2),
		slot0:findTF("Medal3", slot2)
	}
	slot3 = slot0:findTF("SwitchBtnList", slot1)
	slot0.switchBtnList = {}

	for slot7 = 1, 5, 1 do
		slot0.switchBtnList[slot7] = slot0:findTF("Button" .. slot7, slot3)
	end
end

function slot0.addListener(slot0)
	onButton(slot0, slot0.backBtn, function ()
		slot0:closeView()
	end, SFX_CANCEL)
	onButton(slot0, slot0.helpBtn, function ()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			type = MSGBOX_TYPE_HELP,
			helps = pg.gametip.music_collection.tip
		})
	end, SFX_PANEL)

	for slot4, slot5 in ipairs(slot0.switchBtnList) do
		onToggle(slot0, slot5, function (slot0)
			if slot0 == true then
				slot0.curPage = slot0

				slot0:updateSwitchBtnTF()
				slot0:updateMedalContainerView(slot0.updateMedalContainerView)
			end
		end, SFX_PANEL)
	end

	addSlip(SLIP_TYPE_HRZ, slot0.bg, function ()
		if slot0.curPage > 1 then
			triggerToggle(slot0.switchBtnList[slot0.curPage - 1], true)
		else
			return
		end
	end, function ()
		if slot0.curPage < slot1.PAGE_NUM then
			triggerToggle(slot0.switchBtnList[slot0.curPage + 1], true)
		else
			return
		end
	end)
end

function slot0.updateMedalContainerView(slot0, slot1)
	for slot6, slot7 in ipairs(slot2) do
		slot0:updateMedalView(slot2, slot7)
	end
end

function slot0.updateMedalView(slot0, slot1, slot2)
	slot3 = table.indexof(slot1, slot2, 1)
	slot4 = table.contains(slot0.activeIDList, slot2)

	setActive(slot8, slot4)
	setActive(slot9, table.contains(slot0.activatableIDList, slot2) and not slot4)
	setActive(slot0:findTF("DisActive", slot7), not slot4 and not (table.contains(slot0.activatableIDList, slot2) and not slot4))

	if slot0:findTF("Active", slot7) then
		setImageSprite(slot8, GetSpriteFromAtlas("ui/musicfestivalmedalcollectionui_atlas", tostring(slot2)))
	end

	if slot5 then
		onButton(slot0, slot9, function ()
			pg.m02:sendNotification(GAME.MEMORYBOOK_UNLOCK, {
				id = slot0,
				actId = ActivityConst.IDOL_MEDAL_COLLECTION
			})
		end, SFX_PANEL)
	end

	if slot6 then
		setText(slot10, slot0.activityData:getConfig("config_client").unlock_desc[table.indexof(slot0.allIDList, slot2, 1)])
	end
end

function slot0.updateSwitchBtnTF(slot0)
	for slot4, slot5 in ipairs(slot0.switchBtnList) do
		slot7 = slot0:findTF("Text", slot6)

		if slot0:caculateActivatable(slot4) == 0 or slot4 == slot0.curPage then
			setActive(slot6, false)
		end

		if slot8 > 0 and slot4 ~= slot0.curPage then
			setActive(slot6, true)
			setText(slot7, slot8)
		end
	end
end

function slot0.updateAfterSubmit(slot0, slot1)
	slot0.activityProxy = getProxy(ActivityProxy)
	slot0.activityData = slot0.activityProxy:getActivityById(ActivityConst.IDOL_MEDAL_COLLECTION)
	slot0.activatableIDList = slot0.activityData.data1_list
	slot0.activeIDList = slot0.activityData.data2_list
	slot0.newMedalID = slot1

	triggerToggle(slot0.switchBtnList[slot0.curPage], true)
	setText(slot0.progressText, setColorStr(tostring(#slot0.activeIDList), COLOR_RED) .. "/" .. #slot0.allIDList)
	slot0:checkAward()
end

function slot0.isHaveActivableMedal()
	if not getProxy(ActivityProxy):getActivityById(ActivityConst.IDOL_MEDAL_COLLECTION) or slot0:isEnd() then
		return
	end

	slot1 = slot0.data1_list
	slot2 = slot0.data2_list

	for slot7, slot8 in ipairs(slot3) do
		slot10 = table.contains(slot1, slot8)

		if not table.contains(slot2, slot8) and slot10 then
			return true
		end
	end

	return false
end

function slot0.caculateActivatable(slot0, slot1)
	slot3 = 0

	for slot7, slot8 in ipairs(slot2) do
		slot10 = table.contains(slot0.activatableIDList, slot8)

		if not table.contains(slot0.activeIDList, slot8) and slot10 then
			slot3 = slot3 + 1
		end
	end

	return slot3
end

function slot0.checkAward(slot0)
	if #slot0.activeIDList == #slot0.allIDList and slot0.activityData.data1 ~= 1 then
		print("发消息去领最终奖励")
		pg.m02:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = ActivityConst.IDOL_MEDAL_COLLECTION
		})
	end
end

return slot0
