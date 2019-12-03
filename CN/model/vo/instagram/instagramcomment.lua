slot0 = class("InstagramComment", import("..BaseVO"))

slot0.Ctor = function (slot0, slot1, slot2, slot3)
	slot0.time = slot1.time
	slot0.text = slot1.text
	slot0.instagram = slot2
	slot0.parentComment = slot3
	slot0.id = slot1.id
	slot0.isRoot = false

	if not slot0.parentComment then
		slot0.isRoot = true
	end

	slot0.allReply = slot2:GetAllReply()
	slot0.replyList = {}
end

slot0.GetLasterUpdateTime = function (slot0)
	slot1 = {}

	slot2(slot0.time)

	for slot6, slot7 in pairs(slot0.replyList) do
		slot2(slot7.time)
	end

	table.sort(slot1, function (slot0, slot1)
		return slot1 < slot0
	end)

	return slot1[1] or 0
end

slot0.GetName = function (slot0)
	return
end

slot0.GetPainting = function (slot0)
	return
end

slot0.GetType = function (slot0)
	return
end

slot0.GetFasterRefreshTime = function (slot0)
	slot1 = {}

	if slot0:ShouldWaitForShow() then
		table.insert(slot1, slot0.time)
	end

	for slot5, slot6 in ipairs(slot0.replyList) do
		if slot6:ShouldWaitForShow() then
			table.insert(slot1, slot6.time)
		end
	end

	if #slot1 > 0 then
		table.sort(slot1, function (slot0, slot1)
			return slot0 < slot1
		end)

		return slot1[1]
	end
end

slot0.AnyReplyTimeOut = function (slot0)
	return _.any(slot0.replyList, function (slot0)
		return slot0:TimeOutAndTxtIsEmpty()
	end) or slot0:TimeOutAndTxtIsEmpty()
end

slot0.TimeOutAndTxtIsEmpty = function (slot0)
	return slot0.time <= pg.TimeMgr.GetInstance():GetServerTime() and slot0.text == ""
end

slot0.ShouldWaitForShow = function (slot0)
	return pg.TimeMgr.GetInstance():GetServerTime() < slot0.time or slot0:TimeOutAndTxtIsEmpty()
end

slot0.GetReplyTimeOffset = function (slot0)
	return slot0.time - pg.TimeMgr.GetInstance():GetServerTime()
end

slot0.GetReplyList = function (slot0)
	return slot0.replyList
end

slot0.GetCanDisplayReply = function (slot0)
	slot1 = {}
	slot2 = 0

	for slot6, slot7 in ipairs(slot0.replyList) do
		if not slot7:ShouldWaitForShow() then
			table.insert(slot1, slot7)

			slot2 = slot2 + 1
		end
	end

	return slot1, slot2
end

slot0.GetParentCommentName = function (slot0)
	return slot0.parentComment:GetName()
end

slot0.HasReply = function (slot0)
	return _.any(slot0.replyList, function (slot0)
		return not slot0:ShouldWaitForShow()
	end) and #slot0.replyList > 0
end

slot0.GetContent = function (slot0)
	slot1 = slot0:GetName()

	if slot0.isRoot then
		return string.format("<color=#000000FF>%s.</color>%s", slot1, slot0.text)
	else
		slot2 = slot0:GetParentCommentName()

		return string.format("<color=#000000FF>%s.</color>%s", slot1, slot0.text)
	end
end

slot0.GetReplyCnt = function (slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0.replyList) do
		if not slot6:ShouldWaitForShow() then
			slot1 = slot1 + 1
		end
	end

	return slot1
end

slot0.GetTime = function (slot0)
	return InstagramReplyTimeStamp(slot0.time) .. " reply"
end

slot0.GetIcon = function (slot0)
	return slot0:GetPainting()
end

slot0.GetReplyBtnTxt = function (slot0)
	return "reply"
end

return slot0